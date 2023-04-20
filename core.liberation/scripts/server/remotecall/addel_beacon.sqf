if (!isServer && hasInterface) exitWith {};
params ["_beacon", "_action"];

if (isNil "_beacon") exitWith {};

private _tmp_global_locked_beacon = [];
{
	if (!isNil "_x") then {
		if (!isNull _x && alive _x ) then {
			_tmp_global_locked_beacon pushBack _x;
		};
	};
} foreach GRLIB_mobile_respawn;

switch (_action) do {
	case "add" : {GRLIB_mobile_respawn = _tmp_global_locked_beacon + [_beacon]};
	case "del" : {GRLIB_mobile_respawn = _tmp_global_locked_beacon - [_beacon];	deleteVehicle _beacon };
	default {GRLIB_mobile_respawn = _tmp_global_locked_beacon};
};

publicVariable "GRLIB_mobile_respawn";