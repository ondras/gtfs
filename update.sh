#!/bin/sh

cd $(dirname $0)
FILE=PID_GTFS.zip
DIR=static

logger -t gtfs starting and downloading...
curl -O https://data.pid.cz/$FILE

logger -t gtfs unzipping...
mkdir -p $DIR
unzip -o $FILE -d $DIR
rm $FILE

logger -t gtfs db creating...
sqlite3 gtfs-new.sqlite ".read gtfs_schema.sql"
logger -t gtfs db importing...
sqlite3 gtfs-new.sqlite ".read gtfs_import.sql"
logger -t gtfs db swap...
mv gtfs-new.sqlite gtfs.sqlite

logger -t gtfs done

