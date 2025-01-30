#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Need to think about better option for this template generator.
# I need to add more options for this
import pathlib
import os

map_name = input("Please enter the map name you need\n")
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
p = 'p'
map_dirname = p + map_name

map_name_script = '_' + p + map_name + '.lua'
script_folder = "script/"
print(f'{map_dirname}\n')
print(f'{map_name_script}')
