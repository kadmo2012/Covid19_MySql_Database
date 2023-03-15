/* Mysql should be in your command line path. e.g. C:\Program Files\MySQL\MySQL Workbench 8.0 CE\mysql.exe */
/* first download the NY Times Covid data file (state totals): Run "python Covid19NyTimesDownload.py".  The script will update this file: C:/data/us-states.csv */

/* mysql --user=root --password=root */
use covid19_2;
Truncate Table coviddata_state;
LOAD DATA INFILE     'C:/data/us-states.csv'     INTO TABLE coviddata_state    FIELDS TERMINATED BY ','     LINES TERMINATED BY '\n'    IGNORE 1 LINES;
CALL Covid_LoadNewCycles();
call Covid_CreateExportFile();
quit
 



/*
use covid19_2;

truncate table bonkaroo62_db.wp_covidrpt_state_history;
insert into bonkaroo62_db.wp_covidrpt_state_history(date_end, date_begin, period, period_days, state, fips, state_cd, cases_begin, cases_end, cases_chg, cases_avg, deaths_begin, deaths_end, deaths_chg, deaths_avg, casesPer100k, rate_chg, section, max_value)
select date_end, date_begin, period, period_days, state, fips, state_cd, cases_begin, cases_end, cases_chg, cases_avg, deaths_begin, deaths_end, deaths_chg, deaths_avg, casesPer100k, rate_chg, section, max_value
from coviddata_state_history order by date_end desc, period_days, casesPer100k desc;


truncate table bonkaroo62_db.wp_covidrpt_state_chg;
insert into bonkaroo62_db.wp_covidrpt_state_chg(date_end, date_begin, period, period_days, state, fips, state_cd, cases_begin, cases_end, cases_chg, cases_avg, deaths_begin, deaths_end, deaths_chg, deaths_avg, pop, casesPer100k, rate_chg, section, max_value, description)
select date_end, date_begin, period, period_days, state, fips, state_cd, cases_begin, cases_end, cases_chg, cases_avg, deaths_begin, deaths_end, deaths_chg, deaths_avg, pop, casesPer100k, rate_chg, section, max_value, description
from coviddata_state_chg order by date_end desc, period_days, casesPer100k desc;
*/