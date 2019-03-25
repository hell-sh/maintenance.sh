#!/bin/bash

if [ $("whoami") != "root" ]; then
	echo "You need to be root to perform a backup"
	return 1
fi
if [ -f "$HOME/backup.tar" ]; then
	rm "$HOME/backup.tar"
fi
if [ -f "$HOME/backup.tar.gz" ]; then
	rm "$HOME/backup.tar.gz"
fi
echo -ne "backup: home                  \r"
tar -cf "$HOME/backup.tar" "$HOME" >/dev/null 2>&1
if [ "$(which mysqldump)" != "" ]; then
	echo -ne "backup: mysql tables          \r"
	if [ -f /mysql_backup.sql ]; then
		rm /mysql_backup.sql
	fi
	mysqldump -A > /mysql_backup.sql
	tar -rf "$HOME/backup.tar" /mysql_backup.sql >/dev/null 2>&1
	rm /mysql_backup.sql
fi
if [ -d /etc/apache2 ]; then
	echo -ne "backup: apache2               \r"
	tar -rf "$HOME/backup.tar" /etc/apache2 >/dev/null 2>&1
fi
if [ -d /etc/bind ]; then
	echo -ne "backup: bind                  \r"
	tar -rf "$HOME/backup.tar" /etc/bind >/dev/null 2>&1
fi
if [ -d /etc/php ]; then
	echo -ne "backup: php                   \r"
	tar -rf "$HOME/backup.tar" /etc/php >/dev/null 2>&1
fi
if [ -d /etc/postfix ]; then
	echo -ne "backup: postfix               \r"
	tar -rf "$HOME/backup.tar" /etc/postfix >/dev/null 2>&1
fi
if [ -d /etc/nginx ]; then
	echo -ne "backup: nginx                 \r"
	tar -rf "$HOME/backup.tar" /etc/nginx >/dev/null 2>&1
fi
if [ -d /var/www ]; then
	echo -ne "backup: /var/www              \r"
	tar -rf "$HOME/backup.tar" /var/www >/dev/null 2>&1
fi
echo -ne "backup: compressing           \r"
gzip "$HOME/backup.tar" >/dev/null 2>&1
