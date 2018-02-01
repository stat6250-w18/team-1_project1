
*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
This file prepares the dataset described below for analysis.

[Dataset Name] Homicide Reports, 1980-2014

[Experimental Units] Homicide Case

[Number of Observations] 638,455

[Number of Features] 24

[Data Source] The file 
https://www.kaggle.com/murderaccountability/homicide-reports/downloads/
database.csv was downloaded and edited to produce file Homicide_Dataset.xlsx 
by deleting 521895 rows from worksheet "database",reformatting column headers 
in "database" to remove characters disallowed in SAS variable names, and 
setting all cell values to "Text" format.

[Data Dictionary] 
Record ID: Dataset unique identifier
Agency Code/Name/Type: Law enforcement Agency who handled the case
State/City: State and County of the reported homicide
Year/Month: Time stamp for the occurrence of the homicide
Incident: Number of offenses committed by the same offender(s) at the same 
time and place
Crime Type: Murder, Manslaughter or Negligence designated to case
Crime Solved: Conveys whether the case has been solved or not
Victim Sex/Age/Race/Ethnicity: Victim profile
Perpetrator Sex/Age/Race/Ethnicity: Perpetrator profile
Relationship: The perpetrators relation to the victim
Weapon: Weapon used to commit homicide
Victim Count: Number of additional injured victims
Perpetrator Count: Number of additional offenders involved in homicide
Record Source: Database source from either FBI or FOIA

[Unique ID] The column "Record ID" is a primary key
;


* environmental setup;


* setup environmental parameters;
%let inputDatasetURL =
https://github.com/stat6250/team-1_project1/blob/master/Homicide_Dataset.xlsx?raw=true
;


* load raw homicide dataset over the wire;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile "%sysfunc(getoption(work))/tempfile.xlsx";
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;

%loadDataIfNotAlreadyAvailable(
    homicide_raw,
    &inputDatasetURL.,
    xlsx
)


* check raw homicide dataset for duplicates with respect to its primary key;
proc sort
    nodupkey
    data=homicide_raw
    dupout=homicide_raw_dups
    out=_null_
    ;
    by
        Record_ID
    ;
run;


* build analytic dataset from FRPM dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data homicide_analytic_file;
    retain
        Record_ID
        Agency_Code
        Agency_Name
        Agency_Type
        City
        State
        Year
        Month
        Incident
        Crime_Type
        Crime_Solved
        Victim_Sex
        Victim_Age
        Victim_Race
        Victim_Ethnicity
        Perpetrator_Sex
        Perpetrator_Age
        Perpetrator_Race
        Perpetrator_Ethnicity
        Relationship
        Weapon
    ;
    keep
        Record_ID
        Agency_Code
        Agency_Name
        Agency_Type
        City
        State
        Year
        Month
        Incident
        Crime_Type
        Crime_Solved
        Victim_Sex
        Victim_Age
        Victim_Race
        Victim_Ethnicity
        Perpetrator_Sex
        Perpetrator_Age
        Perpetrator_Race
        Perpetrator_Ethnicity
        Relationship
        Weapon
    ;
    set homicide_raw;
run;
