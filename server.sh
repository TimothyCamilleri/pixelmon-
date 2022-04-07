#!/bin/bash
if [ "$JEI" == false ]; then
	rm -f /opt/pixelmon/minecraft/mods/jei.jar
else 
	echo "Set JEI environmental variable to false to disable JEI"
	ln -s /opt/pixelmon/minecraft/mods-available/jei.jar /opt/minecraft/mods/jei.jar
fi


java $JAVA_EXTRA_PARAM -Dfml.queryResult=confirm -jar minecraft-forge.jar nogui
