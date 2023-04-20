params ["_vehicle"];

private _nearrecycl = [];
private _ret = false;
private _distveh = 15;
private _alive = alive player;
private _onfoot = vehicle player == player;
private _R3F_move = isNull R3F_LOG_joueur_deplace_objet;
private _far_lhd = player distance2D lhd >= 1000;
private _noflight = getPosATL player select 2 <= 5;
private	_nearestfob = [] call F_getNearestFob;
private	_fobdistance = 9999;
if ( count _nearestfob == 3 ) then {
	_fobdistance = round (player distance2D _nearestfob);
};
private _nearfob = _fobdistance <= GRLIB_fob_range;

if ( _alive && _onfoot && _R3F_move && _far_lhd && _nearfob && _noflight) then {
	_nearrecycl = [ [_vehicle], {
		( (count crew _x) == 0 || typeOf _x in uavs ) &&
		(!(_x getVariable ['R3F_LOG_disabled', false]) || typeOf _x in GRLIB_vehicle_whitelist ) &&
		(_x getVariable ["GRLIB_ammo_truck_load", 0] == 0) &&
		(count (_x getVariable ["R3F_LOG_objets_charges", []]) == 0) &&
		([player, _x] call is_owner || _x getVariable ["GRLIB_vehicle_owner", ""] == getPlayerUID player)
	}] call BIS_fnc_conditionalSelect;
};

if (count _nearrecycl > 0) then {_ret = true};

_ret;