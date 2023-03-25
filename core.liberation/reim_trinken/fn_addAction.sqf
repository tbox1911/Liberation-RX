/*
	author = Reimchen
	description = n.a.
*/

params ["_object"];

private _drinkAlkfree = [
	"Reim_drinkAlkfree_Action",
	"Trinke Alkoholfreies",
	"",
	{
		missionNamespace setVariable ["Reim_drinkAlkfree", false,false];
		missionNamespace setVariable ["Reim_drink", false,false];
		if !(stance player == "STAND") then {player playAction "PlayerStand";};
		player playMove "acex_field_rations_drinkStandCan";
		addCamShake [5, 3, 3];
		Reim_Var_Trinken = Reim_Var_Trinken +5; 
	},
	{missionNamespace getVariable ["Reim_drinkAlkfree", false]}
] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions"], _drinkAlkfree] call ace_interact_menu_fnc_addActionToObject;

private _drinkBeer = [
	"Reim_drinkBeer_Action",
	"Trinke Bier",
	"",
	{
		missionNamespace setVariable ["Reim_drinkBeer", false,false];
		missionNamespace setVariable ["Reim_drink", false,false];
		if !(stance player == "STAND") then {player playAction "PlayerStand";};
		player playMove "acex_field_rations_drinkStandCan";
		addCamShake [5, 1, 0.5];
		Reim_Var_Trinken = Reim_Var_Trinken +1;
	},
	{missionNamespace getVariable ["Reim_drinkBeer", false]}
] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions"], _drinkBeer] call ace_interact_menu_fnc_addActionToObject;

private _drinkAlkhigh = [
	"Reim_drinkAlkhigh_Action",
	"Trinke Hochprozentiges",
	"",
	{
		missionNamespace setVariable ["Reim_drinkAlkhigh", false,false];
		missionNamespace setVariable ["Reim_drink", false,false];
		if !(stance player == "STAND") then {player playAction "PlayerStand";};
		player playMove "acex_field_rations_drinkStandCan";
		addCamShake [5, 1, 1.5];
		Reim_Var_Trinken = Reim_Var_Trinken +3;
	},
	{missionNamespace getVariable ["Reim_drinkAlkhigh", false]}
] call ace_interact_menu_fnc_createAction;
[player,1,["ACE_SelfActions"], _drinkAlkhigh] call ace_interact_menu_fnc_addActionToObject;
