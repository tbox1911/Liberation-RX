params ["_object", "_vehicle"];

if (isNil "_object") exitWith {};
private _classname = typeOf _object;

// MP Killed EH
_object addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

// Vehicle owner
private _vehicle_owner = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
if (isPlayer _vehicle) then { _vehicle_owner = getPlayerUID _vehicle };
if !(_vehicle_owner in ["", "public", "server"]) then {
	if !([_object, GRLIB_vehicle_blacklist] call F_itemIsInClass) then {
		_object setVariable ["GRLIB_vehicle_owner", _vehicle_owner, true];
	};
};

// Box clean inventory
if !(_classname in (GRLIB_Ammobox_keep + GRLIB_disabled_arsenal)) then {
	[_object] call F_clearCargo;
};

// Arsenalbox
if (_classname == Arsenal_typename) exitWith {
	_object setMaxLoad 0;
};

// Personal Box
if (_classname == playerbox_typename) exitWith {
	_object setMaxLoad playerbox_cargospace;
};

// Mobile Respawn
if (_classname in respawn_vehicles) exitWith {
	if (isServer) then {
		[_object, "add"] call mobile_respawn_remote_call;
	} else {
		[_object, "add"] remoteExec ["mobile_respawn_remote_call", 2];
	};
};

// UAVs
if (_classname in uavs_vehicles) exitWith {
	_object setVariable ["GRLIB_vehicle_manned", true, true];
};

// UAVs box
if (_classname == box_uavs_typename) exitWith {
	_object setMaxLoad 0;
	private _loaded_uavs = [];
	for "_n" from 1 to box_uavs_max do { _loaded_uavs pushBack uavs_light };
	[_object, _loaded_uavs] call load_object_direct;
};

// ReAmmo sources
// if (_classname in vehicle_rearm_sources) exitWith {
// 	_object setAmmoCargo 0;
// };

// Storage
if (typeOf _vehicle == storage_medium_typename) exitWith {
	_object setVariable ["GRLIB_vehicle_owner", "", true];
};

// AI Static Weapon
if (_classname in static_vehicles_AI) exitWith {
	[_object] call F_forceCrew;
	_object setVariable ["GRLIB_vehicle_manned", true, true];
	_object setVehicleLock "LOCKED";
};
