#!/bin/zsh
TypeWriter build --branch=Bootstrap
cp ./.TypeWriter/Build/CoreLauncher-Bootstrap.twr ./src/Main/resources/CoreLauncher-Bootstrap.twr 
TypeWriter executebuild