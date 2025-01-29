<?php
#!/usr/bin/env php
function generateMapScript(){
	
	$mapName = (string)readline("Enter the map name ");
	$scriptFolder = '/script';
	$p = 'p';
	$mapFolderName = $p.$mapName;
	$mainMapScript = '_'.$p.$mapName.'.lua';
	
	$stateMapTemplate = <<<STRING
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

  mkdir($mapFolderName.$scriptFolder,0777,true);
	$mapFile = fopen($mainMapScript,'w+');
	fwrite($mapFile,$stateMapTemplate);
	fclose($mapFile);
	
	if(is_dir($mapFolderName.$scriptFolder)){
		
		rename(basename($mainMapScript),"$mapFolderName/$scriptFolder/$mainMapScript");
		
	}

}

generateMapScript();