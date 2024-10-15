if (!isServer && hasInterface) exitWith {};
params ["_respawn", "_action"];

if (isNil "_respawn") exitWith {};
waitUntil {sleep 0.1; isNil "GRLIB_manage_respawn"};
GRLIB_manage_respawn = true;

private _tmp_global_locked_respawn = [];
{
	if (!isNil "_x") then {
		if (!isNull _x && alive _x ) then {
			_tmp_global_locked_respawn pushBack _x;
		};
	};
} foreach GRLIB_mobile_respawn;

switch (_action) do {
	case "add" : {
		GRLIB_mobile_respawn = _tmp_global_locked_respawn + [_respawn];
	};
	case "del" : {
		GRLIB_mobile_respawn = _tmp_global_locked_respawn - [_respawn];
		if (typeOf _respawn == mobile_respawn) then { deleteVehicle _respawn };
	};
	default {GRLIB_mobile_respawn = _tmp_global_locked_respawn};
};

publicVariable "GRLIB_mobile_respawn";
sleep 0.1;
GRLIB_manage_respawn = nil;