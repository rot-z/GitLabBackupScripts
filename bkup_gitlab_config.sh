#!/bin/bash -eu
echo "$(date "+%Y-%m-%d %H:%M:%S") ---------- START backup gitlab config ----------"

readonly TARGET_FILENAME=$(date "+etc-gitlab-%s.tgz")

# Backup GitLab config folder
tar czf $TARGET_FILENAME -C / etc/gitlab

# Upload Backup file to Google drive
/usr/local/bin/bkup_gdrive.sh $TARGET_FILENAME bk_gitlab_config

# Delete Backup file
rm $TARGET_FILENAME

echo "$(date "+%Y-%m-%d %H:%M:%S") ---------- END backup gitlab config ----------"
