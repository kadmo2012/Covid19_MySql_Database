# Covid-19 MySQL data analysis project
Creates and updates a database that tracks the NYTimes Covid19 data

If you would like to install the MySql tables, views and stored procedures used in this app, 
you can run the scripts in following script file: Covid19_Database_install.sql, in any MySql Database.

Then update these three tables as follows:

• covid_process_date – Contains 1 record, the parameters for processing the current cycle

    Run the following script to load the one record it needs:

    Insert into covid_process_date(Process_ID, date_begin, date_end, period, period_days)
    VALUES(1, "2020-01-01", "2020-01-02", "1 DAY", 1);

• coviddata_state – Holds data imported from NY Times covid-19 data repository.  
    Run MySql’s Table Data Import Wizard and import this file, from the NY Times:  us-states.csv

• covid_statedata – Holds state data, like the name, abbreviation, population, etc.
    Run MySql’s Table Data Import Wizard and import this file: statedata.csv

And run this stored procedure:  CALL Covid_LoadNewCycles();

After running the stored procedure the table, coviddata_state_chg, will contain all the details for the current day.  
There will be 3 cycles representing changes over 1 day, 7 days and 14 days.  
The table, coviddata_state_history, will contain historical data.  
You’ll find more information in the “Covid19_Database_install.sql” script file.  



Automated daily updates can be run as follows (make sure python and MySql CLI are installed):
From the c:/programming folder run:  python Covid19NyTimesDownload.py 
This is the contents of Covid19NyTimesDownload.py:
import requests
import shutil
import datetime

#a_date = datetime.date(2015, 10, 10)
today=datetime.datetime.now()
days = datetime.timedelta(1)
yesterday=today-days
yesterdaystr=yesterday.strftime("%Y%m%d")
downloadfile="c:\\data\\us-states_" + yesterdaystr + ".csv"
print(downloadfile)
uploadfile="C:\\data\\us-states.csv"

url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv"
r = requests.get(url, allow_redirects=True)

# downloadfile='C:\data\states_20220308.csv'
#open('C:\data\states_20220309.csv', 'wb').write(r.content)
open(downloadfile, 'wb').write(r.content)
shutil.copyfile(downloadfile, uploadfile)


This will download the NY Times covid-19 state data and save it to two files (one has a date included in the filename ).  
    /data/us-states.csv
    /data/us-states_yyyymmdd.csv

Then run MySql from the system prompt:
/programming/mysql --user=root --password=root
        

From the MySql prompt run this script file “DailyProcessing.sql”, as follows:
mysql> source DailyProcessing.sql
        
And quit:
mysql> quit



This is the contents of the “DailyProcessing.sql” script file:
/* Mysql should be in your command line path. e.g. C:\Program Files\MySQL\MySQL Workbench 8.0 CE\mysql.exe */
/* first download the NY Times Covid data file (state totals): Run "python Covid19NyTimesDownload.py".  The script will update this file: C:/data/us-states.csv */

/* mysql --user=root --password=root */
use covid19_2;
Truncate Table coviddata_state;
LOAD DATA INFILE     'C:/data/us-states.csv'     INTO TABLE coviddata_state    FIELDS TERMINATED BY ','     LINES TERMINATED BY '\n'    IGNORE 1 LINES;
CALL Covid_LoadNewCycles();
call Covid_CreateExportFile();
quit

