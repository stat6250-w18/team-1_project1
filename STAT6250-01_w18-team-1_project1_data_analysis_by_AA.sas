*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding the homicide cases reported between 1980-2014

Dataset Name: homicide_analytic_file created in external file
STAT6250-01_w18-team-1_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";


* load external file that generates analytic dataset homicide_analytic_file;
%include '.\STAT6250-01_w18-team-1_project1_data_preparation.sas';



title1
'Research Question: What is the distribution of the homicides in regards to the sex of victims by state?'
;

title2
'Rationale: It would help in better gender profiling of the homicide victims.'
;

footnote1
'Based on the above output, combining all states, males are more likely to be homicide victims(almost 77%)'
;

footnote2
'Based on the above output, there are no states where the states where female homicide victims outnumber male homicide victims.'
;

footnote2
'Based on gender profiling of homicide victims, states should take effective measures to curtail male homicides.'
;

footnote3
'Based on the above output, California ranks highest with the most number of male as well as female homicide victims.'
;

footnote4
'Based on the above output, Maine(85%) and North Dakota(71%) have the highest percentage of female homicide victims among all states'
;

footnote5
'Further analysis is required to understand why is certain states the gender of homicide victims is unknown.'
;
*
Methodology: Use PROC FREQ to calculate the frequency of the homicide victims in
regards to Victim_Sex by State.

Limitations: This methodology does not account for states with missing data,
nor does it attempt to validate data in any way. 


Possible Follow-up Steps: More carefully clean the values of the variable
Victim_Age so that the statistics computed do not include any
possible illegal values, and better handle missing data.
;
proc freq
        data=homicide_analytic_file
    ;
    table
        Victim_Sex*State
        / missing norow nocol nopercent
    ;
run;
title;
footnote;



title1
'Research Question: What is the distribution of the homicides in regards to the minimum age of the victim per state?'
;

title2
'Rationale: This would help identify the states having maximum homicide victims as new born/infants'
;

footnote1
'Based on the above output, California has the highest number(18,115) of homicide victims as new born/infants(age 0).'
;

footnote2
'Based on the above output, New York(11,484) and Texas(11,103) rank second and third with the highest number of homicides victims as new born/infants(age 0).'
;

footnote3
"Except, West Virginia which has the minimum homicide victim age as 1, minimum victim age is 0 for all other states."
;

*
Methodology: Compute PROC MEANS(MIN) by class State and Victim_Age variable

Limitations: This methodology does not account for states with missing data,
nor does it attempt to validate data in any way.

Possible Follow-up Steps: More carefully clean the values of the variable
Victim_Age so that the statistics computed do not include any
possible illegal values, and better handle missing data.
;
proc means
    min
    data=homicide_analytic_file
    ;
    class
        State
    ;
    var
        Victim_Age
	;
	output
		out=homicide_analytic_file_temp
    ;
run;
title;
footnote;



title1
'Research Question: What is the distribution of the homicides in regards to the race/ethnicity of victims by state?'
;

title2
'Rationale: It would help in better profiling of the homicide victims in various states.'
;

footnote1
"Based on the output, the most number of homicide victims are likely to be white, followed by black."
;

footnote2
'Among all states, California has the highest number of white homicide victims(12056) follwed by Texas(7666)'
;

footnote3
'mong all states, California and New York have the highest number of black homicide victims(5216)'
;

footnote4
'About 60% of the total homicide victims combining all states are of Non-Hispanic ethnicity.'
;

footnote5
'There are a large number of homicide victims (31072)whose ethnicity is unknown.'
;
*
Methodology: Use PROC FREQ to calculate the frequency of the homicide victims
in regards to Victim_Race Victim_Ethnicity by State.

Limitations: This methodology does not account for states with missing data,
nor does it attempt to validate data in any way.

Possible Follow-up Steps: More carefully clean the values of the variable
Victim_Age so that the statistics computed do not include any
possible illegal values, and better handle missing data.
;
proc freq
        data=homicide_analytic_file
    ;
    tables
        Victim_Race*State 
        Victim_Ethnicity*State
        / missing norow nocol nopercent
    ;
run;
title;
footnote;

