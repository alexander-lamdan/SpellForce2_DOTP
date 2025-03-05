#!/usr/bin/env node

const fs = require('fs');
const readline = require('readline');

function generateMapScript(){
	
	let userInput = readline.createInterface({
		
		input:process.stdin,
		output:process.stdin
		
	});
	userInput.question('Enter the map name ', mapName =>{
		
		let scriptFolder = "script";
	  let p = 'p';
	  let mapFolderName = p+mapName;
	  let mainMapScript = '_'+p+mapName+'.lua';
		let stateMapTemplate = `State
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

};`;
		
		try{
			
				fs.mkdir(`${mapFolderName}/${scriptFolder}`,{recursive:true},(error)=>{
					
					if(error){
						
						console.log(error);
						
					}
					
				});
				
			}catch(err){
			
			  console.error(err);
			
		}
		try{
			
			fs.writeFile(mainMapScript,stateMapTemplate,err =>{
				
				if(err){
					
					console.error(err);
					
				}else{
					
					fs.rename(mainMapScript,`${mapFolderName}/${scriptFolder}/${mainMapScript}`,(err)=>{
						
						if(err){
							
						  console.error(err);
							
						}
						
					});
					
				}
				
			});
			
		}catch(err){
			
			console.error(err);
			
		}
		
		userInput.close();
		
	});
	
}
generateMapScript();