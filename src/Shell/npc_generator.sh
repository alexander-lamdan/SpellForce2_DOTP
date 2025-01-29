#!/usr/bin/env bash
echo -e "Hey, this is script generator for SpellForce Lua Scripts if you're trying to modding your units in editor, and you don't wan't to write a lot of copy-paste code. This script is best offer for lazy ass like me :D\n\n"

echo -e "Please enter the npc name that you created in the map editor\n"

read NPC_FILENAME

echo -e "How much NPC's you created in the map that need to be spawned?\n"

read NPC_COUNT

echo -e "What is the name of main script for our NPC?\n"

read MAIN_SCRIPT

FILE_EXT_LUA='.lua'

LUA_MAIN_SCRIPT="dofile(GetScriptPath()..\"$MAIN_SCRIPT$FILE_EXT_LUA\")"

for ((i = 1; i <= $NPC_COUNT; i++ ))
do
  echo "$LUA_MAIN_SCRIPT" >> "$NPC_FILENAME$i$FILE_EXT_LUA"
  echo "$NPC_FILENAME$i$FILE_EXT_LUA is generated" 
done