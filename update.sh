#!/bin/sh

DATA=/home/sqlite
FILE=PID_GTFS.zip
CUR=$(dirname $0)

cd $DATA

echo starting and downloading...
wget https://data.pid.cz/$FILE

echo unzipping...
mkdir -p static
unzip -o $FILE -d static
rm $FILE

echo db creating...
sqlite3 gtfs-new.sqlite ".read $CUR/gtfs_schema.sql"

echo db importing...
sqlite3 gtfs-new.sqlite ".read $CUR/gtfs_import.sql"

echo db swap...
mv gtfs-new.sqlite gtfs.sqlite

echo done

