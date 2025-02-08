if (!isServer && hasInterface) exitWith {};
params ["_intel", "_unit_owner"];

if (isNil "_intel") exitWith {};

private _found = 0;
private _rwd_xp = 0;
private _rwd_ammo = 0;
private _rwd_fuel = 0;
private _rwd_intel = 0;

if (typeOf _intel in GRLIB_intel_items) then {
	_rwd_intel = round (8 + random 18);
	_rwd_xp = round (5 + random 3);
	resources_intel = resources_intel + _rwd_intel;
	[ 1 ] remoteExec ["remote_call_intel", 0];
	[_unit_owner, _rwd_xp] call F_addScore;
	_found = 1;
};

if (typeOf _intel in GRLIB_ide_traps) then {
    if (floor random 2 == 0) then {
        _rwd_xp = round (2 + random 8);
		_rwd_ammo = round (35 + random 80);
		_rwd_fuel = round (8 + random 10);
        [_unit_owner, _rwd_xp] call F_addScore;
        [_unit_owner, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
		_found = 2;
    };
};

deleteVehicle _intel;

[[_found, _rwd_intel, _rwd_xp, _rwd_ammo, _rwd_fuel], {
	params ["_found", "_rwd_intel", "_rwd_xp", "_rwd_ammo", "_rwd_fuel"];
	private _msg = localize "STR_INTEL_NOTHING";
	if (_found == 1) then {
		_msg = format [localize "STR_INTEL_FOUND", name player, _rwd_xp, _rwd_intel];
	};
	if (_found == 2) then {
		_msg = format [localize "STR_INTEL_GOODS", name player, _rwd_xp, _rwd_ammo, _rwd_fuel];
	};
	hint _msg;
}] remoteExec ["bis_fnc_call", owner _unit_owner];
