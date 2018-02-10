
*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding homicides in the US from 1980 to 2014

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
'Research Question: What is the distribution of the homicides in regards to the age of perpetrators?'
;

title2
'Rationale: It would help in understanding if juveniles or adults are more likely to be homicide perpetrators.'
;

footnote1
'Based on the above output, 50% of US homicide perpetrators from 1980 to 2014 are aged 23 or younger.'
;

footnote2
'Further analysis to look for shifts in typical perpetrator age over time bins may be necessary, since ideologies can change drastically over a 34 year period.'
;

*
Methodology: Use PROC UNIVARIATE and PROC MEANS to examine the  distribution of 
age of perpetrator.

Limitations: This methodology does not account for observations with missing 
age values. Observations with missing age may be tied to "cold cases" that were
not solved.

Possible Follow-up Steps: Carefully examine age distribution by case outcome 
(i.e. whether or not the case was solved).
;
proc univariate 
    data=homicide_analytic_file
    ; 
    var 
        perpetrator_age
    ;
    histogram; 
run;

proc means 
    data=homicide_analytic_file 
    mean median min q1 q3 max
    ;
    var 
        perpetrator_age
    ;
run;
title;
footnote;



title1
'Research Question: Which agency has the highest rate for solving homicide cases? Which has the lowest?'
;

title2
'Rationale: This would help determine whether certain agencies have particularly high number of unsolved cases and could benefit from additional training.'
;

footnote1
'Based on the above output, Abbeville and many other agencies have a 100% success rate in solving homicide cases. Harrison Town seems to have the lowest at 3.7%.'
;

footnote2
'However, the denominator varies wildly by agency, so some with only a few homicides may appear to have higher success rates (i.e. Abernathy only has 1 homicide which was solved, resulting in 100% success rate).'
;

footnote3
"In addition, more analysis is needed at a higher level of granularity."
;

*
Methodology: Calculate ratio of solved to total cases per agency and 
sort data by ascending and descending order to see highest/lowest rates.

Limitations: This methodology does not account for agencies with few 
instances of homicide cases, and the level of granularity is too fine 
resulting in too many levels left to examine. 

Possible Follow-up Steps: Examine homicide rates at the State level and 
compare ratios of solved crimes, omitting areas with few counts of 
homicide. 
;
proc print 
    data=homicide_freq_asc (obs=5)
    ; 
    where 
        crime_solved="Yes"
    ;
run;
proc print 
    data=homicide_freq_desc (obs=5)
    ;
    where 
        crime_solved="Yes"
    ; 
run;
title;
footnote;



title1
'Research Question: Which weapons used and types of homicide are most prevalent in each state?'
;

title2
'Rationale: For different motives, this should identify weapons that are most easily accessible and might benefit the public by implementing heavier regulations on weapon control.'
;

footnote1
"Based on the above output, handguns have the highest prevalence in homicides in the US. Handguns were the weapon of choice for nearly half (45%) of the homicides committed across all States. Murder or manslaughter appears to be the most common type of homicide (about 99% of all homicides)."
;

footnote2
'The majority of both types of homicide (manslaughter by negligence and murder or manslaughter) involve guns (guns, firearms, handguns, rifles, and shotguns).'
;

footnote3
'Broken out by State, the majority of homicides per State involve guns (gun, firearm, handgun, rifle, or shotgun) or knives.'
;
*
Methodology: Use PROC FREQ to get frequency of weapon use, cross-tabulation 
between weapon and crime type, and cross-tabulation between State and 
weapon used.

Limitations: The prevalence of homicide is subjective to State populations.

Follow-up Steps: A possible follow-up to this approach is to match States to
other areas with similar demographics under gun-control regulations to 
determine if regulations can impact homicide levels. Another follow-up 
to this approach is to group suburban and urban areas and examine 
differences in types of weapons used in homicide cases.
;
proc freq 
    data=homicide_analytic_file
    ;
    table 
        weapon 
        crime_type
        / list
    ;
run;

proc freq 
    data=homicide_analytic_file
    ;
    table 
        weapon*crime_type
        / nocol norow nocum 
    ;
run;

proc freq 
    data=homicide_analytic_file
    ;
    table 
        state*weapon
        / nocol norow nocum 
    ;
run;
title;
footnote;
