#!/bin/bash

cd $HOME
echo "This utility will help you create a maintainance.sh in your user directory $HOME with the functionality you want."
echo ""

echo "#!/bin/bash" > maintainance.sh
echo "" >> maintainance.sh

read -p "Should maintainance.sh backup important files? [Y/n] " -n 1 -r
echo ""
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
	echo "echo -ne \"\\\\ Backup: Preparing           \\r\"" >> maintainance.sh
	echo "wget -qO- https://maintainance.hell.sh/01_backup.sh | bash" >> maintainance.sh
fi
echo "echo \"Thanks for using Maintainance Hell.\"" >> maintainance.sh
chmod +x maintainance.sh
echo "You may now run ./maintainance.sh whenever you feel like it."
