Write-Output "Hey, this is script generator for SpellForce Lua Scripts if you're trying to modding your units in editor, and you don't wan't to write a lot of copy-paste code. This script is best offer for lazy ass like me :D"


[string]$scriptname = Read-Host "What is the name of your npc that you create in editor?"
[int]$npcCount = Read-Host "How much you created the npcs in the map?"
[string]$mainScriptFile = Read-Host "Enter the main script file for other npcs"

[string]$mainScriptPath = "dofile(GetScriptPath()..`"$mainScriptFile.lua`")"

for ($i = 1; $i -le $npcCount ; $i++){

  New-Item -Name "$scriptname$i.lua" -Value "$mainScriptPath"
  Write-Output "Your npc script is created: $scriptname$i.lua"

}
