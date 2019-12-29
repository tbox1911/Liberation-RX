params ["_vehicle"];

private _nearrecycl = [];
private _ret = false;
private _distveh = 15;
private _alive = alive player;
private _onfoot = vehicle player == player;
private _R3F_move = isNull R3F_LOG_joueur_deplace_objet;
private	_nearfob = [] call F_getNearestFob;
private	_fobdistance = 9999;
if ( count _nearfob == 3 ) then {
	_fobdistance = round (player distance2D _nearfob);
};

if ( _alive && _onfoot && _R3F_move &&
	(player distance2D lhd) >= 1000 &&
	(_fobdistance <= GRLIB_fob_range) &&
	getPosATL player select 2 <= 5 &&
	!(_vehicle getVariable ['R3F_LOG_disabled', true]) &&
	(_vehicle getVariable ["GRLIB_ammo_truck_load", 0] == 0) &&
	(count (_vehicle getVariable ["R3F_LOG_objets_charges", []]) == 0)
	) then {

		if ([player, 4] call fetch_permission) then {
				_nearrecycl = [ [_vehicle], {
					( (count crew _x) == 0 || typeOf _x in uavs ) &&
					[player, _x] call is_owner
				}] call BIS_fnc_conditionalSelect;
		} else {
				_nearrecycl = [ [_vehicle], {
					( _x getVariable ["GRLIB_vehicle_owner", ""] == getPlayerUID player || typeOf _x in GRLIB_vehicle_whitelist )
				}] call BIS_fnc_conditionalSelect;
		};
};

if (count _nearrecycl > 0) then {_ret = true};

_ret;