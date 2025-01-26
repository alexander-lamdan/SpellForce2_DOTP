#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import pathlib

print("Hey, this is script generator for SpellForce Lua Scripts if you're trying to modding your units in editor, and you don't wan't to write a lot of copy-paste code. This script is best offer for lazy ass like me :D\n\n")

npc_map_name = input("What is the name of your npc that you create in editor?\n")
npc_count = int(input("How much npc you created in the map?\n"))
main_script = input("Enter the main script filename that will be in the npc file you generate:\n")
counter = 0
lua_command = f'dofile(GetScriptPath().."{main_script}.lua")'

main_script_template = '''State
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

};'''

with open(main_script + '.lua','w') as file:
	file.write(main_script_template)
print(f'The file {main_script} is created\n')

while npc_count > counter:

  counter += 1
  generated_npc = f'{npc_map_name}{counter}.lua'

  with open(generated_npc,'w') as file:
    file.write(lua_command)
  print(f'Your file {generated_npc} is created')
