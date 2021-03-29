params ["_vehicle"];

private _nearrecycl = [];
private _ret = false;
private _distveh = 15;
private _alive = alive player;
private _onfoot = vehicle player == player;
private _R3F_move = isNull R3F_LOG_joueur_deplace_objet;
private _far_lhd = player distance2D lhd >= 1000;
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

	if (typeOf _vehicle in GRLIB_vehicle_whitelist + opfor_recyclable) then {
		_ret = true;
	};

	if (typeOf _vehicle in buildings && [player] call F_getScore >= GRLIB_perm_tank) then {
		_ret = true;
	};

	if (([player, _vehicle] call is_owner) && ((count crew _vehicle) == 0 || typeOf _vehicle in uavs)) then {
		_ret = true;
	};

};

_ret;