if (!isServer && hasInterface) exitWith {};
params [ "_intel", "_unit_owner" ];
if ( isNil "_intel" ) exitWith {};

private _msg = localize "STR_INTEL_NOTHING";

if (typeOf _intel in GRLIB_intel_items) then {
	private _rwd_intel = round (8 + random 18);
	resources_intel = resources_intel + _rwd_intel;

	[ 1 ] remoteExec ["remote_call_intel", 0];

	private _rwd_xp = 5;
	[_unit_owner, _rwd_xp] call F_addScore;
	_msg = format [localize "STR_INTEL_FOUND", name _unit_owner, _rwd_xp, _rwd_intel];
};

if (typeOf _intel in GRLIB_ide_traps) then {
    if ( ((random 100) < 30) ) then {
        private _rwd_xp = round (2 + random 8);
		private _rwd_ammo = round (35 + random 80);
		private _rwd_fuel = round (8 + random 10);

        [_unit_owner, _rwd_xp] call F_addScore;
        [_unit_owner, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
		_msg = format [localize "STR_INTEL_GOODS", name _unit_owner, _rwd_xp, _rwd_ammo, _rwd_fuel];
    };
};

deleteVehicle _intel;
[_msg] remoteExec ["hint", owner _unit_owner];