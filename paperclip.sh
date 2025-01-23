#!/usr/bin/env bash

if ! type -p mvn >/dev/null 2>&1; then
    echo "No maven installation detected! Terminating build..."
    exit 1
fi

basedir="$(cd "$1" && pwd -P)"

cp ./PaperSpigot-Server/target/paperspigot*-SNAPSHOT.jar ./Paperclip/paperspigot-1.8.8.jar
cp ./work/1.8.8/1.8.8.jar ./Paperclip/minecraft_server.1.8.8.jar
cd ./Paperclip
mvn clean package -Dmcver=1.8.8 "-Dpaperjar=$basedir/Paperclip/paperspigot-1.8.8.jar" "-Dvanillajar=$basedir/Paperclip/minecraft_server.1.8.8.jar"
cd ..
cp ./Paperclip/assembly/target/paperclip*.jar ./paperclip.jar

echo ""
echo ""
echo ""
echo "Build success!"
echo "Copied final jar to $(pwd)/paperclip.jar"
