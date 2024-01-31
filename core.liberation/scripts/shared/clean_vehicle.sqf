params ["_vehicle", ["_delete", true], ["_force", false], ["_anim", false]];

if (isNull _vehicle) exitWith {};
if (_vehicle isKindOf "Steerable_Parachute_F") exitWith {};
if !(_vehicle isKindOf "AllVehicles") exitWith {};

private _towed = false;
private _owned = false;
if (!_force) then {
	_towed = !(isNull (_vehicle getVariable ["R3F_LOG_est_transporte_par", objNull]));
	_owned = !([_vehicle] call is_abandoned);
};
if (_towed || _owned) exitWith { false };

diag_log format [ "Cleanup vehicle %1 at %2", typeOf _vehicle, time ];

// unTow
[_vehicle] call untow_vehicle;

//Delete A3 Cargo
[_vehicle] call F_clearCargo;

// Delete R3F Cargo
{ deleteVehicle _x } forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
_vehicle setVariable ["R3F_LOG_objets_charges", [], true];

// Delete GRLIB Cargo
{
	if (_anim && typeOf _x in [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename, fuelbarrel_typename]) then {
		detach _x;
		sleep 0.2;
		_x setVelocity [([] call F_getRND), ([] call F_getRND), 10];
		sleep (0.5 + floor(random 3));
		_x setDamage 1;
	} else {
		deleteVehicle _x;
	};
} foreach (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);
_vehicle setVariable ["GRLIB_ammo_truck_load", [], true];

// Delete Vehicle and Crew
if (_delete) then {
	{ deleteVehicle _x } forEach (crew _vehicle);
	deleteVehicle _vehicle;
};

true;