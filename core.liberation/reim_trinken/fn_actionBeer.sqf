/*
	author = Reimchen
	description = n.a.
*/

params ["_object"];

//
private _takeBeer = [
	"Reim_takeBeer_Action",
	"Nehme Bier",
	"",
	{
		[] spawn {
			if !(stance player == "STAND") then {player playAction "PlayerStand";};
			if (missionNamespace getVariable ["Reim_drink", false]) exitWith {hint "Ich sollte erstmal meinen Becher trinken, bevor ich mir einen neuen nehme..."};
			player setAnimSpeedCoef 0.85;
			player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
			sleep 1;
			player setAnimSpeedCoef 1;
			missionNamespace setVariable ["Reim_drinkBeer", true,false];
			missionNamespace setVariable ["Reim_drink", true,false];
		};
	},
	{true}
] call ace_interact_menu_fnc_createAction;
[_object,0,["ACE_MainActions"], _takeBeer] call ace_interact_menu_fnc_addActionToObject;
