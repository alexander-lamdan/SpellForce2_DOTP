<?php
#!/usr/bin/env php
function main(){
	
	generateNpcs();
	generateNpcActions();
	
}
main();

function generateNpcs(){
	
	$npcName = (string)readline("What is the name of your npc that you create in editor? ");
  $npcCount = (int)readline("How much npc your created in the map? ");
  $mainScriptName = (string)readline("Enter the main script filename that will be in the npc file you generate: ");
  $luaCommand = "dofile(GetScriptPath()..\"$mainScriptName.lua\")";
	
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
	
	
	$folders = glob('./*',GLOB_ONLYDIR);
		
	if(isset($folders[2]) && !empty($folders[2])){
		
		$mainScriptFile = fopen($mainScriptName.'.lua','w+');
	  fwrite($mainScriptFile,$stateNpcTemplate);
	  fclose($mainScriptFile);
		
		rename(basename($mainScriptName.'.lua'),$folders[2].'/script/'.$mainScriptName.'.lua');
		
		for($counter; $counter <= $npcCount;$counter++){
		
		  $npcScript = $npcName.$counter.'.lua';
		
		  $npcFile = fopen($npcScript,'w+');
		
		  fwrite($npcFile,$luaCommand);
		  fclose($npcFile);
		
		  rename(basename($npcScript),$folders[2].'/script/'.$npcScript);
		
	  }
		
	}else{
		
		echo 'You dont created the map folder for scripts'.PHP_EOL;
		
	}
  
}

function generateNpcActions(){
	
	$luaFunction = (string)readline("Enter the lua function you need for your npc's ");
	$npcCount = (int)readline("How much npc your created in the map? ");
	$tagNameNpc = (string)readline("Enter your currect npc name tag from the map ");
	$xValue = (int) readline("Insert the X value ");
	$yValue = (int) readline("Insert the Y value ");
	$counter = 1;
	
	for($counter; $counter <= $npcCount;$counter++){
		
		$npcActions = "$luaFunction{Tag=\"".$tagNameNpc.$counter."\",X=$xValue,Y=$yValue},";
		echo $npcActions.PHP_EOL;
	
	}
	
}
