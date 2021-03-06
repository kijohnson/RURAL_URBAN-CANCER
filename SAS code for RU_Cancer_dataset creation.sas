/* PROLOG   ################################################################
   PROJECT: RUCC code/MO cancer analysis 
   PURPOSE: Merged in 2013 RUCC codes with the data from the dataset on github generated by Hannah Padda
   DIR:     The files for this code are all located on Github in the Rural-Urban-Cancer Master Repository: https://github.com/kijohnson/Rural-Urban-Cancer
   DATA:    ruralurbancodes2013.csv, MO IL cancer.sav located at https://github.com/kijohnson/RURAL_URBAN-CANCER
   AUTHOR:  Kim Johnson
   CREATED: 1/21/2018
   LATEST:  1/21/2018
   NOTES:  	Obtained county 2013 RUCC codes from https://www.ers.usda.gov/data-products/rural-urban-continuum-codes/ to analyze the association between M:I ratios and RUCC code
   PROLOG   ############################################################### */


PROC IMPORT OUT= WORK.ru_dataset 
            DATAFILE= "C:\Users\kijohnson\Desktop\Rural-Urban-Cancer-mas
ter\MO IL cancer.sav" 
            DBMS=SPSS REPLACE;

RUN;

PROC IMPORT OUT= WORK.rucc_dataset 
            DATAFILE= "C:\Users\kijohnson\Desktop\Rural-Urban-Cancer-master\ruralurbancodes2013.csv" 
            DBMS=CSV REPLACE;

RUN;

data ruMO_dataset;
set Ru_dataset;
state_c=put(state, 8.);
if state_c ne 0 then delete;
run;

proc sort data=ruMO_dataset;
by FIPS;
run;

data rucc_dataset;
set rucc_dataset;
rename description=descriptionRUCC;
run;

proc sort data=rucc_dataset;
by FIPS;
run;

data RU_Cancer_dataset;
merge ruMO_dataset (in=a) rucc_dataset (keep=RUCC_2013 descriptionRUCC FIPS);
by FIPS;
if a;
run;

PROC EXPORT DATA= WORK.RU_CANCER_DATASET 
            OUTFILE= "C:\Users\kijohnson\Desktop\Rural-Urban-Cancer-mast
er\01212018RUCC_cancer.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;
