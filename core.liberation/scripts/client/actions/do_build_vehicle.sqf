params [
	"_classname",
	"_owner",
	"_manned",
	"_veh_pos",
	"_veh_dir",
	"_veh_vup"
];

private _allow_damage = true;
private _pos_degagee = [];
if (_classname isKindOf "Air") then {
	_pos_degagee = [] call R3F_LOG_FNCT_3D_tirer_position_degagee_ciel;
} else {
	private _bbox = [_classname] call R3F_LOG_FNCT_3D_get_bounding_box_depuis_classname;
	private _bbox_dim = (vectorMagnitude (_bbox select 0)) max (vectorMagnitude (_bbox select 1));
	_pos_degagee = [_bbox_dim, _veh_pos, 200, 50] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
};

if (count _pos_degagee == 0) exitWith {
	diag_log format ["--- LRX Error: Cannot create vehicle %1 at %2", _classname, _veh_pos];
	objNull;
};

private _vehicle = createVehicle [_classname, _pos_degagee, [], 100, "CAN_COLLIDE"];
if (isNull _vehicle) exitWith {
	diag_log format ["--- LRX Error: Cannot create vehicle %1 at %2", _classname, _veh_pos];
	objNull;
};

_vehicle allowDamage false;
_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
_vehicle setPosATL _veh_pos;

// Notify player
player reveal [_vehicle, 4];

// ACE Support
if (GRLIB_ACE_enabled) then {
	[_vehicle] call F_aceInitVehicle;
};

// LRX Init
[_vehicle, player] call init_object_direct;

// Crewed vehicle
if (_manned) then {
	[_vehicle] call F_forceCrew;
	_vehicle setVariable ["GRLIB_vehicle_manned", true, true];
};

// Vehicles
if (_classname isKindOf "LandVehicle" || _classname isKindOf "Air" || _classname isKindOf "Ship_F") then {
	// Cutomize Vehicle
	[_vehicle] call F_fixModVehicle;

	// Default Paint
	if (_classname in ["I_E_Truck_02_MRL_F"]) then {
		[_vehicle, ["EAF",1], true] spawn BIS_fnc_initVehicle;
	};
};

sleep 1;

if (_allow_damage) then { _vehicle allowDamage true };
_vehicle setDamage 0;

_vehicle;
