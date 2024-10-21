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
			FigureVanish {}
		},
	},
	OnFigureRespawnEvent
	{
		WaitTime = 1,
		X = GetEntityX(),
		Y = GetEntityY(),
		Conditions =
		{
			MapValueIsEqual {Name = "mv_P465_GatheredLenya", Value = 5},
			OR
			{
				AvatarValueIsEqual {Name = "av_P465_ArenaState", Value = avatarValue1},
				AvatarValueIsEqual {Name = "av_P465_ArenaState", Value = avatarValue2},
			},
			MapFlagIsTrue {Name = "mf_P465_ArenaFightRunning"},
		},
		Actions =
		{
			FigureTeleportToEntity {TargetTag = "pl_HumanAvatar"},
			EntityFlagSetTrue {Name = "ef_P465_Spawned"},
			MapValueSet {Name = "mv_P465_GatheredLenya", Value = 0},
		},
	},
	OnFollowEvent	
	{
		TargetTag = "pl_HumanAvatar", 
		OnConditions =
		{
		},
		Actions =
		{
		},
	},
	OnEvent
	{
		Conditions =
		{
			MapFlagIsFalse {Name = "mf_P465_ArenaFightRunning"},
			EntityFlagIsTrue {Name = "ef_P465_Spawned"},
		},
		Actions =
		{
			EntityFlagSetFalse {Name = "ef_P465_Spawned"},
			FigureVanish {},
		}
	}
}