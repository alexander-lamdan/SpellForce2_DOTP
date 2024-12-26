State
{
	StateName = "INIT",

	OnOneTimeEvent
	{
		Conditions = 
		{
		},
		Actions = 
		{
		},
		GotoState = "MAIN",
	},
};



for i = 1, 3 do
	local sPlayerName = "pl_Human" .. i
	
	-- ********************************************************************
	-- solved, wenn die gegner platt sind
	-- ********************************************************************
	OnOneTimeEvent
	{
		EventName = "UndeadPlayer1Wiped",
		Conditions = 
		{
			QuestIsActive		{Player = sPlayerName, Quest = "CoopHonorMarks"},
			FigureIsAlive 		{Tag = "MustSurvive1"},
			MapFlagIsTrue  		{Name = "mf_UndeadCamp1Wiped"},
		},
		Actions = 
		{
			AvatarItemMiscGive	{Player = sPlayerName, ItemId = Item.Misc.Ehrenmarke, Amount = 1},
			AvatarFlagSetTrue	{Player = sPlayerName, Name = "af_P334_GotHonorMark1"},
			MapFlagSetTrue	{Name = "mf_Camp1Wiped"},
		},
	}

	OnOneTimeEvent
	{
		EventName = "UndeadPlayer1Wiped",
		Conditions = 
		{
			QuestIsActive		{Player = sPlayerName, Quest = "CoopHonorMarks"},
			FigureIsAlive 		{Tag = "MustSurvive2"},
			MapFlagIsTrue			{Name = "mf_UndeadCamp2Wiped"},
		},
		Actions = 
		{
			AvatarItemMiscGive	{Player = sPlayerName, ItemId = Item.Misc.Ehrenmarke, Amount = 1},
			AvatarFlagSetTrue	{Player = sPlayerName, Name = "af_P334_GotHonorMark2"},
			MapFlagSetTrue	{Name = "mf_Camp2Wiped"},
		},
	}
	OnOneTimeEvent
	{
		Conditions =
		{
			QuestIsSolved  {Player = sPlayerName, Quest = "CoopMapQuestRushwater"},
			AvatarHasNotLevel	{Player = sPlayerName, Level = 10},
		},
		Actions = 
		{
			AvatarItemMiscGive	{Player = sPlayerName, ItemId = 103, Amount = 1},
		},
	}
	OnOneTimeEvent
	{
		EventName = "Player"..i.."EnoughHonorMarksCollected",
		Conditions = 
		{
			QuestIsActive	{Player = sPlayerName, Quest = "CoopHonorMarks"},
			AvatarHasItemMisc	{Player = sPlayerName, ItemId = Item.Misc.Ehrenmarke, Amount = 5},
		},
		Actions = 
		{
			QuestSetSolved	{Player = sPlayerName, Quest = "CoopHonorMarks"},
			QuestSetActive	{Player = sPlayerName, Quest = "CoopHonorMarksCollectedEnough"},
		},
	}
end

State
{
	StateName = "MAIN",

	OnOneTimeEvent
	{
		EventName = "MustSurvive1Died",
		Conditions = 
		{
			FigureIsDead {Tag = "MustSurvive1"},
		},
		Actions = 
		{
		},
	},
	OnOneTimeEvent
	{
		EventName = "MustSurvive2Died",
		Conditions = 
		{
			FigureIsDead {Tag = "MustSurvive2"},
		},
		Actions = 
		{
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			OR
			{
				QuestIsActive 	{Player = "pl_Human1", Quest = "CoopHonorMarks"},				
				QuestIsActive 	{Player = "pl_Human2", Quest = "CoopHonorMarks"},				
				QuestIsActive 	{Player = "pl_Human3", Quest = "CoopHonorMarks"},				
			},
		},
		Actions = 
		{
			FogOfWarRevealAtEntity	{Tag = "MustSurvive1", Range = 15, Height = default},
			FogOfWarRevealAtEntity	{Tag = "MustSurvive2", Range = 15, Height = default},
			FogOfWarRevealAtEntity	{Tag = "RushwaterCoopPortal", Range = 15, Height = default},
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			MapFlagIsTrue	{Name = "mf_Camp1Wiped"},
			MapFlagIsTrue	{Name = "mf_Camp2Wiped"},
			QuestIsNotSolved {Player = "pl_Human1", Quest = "CoopMapQuestRushwater"},
			QuestIsNotSolved {Player = "pl_Human2", Quest = "CoopMapQuestRushwater"},
			QuestIsNotSolved {Player = "pl_Human3", Quest = "CoopMapQuestRushwater"},
		},
		Actions =
		{
			MapTimerStart	{Name = "mt_StartTimer"},
			VisualTimerStart	{Seconds = 45},
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			MapTimerIsElapsed {Name = "mt_StartTimer", Seconds = 25},
		},
		Actions =
		{
			MapFlagSetTrue	{Name = "mf_CourierAppears"},
			MapTimerStop {Name = "mt_StartTimer"},
		},
	},	
	OnOneTimeEvent
	{
		Conditions = 
		{
			CoopPlayerIsPlaying {Player = "pl_Human1"},
			MapFlagIsTrue	{Name = "mf_CourierAppears"},
		},
		Actions =
		{
			FigureNpcSpawn	{Tag  = "Courier", Level = 1, UnitId = 861, X = 351, Y = 314, Team = "tm_Neutral"},
			EntityValueSet	{Name = "ev_CourierGoesToPlayer", Value = 1},
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			CoopPlayerIsNotPlaying 	{Player = "pl_Human1"},
			CoopPlayerIsPlaying 	{Player = "pl_Human2"},
			MapFlagIsTrue	{Name = "mf_CourierAppears"},
		},
		Actions =
		{
			FigureNpcSpawn	{Tag  = "Courier", Level = 1, UnitId = 861, X = 533, Y = 283, Team = "tm_Neutral"},
			EntityValueSet	{Name = "ev_CourierGoesToPlayer", Value = 2},
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			CoopPlayerIsNotPlaying 	{Player = "pl_Human1"},
			CoopPlayerIsNotPlaying 	{Player = "pl_Human2"},
			CoopPlayerIsPlaying 	{Player = "pl_Human3"},
			MapFlagIsTrue	{Name = "mf_CourierAppears"},
		},
		Actions =
		{
			FigureNpcSpawn	{Tag  = "Courier", Level = 1, UnitId = 861, X = 303, Y = 272, Team = "tm_Neutral"},
			EntityValueSet	{Name = "ev_CourierGoesToPlayer", Value = 3},
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			EntityValueIsEqual {Name = "ev_CourierGoesToPlayer", Value = 1},
		},
		Actions =
		{
			FigureRun {Tag = "Courier", X = 376, Y = 284},
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			EntityValueIsEqual {Name = "ev_CourierGoesToPlayer", Value = 2},
		},
		Actions =
		{
			FigureRun {Tag = "Courier", X = 541, Y = 260},
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			EntityValueIsEqual {Name = "ev_CourierGoesToPlayer", Value = 3},
		},
		Actions =
		{
			FigureRun {Tag = "Courier", X = 254, Y = 225},
		},
	},
	OnOneTimeEvent
	{
		Conditions = 
		{
			OR
			{
				AND
				{
					EntityValueIsEqual {Name = "ev_CourierGoesToPlayer", Value = 1},
					FigureIsInRange {Tag = "Courier", X = 376, Y = 284, Range = 7},
				},
				AND
				{
					EntityValueIsEqual {Name = "ev_CourierGoesToPlayer", Value = 2},
					FigureIsInRange {Tag = "Courier", X = 541, Y = 260, Range = 7},
				},
				AND
				{
					EntityValueIsEqual {Name = "ev_CourierGoesToPlayer", Value = 3},
					FigureIsInRange {Tag = "Courier", X = 254, Y = 225, Range = 7},
				},
			},
		},
		Actions =
		{
			MapFlagSetTrue	{Name = "mf_CourierDone"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue	{Name = "mf_CourierDone"},
		},
		Actions =
		{
			FigureOutcry {Tag = "Courier", TextTag = "Portal1"},
			FigureOutcry {Tag = "Courier", TextTag = "Portal2"},
			FigureOutcry {Tag = "Courier", TextTag = "Portal3"},
			FigureOutcry {Tag = "Courier", TextTag = "Portal4"},
			
			QuestSetActive {Player = "pl_Human1", Quest = "CoopMapQuestRushwater"},
			QuestSetActive {Player = "pl_Human2", Quest = "CoopMapQuestRushwater"},
			QuestSetActive {Player = "pl_Human3", Quest = "CoopMapQuestRushwater"},
			
			MapTimerStart {Name = "mt_CerthisDelay"},
			
			FogOfWarReveal	{X = 275, Y = 335, Range = 15, Height = default},
			FogOfWarReveal	{X = 630, Y = 438, Range = 15, Height = default},	
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapTimerIsElapsed {Name = "mt_CerthisDelay", Seconds = 15},
		},
		Actions = 
		{
			FigureRunToEntity {Tag = "Courier", TargetTag = "CourierHome"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			FigureIsInEntityRange {Tag = "Courier", TargetTag = "CourierHome", Range = 3},
		},
		Actions = 
		{
			FigureVanish {Tag = "Courier"},
			MapTimerStop  {Name = "mt_CerthisDelay"},
			MapFlagSetTrue {Name = "mf_CerthisGo"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_CerthisGo"},

		},
		Actions = 
		{
			FigureNpcSpawnToEntity	{Tag = "Certhis", Level = 5, UnitId = 860, TargetTag = "CourierHome", Team = "tm_Coop"},
			FigureNpcSpawnToEntity	{Tag = "CerthisGuard01", Level = 5, UnitId = 311, TargetTag = "CourierHome", Team = "tm_Coop"},
			FigureNpcSpawnToEntity	{Tag = "CerthisGuard02", Level = 5, UnitId = 304, TargetTag = "CourierHome", Team = "tm_Coop"},

			FigureNpcSpawn	{Tag  = "HorsePackingHorse01", Level = 2, UnitId = 262, X = 275, Y = 335, Team = "tm_Coop"},
			FigureNpcSpawn	{Tag  = "HorsePackingHorse02", Level = 2, UnitId = 262, X = 275, Y = 335, Team = "tm_Coop"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush01Skeleton01", Level = 4, UnitId = 128, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush01Skeleton02", Level = 4, UnitId = 128, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush01Skeleton03", Level = 4, UnitId = 128, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush01Skeleton04", Level = 4, UnitId = 128, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush01Skeleton05", Level = 3, UnitId = 443, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush01Skeleton06", Level = 3, UnitId = 443, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush01Skeleton07", Level = 3, UnitId = 443, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush01Skeleton08", Level = 3, UnitId = 443, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush02Skeleton09", Level = 5, UnitId = 128, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush02Skeleton10", Level = 5, UnitId = 128, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush02Skeleton11", Level = 5, UnitId = 128, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush02Skeleton12", Level = 5, UnitId = 128, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush02Skeleton13", Level = 5, UnitId = 130, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush02Skeleton14", Level = 5, UnitId = 130, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush02Skeleton15", Level = 5, UnitId = 130, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},
			FigureNpcSpawnToEntity	{Tag  = "Ambush02Skeleton15", Level = 5, UnitId = 130, TargetTag = "MapQuestPortal", Team = "tm_Enemy"},

			MapFlagSetTrue {Name = "mf_CerthisRevealed"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_CerthisRevealed"},

		},
		Actions =
		{
			FigureLootItemEquipmentAdd	{Tag = "Certhis", DropChance = 100, ItemId = 1192},
			MapFlagSetTrue {Name = "mf_CerthisEquipped"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_CerthisEquipped"},
		},
		Actions =
		{
			FigureOutcry {Tag = "CitizenMale", TextTag = "Portal1"},
			FigureWalkToEntity	{Tag = "Certhis", TargetTag = "MapQuestPortal"},
			FigureWalkToEntity	{Tag = "CerthisGuard01", TargetTag = "MapQuestPortal"},
			FigureWalkToEntity	{Tag = "CerthisGuard02", TargetTag = "MapQuestPortal"},
			FigureWalkToEntity	{Tag = "HorsePackingHorse01", TargetTag = "MapQuestPortal"},
			FigureWalkToEntity	{Tag = "HorsePackingHorse02", TargetTag = "MapQuestPortal"},
			FigureRunToEntity	{Tag = "Ambush01Skeleton01", TargetTag = "Certhis"},
			FigureRunToEntity	{Tag = "Ambush01Skeleton02", TargetTag = "Certhis"},
			FigureRunToEntity	{Tag = "Ambush01Skeleton03", TargetTag = "Certhis"},
			FigureRunToEntity	{Tag = "Ambush01Skeleton04", TargetTag = "Certhis"},
			FigureRun	{Tag = "Ambush01Skeleton05", X = 415,Y = 340},
			FigureRun	{Tag = "Ambush01Skeleton06", X = 415,Y = 340},
			FigureRun	{Tag = "Ambush01Skeleton07", X = 415,Y = 340},
			FigureRun	{Tag = "Ambush01Skeleton08", X = 415,Y = 340},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_CerthisEquipped"},
			FigureIsInEntityRange	{Tag = "Certhis", TargetTag = "MapQuestPortal", Range = 10},
		},
		Actions =
		{			
			MapTimerStart   {Name = "mt_CerthisGetsKilled"},
			MapFlagSetTrue {Name = "mf_CerthisReachedPortal"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_CerthisReachedPortal"},
			MapTimerIsElapsed   {Name = "mt_CerthisGetsKilled", Seconds = 0.2},
		},
		Actions =
		{
			FigureCastSpell	{Tag = "Certhis", Spell = 50, Power = 1, X = 628.737, Y = 438.559},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_CerthisReachedPortal"},
			MapTimerIsElapsed   {Name = "mt_CerthisGetsKilled", Seconds = 1},
		},
		Actions =
		{
			EffectStart	{Tag = "Certhis", File = "Effect_Flash_Hit"},
			EffectStartAtEntityPosition	{Tag = "Certhis", File = "Effect_Misc_CoopHero_Hit"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_CerthisReachedPortal"},
			MapTimerIsElapsed   {Name = "mt_CerthisGetsKilled", Seconds = 1.3},
		},
		Actions =
		{
			MapFlagSetTrue	{Name = "mf_CerthisGetsKilled"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue {Name = "mf_CerthisReachedPortal"},
			MapTimerIsElapsed   {Name = "mt_CerthisGetsKilled", Seconds = 2},
		},
		Actions =
		{
			FigureOutcry	{Tag = "Certhis", TextTag = "Portal5"},
			FigureKill	{Tag = "Certhis"},
			FigureKill	{Tag = "CerthisGuard01"},
			FigureKill	{Tag = "CerthisGuard02"},
			FigureKill	{Tag = "HorsePackingHorse01"},
			FigureKill	{Tag = "HorsePackingHorse02"},
			MapTimerStop   {Name = "mt_CerthisGetsKilled"},
			MapFlagSetTrue	{Name = "mf_CerthisGone"},
		},
	},
	OnOneTimeEvent
	{
		Conditions =
		{
			MapFlagIsTrue	{Name = "mf_CerthisGone"},
		},
		Actions = 
		{
			QuestSetSolved	{Player = "pl_Human1", Quest = "CoopMapQuestRushwater"},
			QuestSetSolved	{Player = "pl_Human2", Quest = "CoopMapQuestRushwater"},
			QuestSetSolved	{Player = "pl_Human3", Quest = "CoopMapQuestRushwater"},
		},
	},
};