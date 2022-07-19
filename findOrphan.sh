#!/bin/bash
#set -x

FIND_PATH=/home/fguerin/dev/Liberation-RX
TMP_FILE=/tmp/all_file.txt

cd $FIND_PATH
find $FIND_PATH -type f | egrep -v ".git|maps|build|mod_template" > $TMP_FILE

while read -r file; do
 FNAME=$(basename $file)
 grep --exclude-dir ".git" --exclude-dir "build" --exclude-dir "maps" -r $FNAME $FIND_PATH >/dev/null

 if [ $? -ne 0 ]; then
   echo "$FNAME ($file) Not found in project !"
 fi

done < $TMP_FILE