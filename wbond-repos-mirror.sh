#!/bin/sh

REPOS_JSON=https://sublime.wbond.net/repositories.json
TMP_DIR=/tmp/swrmirror
MSG_FILE=msg
MSG_PATH=$TMP_DIR/$MSG_FILE
DEST_FILE=$1
DEST_TMP_FILE=$TMP_DIR/`basename $DEST_FILE`
LOG_FILE=$2

mkdir -p $TMP_DIR

wget -o $MSG_PATH -S -O $DEST_TMP_FILE $REPOS_JSON
RET_CODE=`grep "HTTP/1.1 200 OK" $MSG_PATH`

if [ "$RET_CODE" != "" ]; then
	cp $DEST_TMP_FILE $DEST_FILE
	EXIT_CODE=0
else
	EXIT_CODE=1
fi

cat $MSG_PATH >> $LOG_FILE

exit $EXIT_CODE