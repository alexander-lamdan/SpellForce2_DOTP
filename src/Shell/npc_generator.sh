#!/usr/bin/env bash

generate_npc () {

  echo "What is the name of your npc that you created in editor?  "
  read NPC_NAME

  echo "How much NPC's you created in the map?  "
  read NPC_COUNT

  echo "What is the name of main script?  "
  read MAIN_SPAWN_NAME

  SPAWN_SCRIPT="$MAIN_SPAWN_NAME.lua"

  LUA_COMMAND="dofile(GetScriptPath()..\"$SPAWN_SCRIPT\")"

  touch "$SPAWN_SCRIPT"

  STATE_NPC_TEMPLATE='State
{
	StateName = "INIT",
	OnFigureRespawnEvent
	{
		WaitTime = 10,
		X = 119,
		Y = 103,
		Conditions =
		{
		},
		Actions =
		{
		},
	},
}'

echo "$STATE_NPC_TEMPLATE" > "$SPAWN_SCRIPT"

  for ((i = 1; i <= $NPC_COUNT; i++ ))
	  do
		  echo "$LUA_COMMAND" >> "$NPC_NAME$i.lua"
      echo "$NPC_NAME$i.lua is generated"
  done

}
generate_npc

generate_npc_actions () {

  echo -e "Enter the lua function you need for your npc's "
	read SPELLFORCE_FUNCTION
  
  echo -e "How much NPC's you created in the map? "
  read NPC_COUNT

  echo -e "Enter your currect npc name tag from the map "
  read TAG_NAME

  echo -e "Insert the X value "
  read X_VALUE

  echo -e "Insert the Y value "
  read Y_VALUE

	for ((i = 1; i <= $NPC_COUNT; i++ ))
	  do
		  echo "$SPELLFORCE_FUNCTION{Tag=\"$TAG_NAME$i\", X = $X_VALUE, Y = $Y_VALUE},"
  done

}

generate_npc_actions