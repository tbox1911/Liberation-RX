params ["_vehicle"];

private _vehicle_class = typeOf _vehicle;
private _ret = false;
private _alive = alive _vehicle;
private _r3f_enabled = !(_vehicle getVariable ['R3F_LOG_disabled', false]);
private _grl_isempty = (count (_vehicle getVariable ["GRLIB_ammo_truck_load", []]) == 0);
private _r3f_isempty = (count (_vehicle getVariable ["R3F_LOG_objets_charges", []]) == 0);
private _manned = _vehicle getVariable ["GRLIB_vehicle_manned", false];
private _empty = (count (crew _vehicle) == 0 || _manned);

if (GRLIB_player_near_fob && PAR_Grp_ID == [GRLIB_player_nearest_fob] call F_getFobOwner && !_r3f_enabled && _vehicle_class in all_buildings_classnames) exitWith { true };

if (_vehicle_class == box_uavs_typename) then { _r3f_isempty = true };
if (GRLIB_player_is_menuok && _alive && _empty && !GRLIB_player_near_lhd && GRLIB_player_near_fob && _r3f_enabled && _grl_isempty && _r3f_isempty && (isNull attachedTo _vehicle)) then {
	if ([_vehicle, GRLIB_vehicle_whitelist] call F_itemIsInClass) exitWith { _ret = true };
	if ([_vehicle, GRLIB_recycleable_classnames] call F_itemIsInClass) then {
		if ([player, _vehicle] call is_owner) exitWith { _ret = true };
		if ([_vehicle] call F_getBuildPerm && ([player, 4] call fetch_permission)) exitWith { _ret = true };
	};
};

_ret;