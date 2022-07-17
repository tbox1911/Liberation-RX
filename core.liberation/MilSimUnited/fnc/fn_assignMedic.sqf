if (isNil "MSU_Med_Div") then {MSU_Med_Div = 4;};

#define mkr_support ["b_hq",	"b_support",	"b_maint",	"b_installation", "b_antiair", "b_air"]
#define mkr_attack [	"b_armor",	"b_art",	"b_mortar",	"b_att_air",	"b_plane",	"b_naval","b_plane_cas","b_plane_cap", "b_plane_sead","b_plane_multi","b_plane_cargo"]
Support_Squad = mkr_support + mkr_attack;

private _action = ["assign_Medic","assign Medic","",{
	//Code
	
	_XmedicsInGroup = group _Player getvariable ["BIS_dg_xmed",0];
	
	if (ceil ((count units group _Player)/ MSU_Med_Div) > _XmedicsInGroup ) then{
		_Player setVariable ["ace_medical_medicclass", 2, true];
		
		_newamount = _XmedicsInGroup + 1;
		group _Player setvariable ["BIS_dg_xmed",_newamount];
	}else {
		hint format [localize "STR_MSU_ROLLMED",_XmedicsInGroup, groupId group _Player] ; 
	};
	
},{
	//Condition
	(round (_Player distance2D ([] call F_getNearestFob)) < 150 || (_Player distance2D lhd) <= 200) && (_Player getVariable ["ace_medical_medicclass", true] == 0 ) && (_Player getVariable ["ACE_isEngineer", true] == 0 ) && ["IsGroupRegistered", [group _Player]] call BIS_fnc_dynamicGroups && !(group player getVariable ["BIS_dg_rol","b_unknown"] in Support_Squad);
}] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","ACE_TeamManagement"],_action,true] call ace_interact_menu_fnc_addActionToClass;

private _action = ["unassign_Medic","unassign Medic","",{
	//Code
	
	_XmedicsInGroup = group _Player getvariable ["BIS_dg_xmed",0];
		
	_newamount = _XmedicsInGroup - 1;
	group _Player setvariable ["BIS_dg_xmed",_newamount];
	
	_Player setVariable ["ace_medical_medicclass", 0, true];	
	
},{
	//Condition
	(round (_Player distance2D ([] call F_getNearestFob)) < 150 || (_Player distance2D lhd) <= 200) && (_Player getVariable ["ace_medical_medicclass", true] != 0) ;
}] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","ACE_TeamManagement"],_action,true] call ace_interact_menu_fnc_addActionToClass;




[
	{
	_Grouprole = group Player getVariable ["BIS_dg_rol","b_unknown"];
		If (_Grouprole in Support_Squad) then {
			If (Player getVariable ["ace_medical_medicclass", 2] == 2) then {
				Player setVariable ["ace_medical_medicclass", 0, true];
				
				_XmedicsInGroup = group Player getvariable ["BIS_dg_xmed",0];
					
				_newamount = _XmedicsInGroup - 1;
				group Player setvariable ["BIS_dg_xmed",_newamount];
				hint format [localize "STR_MSU_ROLLBLOCKMEDIC",groupId group player] ; 
			};
		};
	}, 60, [Support_Squad]
] call CBA_fnc_addPerFrameHandler;