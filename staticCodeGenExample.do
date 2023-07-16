// Start Python interpreter
python

# Imports the document class object from the python-docx module from pip
from docx.api import Document

# Imports the pandas library with the alias pd
import pandas as pd

# Imports the regular expression module
import re

# Location where the file is stored
filepath = '/Users/billy/Desktop/Programs/JavaScript/stataConference2023/fs002-19-1.docx'

# Loads the MS Word document into a Document class object
doc = Document(filepath)

# Creates an empty dict to store any of the tables in the document
tables = dict()

# Approach based on function illustrated at:
# https://medium.com/@karthikeyan.eaganathan/read-tables-from-docx-file-to-pandas-dataframes-f7e409401370
for i in range(len(doc.tables)):

    # Gets an individual instance of a table in the MS Word Document
    table = doc.tables[i]

    # Parses the table contents into a list of lists
    data = [[cell.text for cell in row.cells] for row in table.rows]
    
	# Converts to a Pandas DataFrame object
    df = pd.DataFrame(data)
    
	# Assigns the first record as column names and drops the first record
    df = df.rename(columns = df.iloc[0]).drop(df.index[0]).reset_index(drop = True)
    
	# Adds the table to the dict of tables
    tables['table' + str(i)] = df


# Gets the table with the file specification of interest
filespec = tables['table16']

# Recasts the start position to a numeric value
filespec['Start Position'] = filespec['Start Position'].astype('int', copy = False)

# Strips new line characters from data element name and the permitted values columns
filespec['Data Element Name'] = filespec['Data Element Name'].apply(lambda x: re.sub('\n', ' ', x))
filespec['Permitted Values\nAbbreviations'] = filespec['Permitted Values\nAbbreviations'].apply(lambda x: re.sub('\n', '; ', x))
filespec['Definition / Comments'] = filespec['Definition / Comments'].apply(lambda x: re.sub('\n', ' ', x))

# Strips unnecessary info from the type column
filespec['Type'] = filespec['Type'].apply(lambda x: re.sub('\nRevised!', '', x).lower()[:3])

# Renames the columns to Stata friendly names
filespec.columns = ['name', 'start', 'length', 'type', 'pop', 'comments', 'vallab' ]

# Get the column names and types to create Stata variables
varntypes = dict([(i, filespec[i].dtype.name) for i in filespec.columns ])

# Load module for Stata API
from sfi import Data

# Create variables in Stata
{ Data.addVarStrL(k) if v == 'object' else Data.addVarLong(k) for k, v in varntypes.items() }

# Allocate the number of observations
Data.addObs(filespec.shape[0], nofill = True)

# Load the file spec into Stata for further processing
Data.store(None, None, val = filespec.values.tolist())

# Ends the Python interpreter and goes back to Stata
end

// Compress the data 
compress

// Creates generic variable names
g str5 varn = "var" + strofreal(_n)

// Creates the end column value
g int end = start[_n + 1] - 1

// Create stata types based on the type and length values
g str4 statatype = 	cond(type == "int" & real(length) > 5, "long", type)

// Clean up the variables
replace vallab = itrim(trim(vallab))
replace name = itrim(trim(name))
replace comments = itrim(trim(comments))

// Cast the start and end values as strings
tostring start end, replace
					
// Remove carriage return character entry if it just represents the end of the 
// line of data
drop if ustrregexm(name, "(Carriage Return)|(Line Feed)|(CR)|(LF)", 1) & _n == `c(N)'	

// Now build file parser

// Create a file connection for the dictionary file
file open fh using filespec.dct, w t replace

// Create first line
file write fh "infix dictionary using sampleFile.txt {" _n

// Loop over the records in the file specification
forv i = 1/`c(N)' {
	
	// Writes the parsing specification to the file for the variable
	file write fh _tab (statatype[`i']) + " " + (varn[`i']) + " " +			 ///   
						(start[`i']) + "-" + (end[`i']) _n
	
} // End of Loop over specification

// Closes the curly brace 
file write fh "}" _n(2)

// Closes the file connection
file close fh

// Create a second file connection
file open fh using filespec.do, w t replace

// Write the line to parse the file and load into Stata
file write fh "infix using filespec.dct" _n

// Start loop over the file specification to add metadata to the data set
forv i = 1/`c(N)' {
	
	// Adds variable labels
	file write fh ("la var " + "`: di varn[`i']'" + " " +  `""`: di name[`i']'""') _n
	
	// Adds comments as characteristics
	file write fh ("char " + varn[`i'] + "[comments] " + comments[`i']) _n
	
	// Test for value labels being present for the variable
	if ustrregexm(vallab[`i'], "\w\d", 1) {
		
		// If there is something, add it as a characteristic as well
		file write fh ("char " + varn[`i'] + "[decodes] " + vallab[`i']) _n 
		
	} // End IF Block testing for decode values
	
} // End Loop over file specification

// Closes the do file
file close fh
