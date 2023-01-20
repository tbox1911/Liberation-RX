if (!isServer && hasInterface) exitWith {};
params [ "_veh", "_cmd", "_owner" ];

if (isNil "_veh") exitWith {};
if (!isNil "GRLIB_garage_in_use") then { waitUntil {sleep 0.1; isNil "GRLIB_garage_in_use"} };
GRLIB_garage_in_use = true;
publicVariable "GRLIB_garage_in_use";

// Load
if (_cmd == 1) then {
	private _color = _veh getVariable ["GRLIB_vehicle_color", ""];
	private _compo = _veh getVariable ["GRLIB_vehicle_composant", []];
	private _ammo = [_veh] call F_getVehicleAmmoDef;
	private _lst_a3 = [_veh] call F_getCargo;
	private _lst_r3f = [];
	{ _lst_r3f pushback (typeOf _x)} forEach (_veh getVariable ["R3F_LOG_objets_charges", []]);
	GRLIB_garage append [[typeOf _veh, _color, _ammo, _owner, _lst_a3, _lst_r3f, _compo]];
	[_veh] call clean_vehicle;
	deleteVehicle _veh;
};

// Unload
if (_cmd == 2) then {
	private _veh_lst = [];
	{
		if ( (_x select 3) == _owner ) then { _veh_lst pushback _foreachIndex };
	} foreach GRLIB_garage;
	GRLIB_garage deleteAt (_veh_lst select _veh);
};

publicVariable "GRLIB_garage";
sleep 1;
GRLIB_garage_in_use = nil;
publicVariable "GRLIB_garage_in_use";
