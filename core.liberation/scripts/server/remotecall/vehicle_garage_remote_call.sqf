if (!isServer && hasInterface) exitWith {};
params [ "_vehicle", "_cmd", "_owner" ];
if (isNil "_vehicle") exitWith {};

sleep random 0.3;

if (!isNil "GRLIB_garage_in_use") then { waitUntil {sleep 0.1; isNil "GRLIB_garage_in_use"} };
GRLIB_garage_in_use = true;
publicVariable "GRLIB_garage_in_use";

// Load
if (_cmd == 1) then {
	private _color = _vehicle getVariable ["GRLIB_vehicle_color", ""];
	private _compo = _vehicle getVariable ["GRLIB_vehicle_composant", []];
	private _ammo = [_vehicle] call F_getVehicleAmmoDef;
	private _lst_a3 = [_vehicle] call F_getCargo;
	private _lst_r3f = [];
	{ _lst_r3f pushback (typeOf _x)} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
	private _lst_grl = [];
	{_lst_grl pushback (typeOf _x)} forEach (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);
	GRLIB_garage append [[typeOf _vehicle, _owner, _color, _ammo, _compo, _lst_a3, _lst_r3f, _lst_grl]];
	{ deleteVehicle _x } forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
	{ deleteVehicle _x } foreach (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);
	deleteVehicle _vehicle;
};

// Unload
if (_cmd == 2) then {
	private _veh_lst = [];
	{
		if ( (_x select 1) == _owner ) then { _veh_lst pushback _foreachIndex };
	} foreach GRLIB_garage;
	GRLIB_garage deleteAt (_veh_lst select _vehicle);
};

publicVariable "GRLIB_garage";
sleep 1;
GRLIB_garage_in_use = nil;
publicVariable "GRLIB_garage_in_use";
