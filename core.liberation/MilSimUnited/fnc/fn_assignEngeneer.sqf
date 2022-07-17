
if (isNil "MSU_Eng_Div") then {MSU_Eng_Div = 6;};

private _action = ["assign_Engeneer","assign Engeneer","",{
	//Code

	_XengeneerInGroup = group player getvariable ["BIS_dg_xeng",0];

	if (ceil ((count units group player)/ MSU_Eng_Div) > _XengeneerInGroup ) then{
		_Player setVariable ["ACE_isEngineer", 1, true];
		_Player setVariable ["ACE_isEOD", 1, true];
		_newamount = _XengeneerInGroup + 1;
		group player setvariable ["BIS_dg_xeng",_newamount,true];
		hint format [localize "STR_MSU_ENG"];
	}else {
		hint format [localize "STR_MSU_ROLLENG",_XengeneerInGroup, groupId group _Player]; 
	};

},{
	//Condition
	(round (player distance2D ([] call F_getNearestFob)) < 20 || (player distance2D lhd) <= 200)&& (_Player getVariable ["ace_medical_medicclass",0] == 0 ) && (_Player getVariable ["ACE_isEngineer", 0] == 0 ) && ["IsGroupRegistered", [group player]] call BIS_fnc_dynamicGroups;
}] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","ACE_TeamManagement"],_action,true] call ace_interact_menu_fnc_addActionToClass;


private _action = ["unassign_Engeneer","unassign Engeneer","",{
	//Code

	_XengeneerInGroup = group player getvariable ["BIS_dg_xeng",0];

	_newamount = _XengeneerInGroup - 1;
	group player setvariable ["BIS_dg_xeng",_newamount,true]; 
	
	
	_Player setVariable ["ACE_isEngineer", 0, true];
	_Player setVariable ["ACE_isEOD", 0, true];
	hint format [localize "STR_MSU_NENG"];

},{
	//Condition
	(round (player distance2D ([] call F_getNearestFob)) < 20 || (player distance2D lhd) <= 200)&& (_Player getVariable ["ACE_isEngineer", 0] != 0 );
}] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","ACE_TeamManagement"],_action,true] call ace_interact_menu_fnc_addActionToClass;

