params ["_vehicle"];

private _ret = false;
private _alive = alive player;
private _onfoot = isNull objectParent player;
private _R3F_move = isNull R3F_LOG_joueur_deplace_objet;
private _far_lhd = player distance2D lhd >= 200;
private _noflight = getPosATL player select 2 <= 5;
private _r3f_enabled = !(_vehicle getVariable ['R3F_LOG_disabled', false]);
private _grl_isempty = (_vehicle getVariable ["GRLIB_ammo_truck_load", 0] == 0);
private _r3f_isempty = (count (_vehicle getVariable ["R3F_LOG_objets_charges", []]) == 0);

private	_nearestfob = [] call F_getNearestFob;
private	_fobdistance = 9999;
if ( count _nearestfob == 3 ) then {
	_fobdistance = round (player distance2D _nearestfob);
};
private _nearfob = _fobdistance <= GRLIB_fob_range;

if ( _alive && _onfoot && _R3F_move && _far_lhd && _nearfob && _noflight && _r3f_enabled && _grl_isempty && _r3f_isempty && (isNull attachedTo _vehicle)) then {
	if ([typeOf _vehicle, GRLIB_vehicle_whitelist] call F_itemIsInClass) exitWith { _ret = true };
	if (([player, _vehicle] call is_owner) && ([typeOf _vehicle, GRLIB_recycleable_classnames] call F_itemIsInClass) && ([player, 4] call fetch_permission)) exitWith { _ret = true };
	private _owner_id = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
	private _manned = _vehicle getVariable ["GRLIB_vehicle_manned", false];
	if (getPlayerUID player == _owner_id && ((count crew _vehicle) == 0 || _manned)) exitWith { _ret = true };
};

_ret;