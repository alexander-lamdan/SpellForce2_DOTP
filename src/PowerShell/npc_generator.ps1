function Generate-Npc {

  $npc_name = Read-Host "What is the name of your npc that you created in editor?"
  $npc_count = Read-Host "How much NPC's you created in the map?"
  $main_spawn_name = Read-Host "What is the name of main script?"
  
  $spawn_script = "$main_spawn_name.lua"
  $lua_command = 'dofile(GetScriptPath().."'+$spawn_script +'")'
  
  $state_npc_template = @'
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
}'
'@
  
  New-Item -Path . -Name "$spawn_script" -ItemType "file" -Value "$state_npc_template"
  
  for($i = 1; $i -le $npc_count; $i++){
  
    New-Item -Path . -Name "$npc_name$i.lua" -ItemType "file" -Value "$lua_command"
  
  }
  
}
Generate-Npc

function Generate-NpcActions {

  $spellforce_function = Read-Host "Enter the lua function you need for your npc's "
  $npc_count = Read-Host "How much NPC's you created in the map? "
  $npc_tag = Read-Host "Enter your currect npc name tag from the map "
  $x_value = Read-Host "Insert the X value "
  $y_value = Read-Host "Insert the Y value "
  
  for($i = 1; $i -le $npc_count; $i++){
  
    $npc_action = $spellforce_function+'{Tag="'+$npc_tag+$i+'", X = '+$x_value+', Y = '+$y_value+'},'
    Write-Output "$npc_action"
  
  }
  
}
Generate-NpcActions