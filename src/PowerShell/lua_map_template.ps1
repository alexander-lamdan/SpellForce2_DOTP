function Generate-MapScript {

  $map_name = Read-Host "Enter the map name"
  $script_folder = "script/"
  $p = 'p'
  $map_folder_name = "$p$map_name"
  $main_map_script = "_$p$map_name.lua"
  
  $state_map_template = @'
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
'@
  
  New-Item -Path . -Name "$map_folder_name/$script_folder" -ItemType "directory"
  New-Item -Path "$map_folder_name/$script_folder" -Name "$main_map_script" -ItemType "file" -Value "$state_map_template"
  
}
Generate-MapScript
