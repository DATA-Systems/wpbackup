# Einfaches schnelles Komplett-Backup von WordPress

Erstellt ein tar.gz (oder zip) Archiv einer WordPress-Installation, einschliesslich Datenbank. Die Zugangsdaten werden aus der `wp-config.php`gelesen.

## Syntax
`wpbackup.sh <path-to-WordPress> <path-to-BackupFolder> [dbonly]`

* Pfade relativ oder absolut. Es findet keine Prüfung statt.
* dbonly (Optional) sicher nur die Datenbank
