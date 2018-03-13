#!/bin/bash -eu
echo "$(date "+%Y-%m-%d %H:%M:%S") ---------- START backup gitlab data ----------"

# Create GitLab Backup file
gitlab-rake gitlab:backup:create

# Get target file name
readonly TARGET_FILENAME=`ls -lt /backups/gitlab/app/* | head -n 1 | awk '{print $NF}'`

# Upload Backup file to Google drive
/usr/local/bin/bkup_gdrive.sh $TARGET_FILENAME bk_gitlab_data

echo "$(date "+%Y-%m-%d %H:%M:%S") ---------- END backup gitlab data ----------"
