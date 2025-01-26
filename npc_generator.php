<?php
#!/usr/bin/env php8.2
function main(){
	
	generateNpcs();
	
}
main();

function generateNpcs(){
	
	$npcName = (string)readline("What is the name of your npc that you create in editor? ");
  $npcCount = (int)readline("How much npc your created in the map? ");
  $mainScriptSpawn = (string)readline("Enter the main script filename that will be in the npc file you generate: ");
  $counter = 1;
  $luaCommand = "dofile(GetScriptPath()..\"$mainScriptSpawn.lua\")";
	$luaFunction = (string)readline("Enter the lua function you need ");
	
	$stateTemplateLua = <<<STRING
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
STRING;

echo $stateTemplateLua;
	
}
