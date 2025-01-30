#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import pathlib

def main():
	generateNpc()
	generateNpcActions()

main()

def generateNpc():
	
	npc_name = input("What is the name of your npc that you create?\n")
  npc_count = int(input("How much npc you created in the map?\n"))
	main_script = input("Enter the main spawn script:\n")
  counter = 0
  lua_command = f'dofile(GetScriptPath().."{main_script}.lua")'
  print(npc_name)