params [
	"_classname",
	"_owner",
	"_manned",
	"_veh_pos",
	"_veh_dir",
	"_veh_vup"
];

private _allow_damage = true;
private _vehicle = createVehicle [_classname, zeropos, [], 0, "NONE"];
sleep 0.1;
if (isNull _vehicle) exitWith {
	diag_log format ["--- LRX Error: Cannot create vehicle %1 at %2", _classname, _veh_pos];
	objNull;
};

_vehicle allowDamage false;
_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
_vehicle setPosATL _veh_pos;

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

// Personal Box
if (_classname == playerbox_typename) then {
	_vehicle setMaxLoad playerbox_cargospace;
	[_vehicle] call F_clearCargo;
	_allow_damage = false;
};

// Ammobox (add Charge)
if (_classname == Box_Ammo_typename) then {
	_vehicle addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2];
};

// Helipad lights
if (_classname isKindOf "Land_PortableHelipadLight_01_F") then {
	_allow_damage = false;
};

// WareHouse
if (_classname == Warehouse_typename) then {
	[_vehicle] call warehouse_init;
	_allow_damage = false;
};

// Storage
if (_classname == storage_medium_typename) then {
	_vehicle setVariable ["GRLIB_vehicle_owner", _owner, true];
	private _drop_zone_dir = (getdir _vehicle);
	private _drop_zone_pos = (getposATL _vehicle) vectorAdd ([[0, -5, 0], -_drop_zone_dir] call BIS_fnc_rotateVector2D);
	private _drop_zone = createVehicle ["VR_Area_01_square_2x2_yellow_F", ([] call F_getFreePos), [], 0, "NONE"];
	_drop_zone_pos set [2, 0.02];
	_drop_zone setDir _drop_zone_dir;
	_drop_zone setPosATL _drop_zone_pos;
	_drop_zone setVectorDirAndUp [[-cos _drop_zone_dir, sin _drop_zone_dir, 0] vectorCrossProduct surfaceNormal _drop_zone_pos, surfaceNormal _drop_zone_pos];
	_allow_damage = false;
};

// Medical Tent
if (_classname == medic_heal_typename && _classname isKindOf "Land_MedicalTent_01_base_F") then {
	private _med_floor_class = selectRandom ["Land_MedicalTent_01_floor_light_F", "Land_MedicalTent_01_floor_dark_F"];
	private _med_floor = createVehicle [_med_floor_class, _veh_pos, [], 0, "CAN_COLLIDE"];
	_med_floor setVectorDirAndUp [_veh_dir, _veh_vup];
	_med_floor setPosATL _veh_pos;
};

sleep 0.1;
if (_allow_damage) then { _vehicle allowDamage true };
_vehicle setDamage 0;

_vehicle;
