#!/usr/bin/env bash

generate_map_script () {

  echo "Enter the map name  "
  read MAP_NAME

  SCRIPT_FOLDER='script'
  p='p'
  MAP_FOLDER_NAME="$p$MAP_NAME"
  MAIN_MAP_SCRIPT="_$p$MAP_NAME.lua"

  STATE_MAP_TEMPLATE='
State
{
	StateName = INIT,

	OnOneTimeEvent
	{
		Conditions =
		{
	    	-- fill_me
		},
		Actions =
		{

		},
		GotoState = MAIN,
	},
};

State
{
	StateName = MAIN,

	OnOneTimeEvent
	{
		Conditions =
		{
		    -- fill_me
		},
		Actions =
		{
            -- fill_me
		},
	},

};
'

  mkdir -p "$MAP_FOLDER_NAME/$SCRIPT_FOLDER"
  touch "$MAIN_MAP_SCRIPT"
  echo "$STATE_MAP_TEMPLATE" >> "$MAIN_MAP_SCRIPT"
  mv "$MAIN_MAP_SCRIPT" "$MAP_FOLDER_NAME/$SCRIPT_FOLDER"

  
}

generate_map_script