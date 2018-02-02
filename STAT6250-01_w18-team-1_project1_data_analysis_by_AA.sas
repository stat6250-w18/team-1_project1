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
'Based on the above output, there are no states where female homicide victims outnumber male homicide victims.'
;

footnote3
'Based on gender profiling of homicide victims, states should take effective measures to curtail male homicides.'
;

footnote4
'Based on the above output, California ranks highest with the most number of male as well as female homicide victims.'
;

footnote5
'Further analysis is required to understand why in certain states the gender of homicide victims is unknown.'
;
*
Methodology: Use PROC FREQ to calculate the frequency of the homicide victims 
in regards to Victim_Sex by State. Also, use PROC PRINT to print the top 5 
states with maximum male and female homicide victims.

Limitations: This methodology does not account for states with missing data,
nor does it attempt to validate data in any way. 


Possible Follow-up Steps: We need to also consider this statistics in relation
to the population of males/females in the states in terms of percentage. That 
would shed more insights into profiling homicide victims per state based on 
sex.
;
proc freq
        data=homicide_analytic_file
    ;
    table
        Victim_Sex*State 
        / missing norow nocol
    ;
run;

proc print
    data=homicide_freq_sex_M(obs=5)
    ; 
run;

proc print
    data=homicide_freq_sex_F(obs=5)
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

Possible Follow-up Steps: We need to also consider this statistics in relation
to the population of infants in the states in terms of percentage. That would 
shed more information/insights into the infant homicide victims per state.
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
		out=homicide_analytic_file_infant
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
'Based on the output, the most number of homicide victims are likely to be white(54.49%), followed by black(42.65%).'
;

footnote2
'About 60% of the total homicide victims combining all states are of Non-Hispanic ethnicity.'
;
*
Methodology: Use PROC FREQ to calculate the frequency of the homicide victims
in regards to Victim_Race and Victim_Ethnicity by State. Also, use PROC PRINT 
to print the top 5 states with maximum white, black, Non-Hispanic homicide 
victims.

Limitations: This methodology does not account for states with missing data,
nor does it attempt to validate data in any way.

Possible Follow-up Steps: We need to also consider this statistics in relation
to total black, white and Non-Hispanic population in the states in terms of 
percentage. That would shed more insights into profiling homicide victims per
state based on race and ethnicity.
;
proc freq
        data=homicide_analytic_file
    ;
    tables
        Victim_Race*State 
        Victim_Ethnicity*State
        / missing norow nocol
    ;
run;

proc print
    data=homicide_freq_victim_white(obs=5)
    ; 
run;

proc print
    data=homicide_freq_victim_black(obs=5)
    ; 
run;

proc print
    data=homicide_freq_victim_nonhispanic(obs=5)
    ; 
run;
title;
footnote;