if (!isServer && hasInterface) exitWith {};
params ["_intel", "_unit_owner"];

if (isNil "_intel") exitWith {};

if (typeOf _intel in GRLIB_intel_items) exitWith {
	private _rwd_intel = round (8 + random 18);
	private _rwd_xp = round (5 + random 3);
	resources_intel = resources_intel + _rwd_intel;
	[1] remoteExec ["remote_call_intel", 0];
	[_unit_owner, _rwd_xp] call F_addScore;
	deleteVehicle _intel;
	sleep 1;
	[9, [1, _rwd_intel, _rwd_xp, 0, 0]] remoteExec ["remote_call_intel", owner _unit_owner];
};

if (typeOf _intel in GRLIB_ide_traps) exitWith {
	if (floor random 2 == 0) then {
		private _rwd_xp = round (2 + random 8);
		private _rwd_ammo = round (35 + random 80);
		private _rwd_fuel = round (8 + random 10);
		[_unit_owner, _rwd_xp] call F_addScore;
		[_unit_owner, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
		[9, [2, 0, _rwd_xp, _rwd_ammo, _rwd_fuel]] remoteExec ["remote_call_intel", owner _unit_owner];
	};
	deleteVehicle _intel;
};
