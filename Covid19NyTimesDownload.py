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


