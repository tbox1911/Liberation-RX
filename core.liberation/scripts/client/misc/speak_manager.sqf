params ["_unit", ["_msg", 0]];
if (isNil "_unit") exitWith {};
if (!isNil "GRLIB_speaking") exitWith {};
if (player distance2D _unit > 50) exitWith {};

GRLIB_speaking = true;
if (_unit isKindOf "CAManBase") then {
	[_unit, (_unit getDir player)] remoteExec ["setDir", 0];
	[_unit, true] remoteExec ["stop", 0];
};

if (_unit in (units player)) then {
	[_unit] call speak_squad_AI;
} else {
	if (_msg > 0) then {
		switch (_msg) do {
			// unit
			case 1 :  {[_unit] call speak_info_unit};
			case 10 : {[_unit] call speak_insult_unit};
			case 2 :  {[_unit] call speak_heal_player};
			case 3 :  {[_unit] call speak_repair_vehicle};
			case 4 :  {[_unit] call speak_reammo_player};
			case 5 :  {[_unit] call speak_join_player};

			// vehicle
			case 20 :  {[_unit] call speak_repair};
			case 21 :  {[_unit] call speak_player_repair};
			case 22 :  {[_unit] call speak_refuel};
			case 23 :  {[_unit] call speak_player_refuel};
			default {};
		};
	} else {
		[_unit] call speak_civil_AI;
	};
};

sleep 3;
if (_unit isKindOf "CAManBase") then {
	[_unit, false] remoteExec ["stop", 0];
};
GRLIB_speaking = nil;