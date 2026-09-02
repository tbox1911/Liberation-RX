if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_notif_type", "_notif_data"];

private _obj_position = getPosATL player;

if (_notif_type == 0) exitWith {
	private _friendly = _notif_data select 0;
	if (_friendly) then {
		["lib_intel_hostage"] call BIS_fnc_showNotification;
	} else {
		["lib_intel_prisoner"] call BIS_fnc_showNotification;
	};
};

if (_notif_type == 1) exitWith {
	["lib_intel_document"] call BIS_fnc_showNotification;
};

if (_notif_type == 2) exitWith {
	waitUntil { !isNil "secondary_objective_position_marker" };
	waitUntil { secondary_objective_position_marker distance2D zeropos > 300 };

	private _location_name = [secondary_objective_position_marker] call F_getLocationName;
	["lib_intel_fob", [_location_name]] call BIS_fnc_showNotification;

	private _secondary_random_position_marker = secondary_objective_position_marker getPos [800, floor random 360];
	private _secondary_marker = createMarkerLocal ["secondarymarker", _secondary_random_position_marker];
	_secondary_marker setMarkerColorLocal GRLIB_color_enemy_bright;
	_secondary_marker setMarkerTypeLocal "hd_unknown";

	private _secondary_marker_zone = createMarkerLocal ["secondarymarkerzone", _secondary_random_position_marker];
	_secondary_marker_zone setMarkerColorLocal GRLIB_color_enemy_bright;
	_secondary_marker_zone setMarkerShapeLocal "ELLIPSE";
	_secondary_marker_zone setMarkerBrushLocal "FDiagonal";
	_secondary_marker_zone setMarkerSizeLocal [1500,1500];
};

if (_notif_type == 3) exitWith {
	["lib_secondary_fob_destroyed"] call BIS_fnc_showNotification;
	deleteMarkerLocal "secondarymarker";
	deleteMarkerLocal "secondarymarkerzone";
	secondary_objective_position_marker = zeropos;
};

if (_notif_type == 4) exitWith {
	private _spawn_position = _notif_data select 0;
	waitUntil {_spawn_position distance2D zeropos > 300 };
	private _location_name = [_spawn_position] call F_getLocationName;
	["lib_intel_convoy", [_location_name]] call BIS_fnc_showNotification;
};

if (_notif_type == 5) exitWith {
	private _success = _notif_data select 0;
	if (_success) then {
		["lib_secondary_convoy_success"] call BIS_fnc_showNotification;
	} else {
		["lib_secondary_convoy_failed"] call BIS_fnc_showNotification;
	};
};

if (_notif_type == 6) exitWith {
	waitUntil {!isNil "secondary_objective_position_marker" };
	waitUntil {count secondary_objective_position_marker > 0 };
	waitUntil {secondary_objective_position_marker distance2D zeropos > 300 };

	private _location_name = [secondary_objective_position_marker] call F_getLocationName;
	["lib_intel_sar", [_location_name]] call BIS_fnc_showNotification;

	private _secondary_random_position_marker = secondary_objective_position_marker getPos [800, floor random 360];
	private _secondary_marker = createMarkerLocal ["secondarymarker", _secondary_random_position_marker];
	_secondary_marker setMarkerColorLocal GRLIB_color_enemy_bright;
	_secondary_marker setMarkerTypeLocal "hd_unknown";

	private _secondary_marker_zone = createMarkerLocal ["secondarymarkerzone", _secondary_random_position_marker];
	_secondary_marker_zone setMarkerColorLocal GRLIB_color_enemy_bright;
	_secondary_marker_zone setMarkerShapeLocal "ELLIPSE";
	_secondary_marker_zone setMarkerBrushLocal "FDiagonal";
	_secondary_marker_zone setMarkerSizeLocal [1500,1500];
};

if (_notif_type == 7 || _notif_type == 8) exitWith {
	if (_notif_type == 7) then {
		["lib_intel_sar_failed"] call BIS_fnc_showNotification;
	};
	if (_notif_type == 8) then {
		["lib_intel_sar_succeeded"] call BIS_fnc_showNotification;
	};
	deleteMarkerLocal "secondarymarker";
	deleteMarkerLocal "secondarymarkerzone";
	secondary_objective_position_marker = zeropos;
};

if (_notif_type == 9) exitWith {
	_notif_data params ["_found", "_rwd_intel", "_rwd_xp", "_rwd_ammo", "_rwd_fuel"];
	private _msg = localize "STR_INTEL_NOTHING";
	if (_found == 1) then {
		_msg = format [localize "STR_INTEL_FOUND", name player, _rwd_xp, _rwd_intel];
	};
	if (_found == 2) then {
		_msg = format [localize "STR_INTEL_GOODS", name player, _rwd_xp, _rwd_ammo, _rwd_fuel];
	};
	hint _msg;
};
