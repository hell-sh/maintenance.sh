#!/bin/bash

if [ $("whoami") != "root" ]; then
	echo "./maintenance.sh needs to be run as root."
	return 1
fi

### backup ###

echo -ne "backup: preparing...          \r"
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

### apt-get update ###

echo "apt-get update                "
apt-get update

### apt-get upgrade ###

echo "apt-get upgrade               "
apt-get upgrade

### raid info ###

echo -ne "getting raid info...          \r"

if [ ! -f /proc/mdstat ]; then
	echo "There is no RAID on this system."
	exit 0
else
	cmd() { grep "active" < /proc/mdstat; }
	if [ "$(cmd)" == "" ]; then
		echo "There is no active RAID on this system."
	else
		cmd() { grep "\]\(F\)" < /proc/mdstat; }
		if [ "$(cmd)" == "" ]; then
			echo "No hard drive has failed.      "
			cmd() { cat /proc/mdstat | grep "resync"; }
			if [ "$(cmd)" != "" ]; then
				echo "A RAID resync is in progress. "
			fi
		else
			ex='!'
			echo "/$ex\\ A hard drive has failed!  "
		fi
	fi
fi

### end ###

echo ""
echo "Thanks for using ./maintenance.sh by Hell.sh!"
echo ""
