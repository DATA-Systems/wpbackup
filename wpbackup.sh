#!/bin/bash
#
# SEHR einfaches WordPress-Backup

# Parameter da?
if [ $# -eq 0 ]; then
    echo "SYNTAX: wpbackup.sh <path-to-WordPress> <path-to-BackupFolder> [dbonly]"
    exit 1
fi

wpdir=$1
bakdir=$2

# Backupverzeichnis angegeben?
if [ -z "$bakdir" ]; then
    bakdir=~/priv
fi

# Verzeichnisse da?
if [ ! -d $wpdir ]; then
    echo "Directory $wpdir does not exist."
    exit 1
fi
if [ ! -d $bakdir ]; then
    echo "Directory $bakdir does not exist."
    exit 1
fi

# Sinnvolle Dateinamen bauen
db_backup_name="wp-db-backup-"`date "+%Y%m%d"`".sql.gz"
wpfiles_backup_name="wp-files-backup-"`date "+%Y%m%d"`

# Zugangsdaten aus der config suchen
db_name=`grep DB_NAME $wpdir/wp-config.php | cut -d \' -f 4`
db_username=`grep DB_USER $wpdir/wp-config.php | cut -d \' -f 4`
db_password=`grep DB_PASSWORD $wpdir/wp-config.php | cut -d \' -f 4`

# MySQLdump, gzip
mysqldump --opt -u$db_username -p$db_password $db_name | gzip > $bakdir/$db_backup_name

# ... wenn "dbonly" nicht gesetzt ist
if [ ! "$3" = "dbonly" ]; then
    # WordPress einpacken
    tar -czvf $bakdir/$wpfiles_backup_name.tar.gz $wpdir

    # Oder als zip:
    #zip -r $bakdir/$wpfiles_backup_name $wpdir
fi
