params ["_classname"];

// keep old
if (repeatbuild) exitWith {};

// Customize by classname

private _rotation = 0;
private _altitude = 0.1;
private _radius = ((round((sizeOf _classname)/1.5) max 3) min 15);
private _dist = ((round(_radius / 1.5) + 1.5) max 2);

switch _classname do {
    // check direct classname
    case FOB_carrier: {
        _rotation = 90;
        _dist = 35;
    };
    case playerbox_typename: {
        _rotation = 90;
    };
    case medic_heal_typename: {
        _radius = 15;
        _distance = 10;
    };
    case "Land_Cargo_Patrol_V1_F": {
        _rotation = 270;
    };
    case "Land_Cargo_Tower_V1_F": {
        _rotation = 270;
    };
    case "Land_BagBunker_Tower_F": {
        _rotation = 90;
        _altitude = -0.2;
    };
    case "Land_Hangar_F": {
        _radius = 30;
        _dist = 20;
    };
    case "Land_Airport_01_hangar_F": {
        _radius = 35;
        _dist = 20;
    };
    case "Land_TentHangar_V1_F": {
        _radius = 30;
        _dist = 20;
    };
    case "Land_vn_bunker_big_02": {
        _rotation = 270;
    };
    case "Land_vn_b_trench_bunker_01_02": {
        _rotation = 270;
        _altitude = -0.2;
    };
    case "Land_BagBunker_Small_F": {
        _rotation = 180;
    };
    case "Land_Shed_Small_F": {
        _rotation = 90;
        _radius = 15;
        _dist = 8;
    };
    case "Land_i_Shed_Ind_F": {
        _radius = 15;
        _dist = 8;
    };
    case "Land_TrenchFrame_01_F";
    case "Land_Trench_01_grass_F";
    case "Land_Trench_01_forest_F": {
        _rotation = 180;
        _altitude = 2;
    };
    case "Land_ShellCrater_02_small_F": {
        _altitude = 0.5;
    };
    case "Land_ShellCrater_02_large_F";
    case "Land_ShellCrater_02_extralarge_F": {
        _altitude = 1;
    };

    // Check kinOf objects
    default {
        if (_classname isKindOf "Cargo_HQ_base_F") then {
            _rotation = 270;
            _radius = 20;
            _distance = 13.5;
        };
        if (_classname isKindOf "Slingload_base_F") then {
            _rotation = 90;
            _radius = 8;
            _dist = 6;
        };
        if (_classname isKindOf "LandVehicle") then {
            _rotation = 90;
        };
    };
};

build_distance = _dist;
build_radius = _radius;
build_rotation = _rotation;
build_altitude = _altitude;
