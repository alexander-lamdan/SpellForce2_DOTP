local _uSM = GdsCreateStateMachine ("ayro_Dialog")

_uBeginState = GdsCreateState (_uSM, "WaitForBeginDialog")
_uState2 = GdsCreateState (_uSM, "State_2")
_uState5 = GdsCreateState (_uSM, "State_5")
_uState8 = GdsCreateState (_uSM, "State_8")

-- TO STATE: choice
_uState2Trans1 = GdsCreateTransition (_uState2, _uState2, "State_2", "State_2_T1", "Dialog")
	_uState2Trans1:AddCondition (CScriptConditionValue('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 0, 2))
	_uState2Trans1:AddCondition (CScriptConditionValue('', 'mf_P707_Ayro_Else_Done', 0, 2))
	_uState2Trans1:AddAction (CScriptActionChoice("P707_DLG_AYRO_003PC", "Is there anything more, you want to tell me?", 1, 16777215))
	_uState2Trans1:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 1, 4))
	_uState2Trans1:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uState2Trans1 = nil

-- TO STATE: choice
_uState2Trans2 = GdsCreateTransition (_uState2, _uState2, "State_2", "State_2_T2", "Dialog")
	_uState2Trans2:AddCondition (CScriptConditionValue('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 0, 2))
	_uState2Trans2:AddAction (CScriptActionChoice("P707_DLG_AYRO_008PC", "Would you join me in my mission, Ayro?", 2, 16777215))
	_uState2Trans2:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 1, 4))
	_uState2Trans2:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uState2Trans2 = nil

-- TO STATE: choice
_uState2Trans3 = GdsCreateTransition (_uState2, _uState2, "State_2", "State_2_T3", "Dialog")
	_uState2Trans3:AddCondition (CScriptConditionValue('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 2))
	_uState2Trans3:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 0, 4))
	_uState2Trans3:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesCameraFlag(AYRO)', 1, 4))
	_uState2Trans3:AddAction (CScriptActionShowChoices())
	_uState2Trans3 = nil

-- DIALOG ONETIME INIT:
_uStateBeginDialogInit = GdsCreateTransition (_uBeginState, _uBeginState, "BeginDialog", "BeginDialog", "DialogInit")
	_uStateBeginDialogInit:AddCondition (CScriptConditionScriptTagAlive('ayro'))
	_uStateBeginDialogInit:AddCondition (CScriptConditionValue('', 'GDS_DialogIsInitialized(AYRO)', 0, 2))
	_uStateBeginDialogInit:AddAction (CScriptActionValueModify('', 'GDS_DialogIsInitialized(AYRO)', 1, 4))
	_uStateBeginDialogInit:AddAction (CScriptActionSetDialog('ayro', 2))
	_uStateBeginDialogInit:AddAction (CScriptActionDialogEnable("ayro", 0))
	_uStateBeginDialogInit:AddAction (CScriptActionTimeStampSet('mt_AvatarIsNotTalking'))
	_uStateBeginDialogInit = nil

-- TO STATE: choice
_uStateBeginDelay = GdsCreateState (_uSM, "State_BeginDelay")
_uStateBeginDelayTrans = GdsCreateTransition (_uBeginState, _uStateBeginDelay, "BeginDialog", "StateBeginDelay", "Dialog")
	_uStateBeginDelayTrans:AddCondition (CScriptConditionDialogStarted("pl_Human", "ayro"))
	_uStateBeginDelayTrans:AddAction (CScriptActionCombatTurnOffAll(1))
	_uStateBeginDelayTrans:AddAction (CScriptActionValueModify('', 'GDS_AvatarIsTalking(AYRO)', 1, 4))
	_uStateBeginDelayTrans:AddAction (CScriptActionValueModify('', 'mf_AvatarIsTalking', 1, 4))
	_uStateBeginDelayTrans:AddAction (CScriptActionTimeStampReset('mt_AvatarIsNotTalking'))
	_uStateBeginDelayTrans:AddAction (CScriptActionTimeStampSet('et_DialogBeginCameraTimer(AYRO)'))
	_uStateBeginDelayTrans:AddAction (CScriptActionFigureHideWeapons('pl_HumanAvatar', 1))
	_uStateBeginDelayTrans:AddAction (CScriptActionFigureHideWeapons('ayro', 1))
	local _uRenderOnly = CScriptActionFigureRenderOnly("pl_HumanAvatar", 0)
		_uRenderOnly:Add("ayro")
		_uRenderOnly:Add("Uland")
		_uRenderOnly:Add("Ur_Dragon")
		_uRenderOnly:Add("RenderInDialog01")
		_uRenderOnly:Add("RenderInDialog02")
		_uRenderOnly:Add("RenderInDialog03")
		_uRenderOnly:Add("RenderInDialog04")
		_uRenderOnly:Add("RenderInDialog05")
		_uRenderOnly:Add("RenderInDialog06")
		_uRenderOnly:Add("RenderInDialog07")
		_uRenderOnly:Add("RenderInDialog08")
		_uRenderOnly:Add("RenderInDialog09")
		_uRenderOnly:Add("RenderInDialog10")
	_uStateBeginDelayTrans:AddAction (_uRenderOnly)
	-- reset all choice onetime flags upon dialog begin
	_uStateBeginDelayTrans:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 0, 4))
	_uStateBeginDelayTrans:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 0, 4))
_uStateBeginDelayTrans = GdsCreateTransition (_uStateBeginDelay, _uState2, "StateBeginDelay", "State_2_T4", "Dialog")
	_uStateBeginDelayTrans:AddCondition (CScriptConditionTimeElapsed('et_DialogBeginCameraTimer(AYRO)', 10))
	_uStateBeginDelayTrans:AddAction (CScriptActionSay("ayro", "P707_DLG_AYRO_001", "It's good to see you.", 100, 16777215))
	_uStateBeginDelayTrans:AddAction (CScriptActionSay("pl_HumanAvatar", "P707_DLG_AYRO_002PC", "You too, Ayro.", 101, 16777215))
	_uStateBeginDelayTrans:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uStateBeginDelayTrans = nil

-- TO STATE: choice
_uState2Trans5 = GdsCreateTransition (_uState2, _uState2, "State_2", "State_2_T5", "Dialog")
	_uState2Trans5:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 1))
	_uState2Trans5:AddAction (CScriptActionSay("pl_HumanAvatar", "P707_DLG_AYRO_003PC", "Is there anything more, you want to tell me?", 99, 16777215))
	_uState2Trans5:AddAction (CScriptActionSay("ayro", "P707_DLG_AYRO_004", "Sariel has been acting strange lately. She's agitated and short-tempered. A bit like your protegee was, before he left for Iron Fields.", 103, 16777215))
	_uState2Trans5:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 0, 4))
	_uState2Trans5:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 0, 4))
	_uState2Trans5:AddAction (CScriptActionSay("pl_HumanAvatar", "P707_DLG_AYRO_005PC", "I'd rather not be reminded of him, Ayro. But do you think she's under the influence? I've seen even ghosts succumb to Zazhuts will and she was so close to him...", 104, 16777215))
	_uState2Trans5:AddAction (CScriptActionSay("ayro", "P707_DLG_AYRO_006", "I don't know. But I have kept an eye out for her, these last couple of days. And so should you.", 105, 16777215))
	_uState2Trans5:AddAction (CScriptActionSay("pl_HumanAvatar", "P707_DLG_AYRO_007PC", "I will, Ayro, thank you.", 106, 16777215))
	_uState2Trans5:AddAction (CScriptActionValueModify('', 'mf_P707_Ayro_Else_Done', 1, 4))
	_uState2Trans5:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uState2Trans5 = nil

-- TO SELF: User chose 'Abort Dialog' (-1)
_uAbort = GdsCreateTransition (_uState2, _uState2, "State_2", "State_2", "Dialog")
	_uAbort:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 4294967295))
	_uAbort:AddAction (CScriptActionDialogRequestEnd("pl_Human", "ayro"))
	_uAbort = nil

-- TO STATE: WaitForBeginDialog (on user request)
_uBackToBegin = GdsCreateTransition (_uState2, _uBeginState, "State_2", "EndDialogOnUserRequest", "Dialog")
	_uBackToBegin:AddCondition (CScriptConditionDialogStopped("pl_Human", "ayro"))
	_uBackToBegin:AddAction (CScriptActionFigureHideWeapons('pl_HumanAvatar', 0))
	_uBackToBegin:AddAction (CScriptActionFigureHideWeapons('ayro', 0))
	_uBackToBegin:AddAction (CScriptActionTimeStampSet('mt_AvatarIsNotTalking'))
	_uBackToBegin:AddAction (CScriptActionValueModify('', 'GDS_AvatarIsTalking(AYRO)', 0, 4))
	_uBackToBegin:AddAction (CScriptActionValueModify('', 'mf_AvatarIsTalking', 0, 4))
	_uBackToBegin:AddAction (CScriptActionCameraTrackEnd())
	_uBackToBegin:AddAction (CScriptActionFigureRenderOnlyUnhide())
	_uBackToBegin:AddAction (CScriptActionCombatTurnOffAll(0))
	_uBackToBegin = nil

-- TO STATE: choice
_uState5Trans1 = GdsCreateTransition (_uState5, _uState5, "State_5", "State_5_T1", "Dialog")
	_uState5Trans1:AddCondition (CScriptConditionValue('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 0, 2))
	_uState5Trans1:AddAction (CScriptActionChoice("P707_DLG_AYRO_010PC", "Yes, Ayro, I want you to join me.", 1, 16777215))
	_uState5Trans1:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 1, 4))
	_uState5Trans1:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uState5Trans1 = nil

-- TO STATE: choice
_uState5Trans2 = GdsCreateTransition (_uState5, _uState5, "State_5", "State_5_T2", "Dialog")
	_uState5Trans2:AddCondition (CScriptConditionValue('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 0, 2))
	_uState5Trans2:AddAction (CScriptActionChoice("P707_DLG_AYRO_011PC", "Let me talk to Shae first.", 2, 16777215))
	_uState5Trans2:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 1, 4))
	_uState5Trans2:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uState5Trans2 = nil

-- TO STATE: choice
_uState5Trans3 = GdsCreateTransition (_uState5, _uState5, "State_5", "State_5_T3", "Dialog")
	_uState5Trans3:AddCondition (CScriptConditionValue('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 2))
	_uState5Trans3:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 0, 4))
	_uState5Trans3:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesCameraFlag(AYRO)', 1, 4))
	_uState5Trans3:AddAction (CScriptActionShowChoices())
	_uState5Trans3 = nil

-- TO STATE: choice
_uState5Trans4 = GdsCreateTransition (_uState2, _uState5, "State_2", "State_5_T4", "Dialog")
	_uState5Trans4:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 2))
	_uState5Trans4:AddAction (CScriptActionSay("pl_HumanAvatar", "P707_DLG_AYRO_008PC", "Would you join me in my mission, Ayro?", 99, 16777215))
	_uState5Trans4:AddAction (CScriptActionSay("ayro", "P707_DLG_AYRO_009", "I'm yours to command, you know that. My sword is ready but so is Shaes magic. Are you sure, you want me to join?", 108, 16777215))
	_uState5Trans4:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 0, 4))
	_uState5Trans4:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 0, 4))
	_uState5Trans4:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uState5Trans4 = nil

-- TO SELF: User chose 'Abort Dialog' (-1)
_uAbort = GdsCreateTransition (_uState5, _uState5, "State_5", "State_5", "Dialog")
	_uAbort:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 4294967295))
	_uAbort:AddAction (CScriptActionDialogRequestEnd("pl_Human", "ayro"))
	_uAbort = nil

-- TO STATE: WaitForBeginDialog (on user request)
_uBackToBegin = GdsCreateTransition (_uState5, _uBeginState, "State_5", "EndDialogOnUserRequest", "Dialog")
	_uBackToBegin:AddCondition (CScriptConditionDialogStopped("pl_Human", "ayro"))
	_uBackToBegin:AddAction (CScriptActionFigureHideWeapons('pl_HumanAvatar', 0))
	_uBackToBegin:AddAction (CScriptActionFigureHideWeapons('ayro', 0))
	_uBackToBegin:AddAction (CScriptActionTimeStampSet('mt_AvatarIsNotTalking'))
	_uBackToBegin:AddAction (CScriptActionValueModify('', 'GDS_AvatarIsTalking(AYRO)', 0, 4))
	_uBackToBegin:AddAction (CScriptActionValueModify('', 'mf_AvatarIsTalking', 0, 4))
	_uBackToBegin:AddAction (CScriptActionCameraTrackEnd())
	_uBackToBegin:AddAction (CScriptActionFigureRenderOnlyUnhide())
	_uBackToBegin:AddAction (CScriptActionCombatTurnOffAll(0))
	_uBackToBegin = nil

-- TO STATE: endconversation
_uState8Trans1 = GdsCreateTransition (_uState5, _uState8, "State_5", "State_8_T1", "Dialog")
	_uState8Trans1:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 1))
	_uState8Trans1:AddAction (CScriptActionSay("pl_HumanAvatar", "P707_DLG_AYRO_010PC", "Yes, Ayro, I want you to join me.", 99, 16777215))
	_uState8Trans1:AddAction (CScriptActionDialogRequestEnd("pl_Human", "ayro"))
	_uState8Trans1:AddAction (CScriptActionValueModify('', 'GDS_DialogEndActionFlag1(AYRO)', 1, 4))
	_uState8Trans1:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 0, 4))
	_uState8Trans1:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 0, 4))
	_uState8Trans1:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uState8Trans1 = nil

-- TO STATE: endconversation
_uState8Trans2 = GdsCreateTransition (_uState5, _uState8, "State_5", "State_8_T2", "Dialog")
	_uState8Trans2:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 2))
	_uState8Trans2:AddAction (CScriptActionSay("pl_HumanAvatar", "P707_DLG_AYRO_011PC", "Let me talk to Shae first.", 99, 16777215))
	_uState8Trans2:AddAction (CScriptActionDialogRequestEnd("pl_Human", "ayro"))
	_uState8Trans2:AddAction (CScriptActionValueModify('', 'GDS_DialogEndActionFlag2(AYRO)', 1, 4))
	_uState8Trans2:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag1(AYRO)', 0, 4))
	_uState8Trans2:AddAction (CScriptActionValueModify('', 'GDS_DialogChoiceOneTimeFlag2(AYRO)', 0, 4))
	_uState8Trans2:AddAction (CScriptActionValueModify('', 'GDS_DialogShowChoicesFlag(AYRO)', 1, 4))
	_uState8Trans2 = nil

-- TO SELF: EndConversation Actions #1
_uEndActions1 = GdsCreateTransition (_uState8, _uState8, "State_8", "EndActions_1", "Dialog")
	_uEndActions1:AddCondition (CScriptConditionValue('', 'GDS_DialogEndActionFlag1(AYRO)', 1, 2))
	_uEndActions1:AddCondition (CScriptConditionDialogStopped("pl_Human", "ayro"))
	_uEndActions1:AddAction (CScriptActionDialogEnable('Ayro', 0))
	_uEndActions1:AddAction (CScriptActionValueModify('', 'mf_P707_Ayro_Chosen', 1, 4))
	_uEndActions1:AddAction (CScriptActionValueModify('', 'GDS_DialogEndActionFlag1(AYRO)', 0, 4))
	_uEndActions1:AddAction (CScriptActionValueModify('', 'GDS_DialogForceStopDialog(AYRO)', 1, 4))
	_uEndActions1 = nil

-- TO SELF: EndConversation Actions #2
_uEndActions2 = GdsCreateTransition (_uState8, _uState8, "State_8", "EndActions_2", "Dialog")
	_uEndActions2:AddCondition (CScriptConditionValue('', 'GDS_DialogEndActionFlag2(AYRO)', 1, 2))
	_uEndActions2:AddCondition (CScriptConditionDialogStopped("pl_Human", "ayro"))
	_uEndActions2:AddAction (CScriptActionValueModify('', 'GDS_DialogEndActionFlag2(AYRO)', 0, 4))
	_uEndActions2:AddAction (CScriptActionValueModify('', 'GDS_DialogForceStopDialog(AYRO)', 1, 4))
	_uEndActions2 = nil

-- TO STATE: WaitForBeginDialog (on script request)
_uBackToBegin = GdsCreateTransition (_uState8, _uBeginState, "State_8", "EndDialogOnScriptRequest", "Dialog")
	_uBackToBegin:AddCondition (CScriptConditionValue('', 'GDS_DialogForceStopDialog(AYRO)', 1, 2))
	_uBackToBegin:AddAction (CScriptActionValueModify('', 'GDS_DialogForceStopDialog(AYRO)', 0, 4))
	_uBackToBegin:AddAction (CScriptActionFigureHideWeapons('pl_HumanAvatar', 0))
	_uBackToBegin:AddAction (CScriptActionFigureHideWeapons('ayro', 0))
	_uBackToBegin:AddAction (CScriptActionTimeStampSet('mt_AvatarIsNotTalking'))
	_uBackToBegin:AddAction (CScriptActionValueModify('', 'GDS_AvatarIsTalking(AYRO)', 0, 4))
	_uBackToBegin:AddAction (CScriptActionValueModify('', 'mf_AvatarIsTalking', 0, 4))
	_uBackToBegin:AddAction (CScriptActionCameraTrackEnd())
	_uBackToBegin:AddAction (CScriptActionFigureRenderOnlyUnhide())
	_uBackToBegin:AddAction (CScriptActionCombatTurnOffAll(0))
	_uBackToBegin = nil

-- CLEANUP STATE VARS:
_uBeginState = nil
_uState2 = nil
_uState5 = nil
_uState8 = nil


-------------------------------------------------------------------------------------------
-- Dialog Camera Statemachine
-------------------------------------------------------------------------------------------
local _uBeginState
local _uCameraSelectState
local _uTrans
local _uCameraActiveState
local _uCameraSelectState

local _uSM = GdsCreateStateMachine ("ayro_Dialog_Camera")

_uBeginState = GdsCreateState (_uSM, "WaitForBeginDialog")
_uCameraSelectState = GdsCreateState (_uSM, "DialogSelectCamera")

_uTrans = GdsCreateTransition(_uBeginState, _uCameraSelectState, "_uBeginState", "_uCameraSelectState", "DialogBegins")
	_uTrans:AddCondition (CScriptConditionValue('', 'GDS_AvatarIsTalking(AYRO)', 1, 2))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_BeginDialog.tak', 'pl_HumanAvatar', 'ayro'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

_uTrans = GdsCreateTransition(_uCameraSelectState, _uBeginState, "_uCameraSelectState", "_uBeginState", "DialogEnds")
	_uTrans:AddCondition (CScriptConditionValue('', 'GDS_AvatarIsTalking(AYRO)', 0, 2))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())


-- Camera State: DialogActiveCamera[100]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[100]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 100))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_NpcDialog.tak', 'pl_HumanAvatar', 'ayro'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[101]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[101]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 101))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_AvatarDialog.tak', 'ayro', 'pl_HumanAvatar'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[102]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[102]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 102))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_AvatarDialog.tak', 'ayro', 'pl_HumanAvatar'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[107]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[107]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 107))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_AvatarDialog.tak', 'ayro', 'pl_HumanAvatar'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[103]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[103]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 103))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_NpcDialog.tak', 'pl_HumanAvatar', 'ayro'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[104]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[104]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 104))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_AvatarDialog.tak', 'ayro', 'pl_HumanAvatar'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[105]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[105]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 105))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_NpcDialog.tak', 'pl_HumanAvatar', 'ayro'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[106]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[106]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 106))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_AvatarDialog.tak', 'ayro', 'pl_HumanAvatar'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[108]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[108]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 108))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_NpcDialog.tak', 'pl_HumanAvatar', 'ayro'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[109]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[109]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 109))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_AvatarDialog.tak', 'ayro', 'pl_HumanAvatar'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[110]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[110]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 110))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_AvatarDialog.tak', 'ayro', 'pl_HumanAvatar'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())

-- Camera State: DialogActiveCamera[99]
_uTrans = GdsCreateTransition (_uCameraSelectState, _uCameraSelectState, "DialogSelectCamera", "DialogActiveCamera[99]", "CameraStart")
	_uTrans:AddCondition (CScriptConditionDialogSelected("pl_Human", "ayro", 99))
	_uTrans:AddAction (CScriptActionCameraTrackEnd())
	_uTrans:AddAction (CScriptActionAddCameraTake('base/script/DialogCameraTakes/default_AvatarDialog.tak', 'ayro', 'pl_HumanAvatar'))
	_uTrans:AddAction (CScriptActionCameraTrackBegin())
