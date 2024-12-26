#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Need to think about better option for this template generator.
# I need to add more options for this
import pathlib
import os

map_name = input("Please enter the map name you need\n")
state_template = '''State
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
p = 'p'
map_dirname = p + map_name

map_name_script = '_' + p + map_name + '.lua'
script_foler = "script"

with open(map_name_script,'w') as file:

	if not os.path.exists(map_dirname):
		os.mkdir(map_dirname)
	file.write(state_template)
print(f'The directory {map_dirname} is created\n')
print(f'The file {map_name_script} is created\n')
