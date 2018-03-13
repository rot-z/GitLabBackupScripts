# GitLabBackupScripts

GitLabサーバをGoogle Driveにバックアップする際に作成したbashスクリプト

- bkup_gdrive.sh
- bkup_gitlab_config.sh
- bkup_gitlab_data.sh

## bkup_gdrive.sh

[サーバのバックアップファイルを Google ドライブに退避させる](https://qiita.com/aviscaerulea/items/53123ce5b79c80e31a71)を参照して作成したスクリプト  
[gdrive](https://github.com/prasmussen/gdrive)を使用してGoogle Driveにファイルをアップロードする

## bkup_gitlab_config.sh

/etc/gitlabフォルダを圧縮し、bkup_gdrive.shを使用してGoogle Driveにアップロードするスクリプト

## bkup_gitlab_data.sh

GitLabのデータバックアップファイルを、bkup_gdrive.shを使用してGoogle Driveにアップロードするスクリプト

# Update Log

| Date | Comment |
| --- | --- |
| 2018.03.13 | First uploaded |

