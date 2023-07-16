infix using filespec.dct
la var var1 "File Record Number"
char var1[comments] A sequential number assigned by the State that is unique to each row entry within the file.
la var var2 "DG559 State Code"
char var2[comments] The two-digit American National Standards Institute (ANSI) code for the state, District of Columbia, and the outlying areas and freely associated areas of the United States.
la var var3 "DG570 State Agency Number"
char var3[comments] A number used to uniquely identify state agencies. This ID cannot be updated through this file.
char var3[decodes] 01 – State Education Agency
la var var4 "DG4 LEA Identifier (State)"
char var4[comments] The identifier assigned to a local education agency (LEA) by the state education agency (SEA). Also known as State LEA Identification Number (ID). This data element cannot be updated through this file.
la var var5 "DG5 School Identifier (State)"
char var5[comments] The identifier assigned to a school by the state education agency (SEA).  Also known as the State School Identification Number (ID).  This ID cannot be updated through this file.
la var var6 "Table Name"
char var6[comments] See technical name in sections 2.2 and 2.3.
la var var7 "Filler"
char var7[comments] Leave filler field blank.
la var var8 "Racial Ethnic"
char var8[comments] The general racial category that most clearly reflects individuals' recognition of their community or with which the individuals most identify.
char var8[decodes] AM7 – American Indian or Alaska Native ; AS7 – Asian ; BL7 – Black or African American ; HI7 – Hispanic/Latino ; PI7 – Native Hawaiian or Other Pacific Islander ; MU7 – Two or more races WH7 – White ; MISSING
la var var9 "Sex (Membership)"
char var9[comments] An indication that students are either female or male.
la var var10 "Filler"
char var10[comments] Leave filler field blank.
la var var11 "Filler"
char var11[comments] Leave filler field blank.
la var var12 "Filler"
char var12[comments] Leave filler field blank.
la var var13 "Filler"
char var13[comments] Leave filler field blank.
la var var14 "Filler"
char var14[comments] Leave filler field blank.
la var var15 "Filler"
char var15[comments] Leave filler field blank.
la var var16 "Disability Category (IDEA)"
char var16[comments] The primary disability as identified in the Individualized Education Program (IEP) or service plan.
la var var17 "Filler"
char var17[comments] Leave filler field blank.
la var var18 "Filler"
char var18[comments] Leave filler field blank.
la var var19 "Age (School Age)"
char var19[comments] The discrete age of children (students) who are school age on the state specified child count date.
char var19[decodes] AGE05K – Age 5 (Kindergarten); 6 – Age 6; 7 – Age 7; 8 – Age 8; 9 – Age 9; 10 – Age 10; 11 – Age 11; 12 – Age 12; 13 – Age 13; 14 – Age 14; 15 – Age 15; 16 – Age 16; 17 – Age 17; 18 – Age 18; 19 – Age 19; 20 – Age 20; 21 – Age 21; MISSING
la var var20 "Educational Environment (IDEA) SA"
char var20[comments] The settings in which school-aged children ages 5 who are in kindergarten through 21 receive special education and related services.
char var20[decodes] RC80 – Inside regular class 80% or more of the day; RC79TO40 – Inside regular class 40% through 79% of the day; RC39 – Inside regular class less than 40% of the day; SS – Separate School ; RF – Residential Facility ; HH – Homebound/Hospital; CF – Correctional Facilities; PPPS – Parentally placed in private schools; MISSING
la var var21 "English Learner Status (Both)"
char var21[comments] An indication of whether students met the definition of an English learner.
la var var22 "Total Indicator"
char var22[comments] An indicator that defines the count level – see tables 2.2-2 and 2.3-2 Required Categories and Totals
la var var23 "Explanation"
char var23[comments] Text field for state use.
la var var24 "Student Count"
char var24[comments] 
