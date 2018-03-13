#!/bin/bash -eu

readonly TARGET=$1
readonly TARGET_FILENAME=$(basename $TARGET)
readonly TARGET_BASENAME="${TARGET_FILENAME%.*}"
readonly TARGET_BASEEXT="${TARGET_FILENAME##*.}"
readonly GDRIVE_DIR=$2
readonly KEEP_DAYS=10

if [ ! -e $TARGET ]
then
    echo "File not found: $TARGET" >&2
    exit 1
fi

renice -n 10 -p $$ > /dev/null

### Find/Create Backup folder
GDRIVE_DIR_ID=$(/usr/local/bin/gdrive list --no-header --query "trashed=false and mimeType='application/vnd.google-apps.folder' and name='$GDRIVE_DIR'" | awk '{print $1}')
echo "$GDRIVE_DIR -> $GDRIVE_DIR_ID"

if [ -z "$GDRIVE_DIR_ID" ]
then
    echo "Try to create folder: $GDRIVE_DIR"
    GDRIVE_DIR_ID=$(/usr/local/bin/gdrive mkdir "$GDRIVE_DIR" | awk '{print $2}')
    echo "$GDRIVE_DIR -> $GDRIVE_DIR_ID"
    if [ -z "$GDRIVE_DIR_ID" ]
    then
        echo "Folder not created: $GDRIVE_DIR" >&2
    fi
fi

### Upload Encrypted file
/usr/local/bin/gdrive upload --parent $GDRIVE_DIR_ID --name ${TARGET_BASENAME}_`date +%Y%m%d-%H%M%S`.${TARGET_BASEEXT} $TARGET

### House Keeping
LIMIT_TIMESTAMP=$(date -d "$KEEP_DAYS days ago" +%Y-%m-%dT%H:%M:%S)

/usr/local/bin/gdrive list --no-header --query "'$GDRIVE_DIR_ID' in parents and modifiedTime < '$LIMIT_TIMESTAMP'" | while read ln
do
    ITR_ID=$(echo $ln | awk '{print $1}')
    ITR_DATE=$(echo $ln | awk '{print $(NF-1),$NF}')

    echo "ID: $ITR_ID, DATE: $ITR_DATE"
    /usr/local/bin/gdrive delete $ITR_ID
done
