/*
	author = Reimchen
	description = n.a.
*/

if (isServer) exitWith {};

//
enableCamShake true;

//setze alklevel auf null bei start
missionNamespace setVariable ["Reim_Var_Trinken",-1,false];

[] spawn reim_trinken_fnc_addAction;
[] spawn reim_trinken_fnc_lower;
[] spawn reim_trinken_fnc_effect;