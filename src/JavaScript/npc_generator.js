#!/usr/bin/env node

const fs = require('fs');
const readline = require('readline');

function generateNpc(){
	
	let userInput = readline.createInterface({
		
		input:process.stdin,
		output:process.stdin
		
	});
	
	userInput.question('What is the name of your npc that you create in editor? -> ',npcName=>{
		
		userInput.question('How much npc your created in the map? -> ',npc_count =>{
			
	    userInput.question('Enter the main script filename that will be in the npc file you generate: -> ', mainScriptName => {
				
				let lua_command = `dofile(GetScriptPath().."${mainScriptName}.lua")`;
				let stateNpcTemplate = `State
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
}`;     let counter = 1;
        
        fs.writeFile(`${mainScriptName}.lua`,stateNpcTemplate,err=>{
					
					if(err){
						
						console.error(err);
						
					}
					
				});
        for(counter; counter <= npc_count; counter++){
					
					fs.writeFile(`${npcName}${counter}.lua`,lua_command,err=>{
						
						if(err){
							
						  console.error(err);
							
						}
						
					});
					
				}
		    userInput.close();
				generateNpcActions();
		
	    });
		
	  });
		
	});
	
}
generateNpc();

function generateNpcActions(){
	
	let userInput = readline.createInterface({
		
		input:process.stdin,
		output:process.stdin
		
	});
	
	userInput.question('Enter the lua function you need for your npcs -> ', npcAction=>{
		
	  userInput.question('How much npc your created in the map? -> ', npc_count=>{
			
		  userInput.question('Enter your currect npc name tag from the map -> ', tag_name=>{
				
			  userInput.question('Insert the X value -> ',xValue=>{
					
				  userInput.question('Insert the Y value -> ',yValue=>{
						
						let counter = 1;
						
						for(counter; counter <= npc_count; counter++){
							
							console.log(`${npcAction}{Tag="${tag_name}${counter}", X = ${xValue}, Y = ${yValue}},`);
							userInput.close();
						}
						
					});
					
				});	
				
			});	
			
		});
		
	});
	
}