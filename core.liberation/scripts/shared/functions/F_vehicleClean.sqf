params ["_vehicle", ["_delete", true], ["_force", false], ["_anim", false]];

if (isNull _vehicle) exitWith {};
if (_vehicle isKindOf "ParachuteBase") exitWith {};
if (_vehicle isKindOf "WeaponHolderSimulated") exitWith { deleteVehicle _vehicle };
if (typeOf _vehicle in all_buildings_classnames) exitWith { deleteVehicle _vehicle };

private _towed = false;
private _owned = false;
private _maned = false;
private _opfed = false;
private _fobed = false;
private _blued = false;

if (!_force) then {
	private _fob_pos = [_vehicle] call F_getNearestFob;
	_towed = !(isNull (_vehicle getVariable ["R3F_LOG_est_transporte_par", objNull]));
	_owned = !([_vehicle] call is_abandoned || [_vehicle] call is_public);
	_opfed = ({side group _x == GRLIB_side_enemy} count (crew _vehicle) > 0);
	_maned = ({side group _x == GRLIB_side_friendly} count (crew _vehicle) > 0);
	_fobed = (_vehicle distance2D _fob_pos < GRLIB_capture_size);
	_blued = ([_vehicle, GRLIB_capture_size, GRLIB_side_friendly] call F_getUnitsCount > 0);
};
if (!isNil "GRLIB_LRX_debug") then {
	diag_log format [
		"DBG: Cleanup vehicle check %1 at %2: towed=%3 owned=%4 maned=%5 opfed=%6 fobed=%7 blued=%8 t=%9",
		typeOf _vehicle, time, _towed, _owned, _maned, _opfed, _fobed, _blued, (_maned && !_opfed)
	];
};
if (_towed || _maned || (_owned && !_opfed) || _fobed || _blued) exitWith { false };

// diag_log format ["Cleanup vehicle %1 at %2", typeOf _vehicle, time];

// unTow
[_vehicle] call F_vehicleUntow;

//Delete A3 Cargo
[_vehicle] call F_clearCargo;

// Delete R3F Cargo
{ deleteVehicle _x } forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
_vehicle setVariable ["R3F_LOG_objets_charges", [], true];

// Delete GRLIB Cargo
{ deleteVehicle _x } foreach (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);
_vehicle setVariable ["GRLIB_ammo_truck_load", [], true];

// Delete Vehicle and Crew
if (_delete) then {
	{ deleteVehicle _x } forEach (crew _vehicle);
	deleteVehicle _vehicle;
} else {
	// Deep Water
	private _sea_deep = round ((getPosATL _vehicle select 2) - (getPosASL _vehicle select 2));
	if (_sea_deep >= 15) then {
		sleep 30;
		deleteVehicle _vehicle;
	};
};

true;