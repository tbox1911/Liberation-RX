/*
	author = Reimchen
	description = n.a.
*/

params ["_object"];

//
private _takeAlkhigh = [
	"Reim_takeAlkhigh_Action",
	"Nehme Hochprozentiges",
	"",
	{
		[] spawn {
			if !(stance player == "STAND") then {player playAction "PlayerStand";};
			if (missionNamespace getVariable ["Reim_drink", false]) exitWith {hint "Ich sollte erstmal meinen Becher trinken, bevor ich mir einen neuen nehme..."};
			player setAnimSpeedCoef 0.85;
			player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
			sleep 1;
			player setAnimSpeedCoef 1;
			missionNamespace setVariable ["Reim_drinkAlkhigh", true,false];
			missionNamespace setVariable ["Reim_drink", true,false];
		};
	},
	{true}
] call ace_interact_menu_fnc_createAction;
[_object,0,["ACE_MainActions"], _takeAlkhigh] call ace_interact_menu_fnc_addActionToObject;
