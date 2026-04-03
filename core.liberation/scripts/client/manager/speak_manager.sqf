params ["_unit", ["_msg", 0]];
if (isNil "_unit") exitWith {};
if (player distance2D _unit > 50) exitWith {};

if (!isNil {_unit getVariable "GRLIB_speaking"}) exitWith {};
_unit setVariable ["GRLIB_speaking", true];

if (_unit isKindOf "CAManBase") then {
	[_unit, (_unit getDir player)] remoteExec ["setDir", 0];
	[_unit] remoteExec ["doStop", 0];
};

if (!isNil {_unit getVariable "PAR_Grp_ID"}) then {
	[_unit] spawn speak_squad_AI;
} else {
	if (_msg > 0) then {
		switch (_msg) do {
			// unit
			case 1 :  {[_unit] spawn speak_info_unit};
			case 10 : {[_unit] spawn speak_insult_unit};
			case 2 :  {[_unit] spawn speak_heal_player};
			case 3 :  {[_unit] spawn speak_repair_vehicle};
			case 4 :  {[_unit] spawn speak_reammo_player};
			case 5 :  {[_unit] spawn speak_join_player};

			// vehicle
			case 20 :  {[_unit] spawn speak_repair};
			case 21 :  {[_unit] spawn speak_player_repair};
			case 22 :  {[_unit] spawn speak_refuel};
			case 23 :  {[_unit] spawn speak_player_refuel};
			default {};
		};
	} else {
		[_unit] spawn speak_civil_AI;
	};
};
