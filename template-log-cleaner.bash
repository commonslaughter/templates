#!/bin/bash
## [name]
## Log Cleaner, from 2DayGeek

prev_count=0
fpath=/var/log/app/app_log.*
find $fpath -type d -mtime +10  -exec ls -ltrh {} \; > /tmp/folder.out
find $fpath -type d -mtime +10  -exec rm -rf {} \;
count=$(cat /tmp/folder.out | wc -l)


if [ "$prev_count" -lt "$count" ] ; then
MESSAGE="/tmp/file1.out"
TO="email@domain"
echo "Application log folders are deleted older than 15 days" >> $MESSAGE
echo "+----------------------------------------------------+" >> $MESSAGE
echo "" >> $MESSAGE
cat /tmp/folder.out | awk '{print $6,$7,$9}' >> $MESSAGE
echo "" >> $MESSAGE
SUBJECT="WARNING: Apache log files are deleted older than 15 days $(date)"
mail -s "$SUBJECT" "$TO" < $MESSAGE
rm $MESSAGE /tmp/folder.out
fi
