State                                                                                     
{                                                                                        
	StateName = "INIT",                                                                  
	                                                                                     
	OnFigureSpawnOnlyWhenEvent                                                           
	{                                                                                    
		Conditions =                                                                     
		{                                                                                
	    	OR                                                                           
	    	{                                                                            
	    		FigureIsInRange	{Tag = "OrcCamp01Seeker01", X = 122, Y = 279, Range = 16},
	    		FigureIsInRange	{Tag = "OrcCamp01Seeker02", X = 122, Y = 279, Range = 16},
	    		FigureIsInRange	{Tag = "OrcCamp01Seeker03", X = 122, Y = 279, Range = 16},
	    		FigureIsInRange	{Tag = "OrcCamp02Seeker01", X = 122, Y = 279, Range = 16},
	    		FigureIsInRange	{Tag = "OrcCamp02Seeker02", X = 122, Y = 279, Range = 16},
	    		FigureIsInRange	{Tag = "OrcCamp02Seeker03", X = 122, Y = 279, Range = 16},
	    		FigureIsInRange	{Tag = "OrcCamp03Seeker01", X = 122, Y = 279, Range = 16},
	    		FigureIsInRange	{Tag = "OrcCamp03Seeker02", X = 122, Y = 279, Range = 16},
	    		FigureIsInRange	{Tag = "OrcCamp03Seeker03", X = 122, Y = 279, Range = 16},
	    	},                                                                           
		},                                                                               
		Actions =                                                                        
		{                                                                                
			MapFlagSetTrue	{Name = "mf_Spy8Found"},   
			FigureOutcry	{Tag  = "OutcrySpeaker", TextTag = "Seer02"},                                  
		},                                                                               
		DelayedActions =                                                                 
		{                                                                                
		},                                                                               
	},                                                                                   
};                                                                                       