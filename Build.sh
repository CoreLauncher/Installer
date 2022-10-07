#!/bin/zsh
TypeWriter build --branch=Bootstrap
cp ./.TypeWriter/Build/CoreLauncher-Bootstrap.twr ./src/Main/resources/CoreLauncher-Bootstrap.twr 
TypeWriter buildexecutable

cd ./.TypeWriter/Build/
rm ./CoreLauncher-Bootstrap.twr
tar -c ./CoreLauncher-Installer > CoreLauncher-Installer.tar
rm ./CoreLauncher-Installer
cd ../../