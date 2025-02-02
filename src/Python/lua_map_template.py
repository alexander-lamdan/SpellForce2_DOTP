#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Need to think about better option for this template generator.
# I need to add more options for this
import pathlib
import os
import shutil

def generateMapScript():
  map_name = input("Please enter the map name you need\n")
  script_folder = 'script'
  p = 'p'
  map_folder_name = p + map_name
  main_map_script = '_'+ p + map_name + '.lua'
  map_state_template = '''State
{
	StateName = "INIT",

	OnOneTimeEvent
	{
		Conditions =
		{
	    	-- fill_me
		},
		Actions =
		{

		},
		GotoState = "MAIN",
	},
};

State
{
	StateName = "MAIN",

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

};\n
'''
  os.makedirs(f'{map_folder_name}/{script_folder}')
  
  f = open(main_map_script,'w')
  f.write(map_state_template)
  f.close()
  
  shutil.move(os.path.basename(main_map_script),f'{map_folder_name}/{script_folder}')
  
generateMapScript()
