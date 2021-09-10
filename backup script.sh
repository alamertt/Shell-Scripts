#! /bin/sh
export DATE=$(date +%d_%m_%y)
export ORACLE_SID=orcl
export ORACLE_HOME=/u01/app/oracle/product/11gR2/db

$ORACLE_HOME/bin/expdp hastane/OZGURRUGZO@orcl directory=DATA_PUMP_DIR dumpfile=Personel_Backup_$DATE.dmp logfile=Personel_Backup_$DATE.log full=y

bzip2 -v /u01/app/oracle/admin/orcl/dpdump/Personel_Backup_$DATE.dmp

cd /u01/app/oracle/admin/orcl/dpdump/
ftp -n 192.168.1.90 <<END_SCRIPT
quote USER admin
quote PASS 42499456aA
cd /VOLUME1/PUBLIC/
lcd /u01/app/oracle/admin/orcl/dpdump/
put Personel_Backup_$DATE.dmp.bz2
END_SCRIPT
rm /u01/app/oracle/admin/orcl/dpdump/Personel_Backup_$DATE.dmp.bz2

