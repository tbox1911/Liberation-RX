params ["_classname"];

// Customize by classname 

build_radius = ((round((sizeOf _classname)/2) max 3) min 15);
private _dist = ((round(build_radius / 2) + 1.5) min 2);

switch _classname do {
    case FOB_carrier: {
        build_rotation = 90;
        _dist = 35;
    };
    case mobile_respawn: {
        build_radius = 1.5;
        _dist = 1;
    };
    case playerbox_typename: {
        build_rotation = 90;
        build_radius = 1.5;
        _dist = 1;
    };
    case "Land_Cargo_Patrol_V1_F": {
        build_rotation = 270;
        build_radius = 5;
        _dist = 5;
    };
    case "Land_Cargo_Tower_V1_F": {
        build_rotation = 270;
        build_radius = 9;
        _dist = 5;
    };
    case "Land_BagBunker_Tower_F": {
        build_rotation = 90;
        build_altitude = -0.2;
    };
    case "Land_Hangar_F": {
        build_radius = 30;
        _dist = 10;
    };
    case "Land_Airport_01_hangar_F": {
        build_radius = 25;
        _dist = 10;
    };
    case "Land_TentHangar_V1_F": {
        build_radius = 15;
        _dist = 10;
    };
    case "Land_vn_bunker_big_02": {
        build_rotation = 270;
    };
    case "Land_vn_b_trench_bunker_01_02": {
        build_rotation = 270;
        build_altitude = -0.2;
    };
    case "Land_BagBunker_Small_F": {
        build_rotation = 180;
    };
    case "Land_Shed_Small_F": {
        build_rotation = 90;
        build_radius = 15;
        _dist = 4;
    };
    case "Land_i_Shed_Ind_F": {
        build_radius = 15;
        _dist = 5;
    };
    case "Land_TrenchFrame_01_F";
    case "Land_Trench_01_grass_F";
    case "Land_Trench_01_forest_F": {
        build_rotation = 180;
        build_altitude = 2;
    };
    case "Land_ShellCrater_02_small_F": {
        build_altitude = 0.5;
    };
    case "Land_ShellCrater_02_large_F";
    case "Land_ShellCrater_02_extralarge_F": {
        build_altitude = 1;
    };
    default {
        if (_classname isKindOf "Cargo_HQ_base_F") then {
            build_rotation = 270;
            build_radius = 8;
            _dist = 4;
        };
        if (_classname isKindOf "Slingload_base_F") then {
            build_rotation = 90;
            build_radius = 5;
            _dist = 3;
        };
        if (_classname isKindOf "Truck_01_base_F") then {
            build_rotation = 90;
            build_radius = 8;
            _dist = 4;
        };
        if (_classname isKindOf "Truck_02_base_F") then {
            build_rotation = 90;
            build_radius = 6;
            _dist = 4;
        };
        if (_classname isKindOf "Van_01_base_F") then {
            build_rotation = 90;
        };
        if (_classname in list_static_weapons) then {
            build_radius = 3;
            _dist = 1;
        };
    };
};
if (!repeatbuild) then { build_distance = 1 max _dist };