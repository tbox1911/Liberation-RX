private _action = ["assign_Medic","assign Medic","",{
	//Code
	
	_XmedicsInGroup = group player getvariable ["BIS_dg_xmed",0];
	
	if (ceil ((count units group player)/ MSU_Med_Div) > _XmedicsInGroup ) then{
		_Player setVariable ["ace_medical_medicclass", 2, true];
		
		_newamount = _XmedicsInGroup + 1;
		group player setvariable ["BIS_dg_xmed",_newamount];
	}else {
		hint format ["There is already %1 Medic in the group %2",_XmedicsInGroup, groupId group _Player] ; 
	};
	
},{
	//Condition
	(round (player distance2D ([] call F_getNearestFob)) < 20 || (player distance2D lhd) <= 200) && (_Player getVariable ["ace_medical_medicclass", true] == 0 ) && (_Player getVariable ["ACE_isEngineer", true] == 0 );
}] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","ACE_TeamManagement"],_action,true] call ace_interact_menu_fnc_addActionToClass;

private _action = ["unassign_Medic","unassign Medic","",{
	//Code
	
	_XmedicsInGroup = group player getvariable ["BIS_dg_xmed",0];
		
	_newamount = _XmedicsInGroup - 1;
	group player setvariable ["BIS_dg_xmed",_newamount];
	
	_Player setVariable ["ace_medical_medicclass", 0, true];	
	
},{
	//Condition
	(round (player distance2D ([] call F_getNearestFob)) < 20 || (player distance2D lhd) <= 200) && (_Player getVariable ["ace_medical_medicclass", true] != 0) ;
}] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","ACE_TeamManagement"],_action,true] call ace_interact_menu_fnc_addActionToClass;