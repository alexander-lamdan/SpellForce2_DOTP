#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import pathlib
import os
import shutil

def generateNpc():
	
  npc_name = input("What is the name of your npc that you create?\n")
  npc_count = int(input("How much npc you created in the map?\n"))
  main_script = input("Enter the main spawn script:\n")
  counter = 0
  lua_command = f'dofile(GetScriptPath().."{main_script}.lua")'
  spawn_template = '''State
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
}
'''
  
  f = open(f'{main_script}.lua','w')
  f.write(spawn_template)
  f.close()
  
  for counter in range(npc_count):
    f = open(f'{npc_name}{counter + 1}.lua','w')
    f.write(lua_command)
    f.close()
    
generateNpc()

def generateNpcActions():
  spellForce2_actions = input("Enter the lua function you need for your npc's ")
  npc_count = int(input("How much npc you created in the map?\n"))
  tag_npc_name = input("Enter your currect npc name tag from the map ")
  x_value = input("Insert the X value ")
  y_value = input("Insert the X value ")
  counter = 0
  
  for counter in range(npc_count):
    print(spellForce2_actions + '{Tag="'+tag_npc_name + f'{counter + 1}' + '",X=' + x_value + ',Y='+y_value + '},')
generateNpcActions()