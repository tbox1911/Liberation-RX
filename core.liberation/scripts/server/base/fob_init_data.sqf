params ["_fob_class"];

private _sign_data = [[0,0,0], 0];
private _map_data = [[0,0,0], 0];

if (!isNil "FOB_typename_sign" && _fob_class == FOB_typename) exitWith {
    _sign_data = FOB_typename_sign;
    if (!isNil "FOB_typename_map") then {
        _map_data = FOB_typename_map;
    };
    [_sign_data, _map_data];
};

if (!isNil "FOB_outpost_sign" && _fob_class == FOB_outpost) exitWith {
    _sign_data = FOB_outpost_sign;
    [_sign_data, _map_data];
};

// Ground FOB
if (_fob_class isKindOf "Cargo_HQ_base_F") then {
    _sign_data = [[5, -6, -0.4], 90];
    _map_data = [[-2, 2, 0.6], 55];
};
if (_fob_class isKindOf "land_guardhouse_02_f") then {
    _sign_data = [[3, -5, -0.4], 90];
	_map_data = [[3.5, 3, 0.4], 0];
};
if (_fob_class isKindOf "Land_Bunker_01_HQ_F") then {
    _sign_data = [[4, -7, -0.4], 0];
	_map_data = [[-1.5, 2, 0], 0];
};
if (_fob_class isKindOf "Land_Bunker_01_small_F") then {
    _sign_data = [[2.5, -3, -0.4], 180];
	//_map_data = [];
};
if (_fob_class isKindOf "land_guardhouse_03_f") then {
    _sign_data = [[3, -5, -0.4], 90];
	//_map_data = [];
};
if (_fob_class isKindOf "Land_BagBunker_Tower_F") then {
    _sign_data = [[4, -4, -0.4], 270];
	//_map_data = [];
};

// Naval FOB
if (_fob_class isKindOf "Land_Destroyer_01_base_F") then {
    _sign_data = [[-2, -32, 8.5], 180];
	//_map_data = [];
};
if (_fob_class isKindOf "Land_Carrier_01_base_F") then {
    _sign_data = [[110, 20, 23.5], 270];
	//_map_data = [];
};

[_sign_data, _map_data];

// Usage in console or template (classname_west.sqf)
//
// how to find values (by trial and error)
//
// find suitable location, admin create FOB box, execute code below in console,
// now, build the FOB, check item placement, if needed adjust offset and dir in console,
// repack the FOB as box, loop
//
// when it's ok copy the values (as is) to (classname_west.sqf)

// SoG
// FOB_typename = "Land_vn_bunker_big_02";
// FOB_typename_sign = [[-3, -5, -0.4], 180];   // "Land_vn_bunker_big_02"
// FOB_typename_map = [[0, 1.5, 2], 180];       // "Land_vn_bunker_big_02"
// FOB_outpost_sign = [[-1.5, -6, -0.4], 90];   // "Land_vn_b_trench_bunker_01_02"

// SPE
// FOB_typename = "Land_SPE_H679";
// FOB_typename_sign = [[4, -6, -0.4], 0];      // "Land_SPE_H679"
// FOB_typename_map = [[0,2,0], 0];             // "Land_SPE_H679"
// FOB_outpost_sign = [[3.5, -2, -0.4], 180];   // "Land_SPE_H612"

// A3 Outpost
// FOB_typename = "Land_Bunker_01_small_F";  
// FOB_typename_sign = [[2.5, -3, -0.4], 180];  
// FOB_typename_map = nil;
