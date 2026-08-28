params [
	"_classname",
	"_owner",
	"_veh_pos",
	"_veh_dir",
	"_veh_vup"
];

private _public = false;
private _vehicle = createVehicle [_classname, _veh_pos, [], 0, "CAN_COLLIDE"];
_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
_vehicle setPosATL _veh_pos;

// Magic ClutterCutter
if (_classname == land_cutter_typename) then {
    [_veh_pos] remoteExec ["build_cutter_remote_call", 2];
    _vehicle allowdamage false;
};

// CamoNet
if ([_classname, GRLIB_camo_net] call F_itemIsInClass) then {
    _vehicle addEventHandler ["HandleDamage", { _this call damage_manager_static }];
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
    [_vehicle, 0, player] remoteExec ["warehouse_remote_call", 2];
    _allow_damage = false;
    _public = true;
};

// Storage
if (_classname in [storage_medium_typename, storage_large_typename]) then {
    _vehicle setVariable ["GRLIB_vehicle_owner", _owner, true];
    private _offest = [0, -5, 0];
    if (_classname == storage_large_typename) then { _offest = [0, -7, 0] };
    private _drop_zone_dir = (getdir _vehicle);
    private _drop_zone_pos = (getposATL _vehicle) vectorAdd ([_offest, -_drop_zone_dir] call BIS_fnc_rotateVector2D);
    private _drop_zone = createVehicle ["VR_Area_01_square_2x2_yellow_F", ([] call F_getFreePos), [], 0, "NONE"];
    _drop_zone_pos set [2, 0.02];
    _drop_zone setDir _drop_zone_dir;
    _drop_zone setPosATL _drop_zone_pos;
    _drop_zone setVectorDirAndUp [[-cos _drop_zone_dir, sin _drop_zone_dir, 0] vectorCrossProduct surfaceNormal _drop_zone_pos, surfaceNormal _drop_zone_pos];
    _allow_damage = false;
    _public = true;
};

// Medical Tent
if (_classname == medic_heal_typename && _classname isKindOf "Land_MedicalTent_01_base_F") then {
    private _med_floor_class = selectRandom ["Land_MedicalTent_01_floor_light_F", "Land_MedicalTent_01_floor_dark_F"];
    private _med_floor = createVehicle [_med_floor_class, _veh_pos, [], 0, "CAN_COLLIDE"];
    _med_floor setVectorDirAndUp [_veh_dir, _veh_vup];
    _med_floor setPosATL _veh_pos;
    _public = true;
};

// MP Killed
if ([_classname, GRLIB_quick_delete] call F_itemIsInClass) then {
    _vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
};

if (_public) then {
	GRLIB_redraw_marker_fob = true;
	publicVariableServer "GRLIB_redraw_marker_fob";
};

_vehicle;
