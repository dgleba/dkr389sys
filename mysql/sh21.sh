#!/usr/bin/env bash

function main1() 
{
set -vx

#usage: /var/www/html/hrdb/actions/imp-empl.sh

cd /srv/web/incident295


source /home/albe/shc/21env.sh

pw='dx'

# mysql -udg417 -p$pw -e "truncate table lukup.emp_enterprise"
sleep 2

#mysql --local-infile=1  -uhruser -p$mysql_hruser_pass</home/albe/share203/incident295/sql/import_csv_enterprise_empl.sql
echo 107-356
mysql --local-infile=1  -uhruser -p$mysql_hruser_pass</var/www/html/hrdb/actions/import_csv_enterprise_empl.sql


}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function other()  
{
exit 999

chmod ugo+x /var/www/html/cilist/actions/email_owners_script.sh
/var/www/html/cilist/actions/email_owners_script.sh
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

date
main1
date