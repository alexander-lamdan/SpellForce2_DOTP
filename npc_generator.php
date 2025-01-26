<?php
#!/usr/bin/env php
function main(){
	
	generateNpcs();
	
}
main();

function generateNpcs(){
	
	$npcName = (string)readline("What is the name of your npc that you create in editor? ");
  $npcCount = (int)readline("How much npc your created in the map? ");
  $mainScriptName = (string)readline("Enter the main script filename that will be in the npc file you generate: ");
  $luaCommand = "dofile(GetScriptPath()..\"$mainScriptName.lua\")";
	$luaFunction = (string)readline("Enter the lua function you need ");
	
		$stateNpcTemplate = <<<STRING
State
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
STRING;
	
  $counter = 1;
	$mainScriptFile = fopen($mainScriptName.'.lua','w+');
	fwrite($mainScriptFile,$stateNpcTemplate);
	fclose($mainScriptFile);
	
	$folders = glob('./*',GLOB_ONLYDIR);
	rename(basename($mainScriptName.'.lua'),$folders[2].'/script/'.$mainScriptName.'.lua');
  
	for($counter; $counter <= $npcCount;$counter++){
		
		$npcScript = $npcName.$counter.'.lua';
		
		$npcFile = fopen($npcScript,'w+');
		
		fwrite($npcFile,$luaCommand);
		fclose($npcFile);
		
		rename(basename($npcScript),$folders[2].'/script/'.$npcScript);
		
	}
	
}
