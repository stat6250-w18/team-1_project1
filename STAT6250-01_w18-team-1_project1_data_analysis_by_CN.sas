*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding the homicide cases reported between 1980-1985

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
'Research Question: What are the top 5 states with highest number of homicides?'
;

title2
'Rationale: This would help to understand at which states homicides happen the most.'
;

footnote1
'Based on the above output, homicides happen the most at California, New York, Texas, Florida and Michigan.'
;
*
Methodology: Use PROC FREQ to generate a dataset with the counts of homicide by 
state, and then use PROC SORT to sort data by descending.

Limitations: This methodology does not account for states with missing data,
nor does it attempt to validate data in any way. 

Possible Follow-up Steps: Study the homicides by year at each state to see the
changes or patterns.
;
proc freq
        data=homicide_analytic_file
    ;
    table
        State / out=FreqCount  list
    ;
run;
proc sort
    data=FreqCount
	    out=FreqCount_Desc
	;
	by
	    descending percent
	;
run;
proc print
    data=FreqCount_Desc 
        (obs=5)
	;
run;
title;
footnote;



title1
'Research Question: What are the top five relationships between the victims and perpetrators that are involved in the incidents?'
;

title2
'Rationale: This would help to identify what types of relationships have the highest homicide rates, and could help investigators profile a likely perpetrator.'
;

footnote1
'Based on the above output, the common relationships between victims and perpetrators are unknown.'
;

footnote2
'Based on the above output, the second and third relationships that are most involved in homicides are accquaintance and strangers.'
;

footnote3
'Based on the above output, the homicides also often happen between wife-husbands, and friends.'
;
*
Methodology: Use PROC FREQ to generate a dataset with the counts of homicide by 
relationship, and then use PROC SORT to sort data by descending.

Limitations: This methodology does not account for states with missing data,
nor does it attempt to validate data in any way. 

Possible Follow-up Steps: Study why there are so many "unknown" relationships in homicide cases.

;
proc freq
        data=homicide_analytic_file
    ;
    table
        Relationship / out=FreqCountRel  list
    ;
run;
proc sort
    data=FreqCountRel
	    out=FreqCountRel_Desc
	;
	by
	    descending percent
	;
run;
proc print
    data=FreqCountRel_Desc 
        (obs=5)
	;
run;
title;
footnote;



title1
'Research Question: How is the number of crimes that was solved successfully by state?'
;

title2
'Rationale: This would help to identify understand the performance of solving homicides at each state of all time.'
;

footnote1
'Based on the above output, California and Texas are the top two states that successfully solved homicide cases, accouting for roughly 18 percent in total.'
;

footnote2
'Based on the above output, Vermont is the state that has lowest rate of solving homicide cases with 0.03 percent.'
;

*
Methodology: Use PROC FREQ to generate a dataset with the counts of homicide by 
state and crime solved, and then use PROC SORT to sort data by descending.

Limitations: This methodology does not account for states with missing data,
nor does it attempt to validate data in any way. 

Possible Follow-up Steps: More carefully clean the values of the variable
Crime_Solved so that the statistics computed do not include any
possible illegal values, and better handle missing data..
;
proc freq 
    data=homicide_analytic_file 
        noprint
    ;
    table
        state*crime_solved 
        / out=State_Crime_Solved list
    ;
run;
proc sort 
    data=State_Crime_Solved
        out=State_Crime_Solved_Desc
    ; 
    by 
        descending percent
    ;
run;
proc print 
    data=State_Crime_Solved_Desc
    ;
    where 
        crime_solved="Yes"
    ; 
run;
title;
footnote;
