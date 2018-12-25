#!/bin/bash

cd /
if [ -f $HOME/backup.tar ]; then
	rm $HOME/backup.tar
fi
if [ -f $HOME/backup.tar.gz ]; then
	rm $HOME/backup.tar.gz
fi
echo -ne "backup: home                  \r"
tar -cf $HOME/backup.tar $HOME >/dev/null 2>&1
if [ "$(which mysqldump)" != "" ]; then
	echo -ne "backup: mysql tables          \r"
	tmpfile=/tmp/$(mktemp XXXXXXXXXX.sql)
	mysqldump -A > $tmpfile
	tar -rf $HOME/backup.tar $tmpfile >/dev/null 2>&1
	rm $tmpfile
fi
if [ -d /etc/apache2 ]; then
	echo -ne "backup: apache2               \r"
	tar -rf $HOME/backup.tar /etc/apache2 >/dev/null 2>&1
fi
if [ -d /etc/php ]; then
	echo -ne "backup: php                   \r"
	tar -rf $HOME/backup.tar /etc/php >/dev/null 2>&1
fi
if [ -d /etc/nginx ]; then
	echo -ne "backup: nginx                 \r"
	tar -rf $HOME/backup.tar /etc/nginx >/dev/null 2>&1
fi
if [ -d /var/www ]; then
	echo -ne "backup: /var/www              \r"
	cd /var/
	tar -rf $HOME/backup.tar /var/www >/dev/null 2>&1
fi
echo -ne "backup: compressing           \r"
tar -czf $HOME/backup.tar.gz $HOME/backup.tar >/dev/null 2>&1
rm $HOME/backup.tar
