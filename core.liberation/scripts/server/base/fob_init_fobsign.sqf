// Find FOB Sign position
// ------------------
// // "Land_SPE_H612" createvehicle (getpos player); // "Land_Bunker_01_HQ_F", "Land_GuardHouse_02_F"
//
// _fob = cursorobject;
// _fob_dir = getDir _fob;
// //--- edit ---
// _offset = [0, 0, -0.4];
// _fob_dir = _fob_dir + 0;
// //-------------------------------	
// _sign_pos = (getposASL _fob) vectorAdd ([_offset, -_fob_dir] call BIS_fnc_rotateVector2D);
// _sign = createVehicle [FOB_sign, ([] call F_getFreePos), [], 0, "NONE"];
// _sign allowDamage false;
// _sign setDir _fob_dir;
// _sign setPosASL _sign_pos;
// _sign enableSimulationGlobal false;
// _sign setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];

// Default A3
if (_fob_class isKindOf "Cargo_HQ_base_F") then {
	_offset = [5, -6, -0.4];
	_fob_dir = _fob_dir + 90;
};
if (_fob_class isKindOf "Land_BagBunker_Tower_F") then {
	_offset = [4, -4, -0.4];
	_fob_dir = _fob_dir - 90;
};
if (_fob_class isKindOf "Land_GuardHouse_02_F") then {
	_offset = [3, -5, -0.4];
	_fob_dir = _fob_dir + 90;
};
if (_fob_class == "Land_Bunker_01_HQ_F") then {
	_offset = [3, -7, -0.4];
	_fob_dir = _fob_dir + 0;
};
if (_fob_class == "Land_Bunker_01_small_F") then {
	_offset = [2.5, -3, -0.4]; 
	_fob_dir = _fob_dir + 180; 
};

// SoG
if (_fob_class == "Land_vn_bunker_big_02") then {
	_offset = [-3, -5, -0.4];
	_fob_dir = _fob_dir - 180;
};
if (_fob_class == "Land_vn_b_trench_bunker_01_02") then {
	_offset = [-1.5, -6, -0.4];
	_fob_dir = _fob_dir + 90;
};

// SPE
if (_fob_class == "Land_SPE_H679") then {
	_offset = [4, -6, -0.4];
	_fob_dir = _fob_dir + 0;
};
if (_fob_class == "Land_SPE_H612") then {
	_offset = [3.5, -2, -0.4]; 
	_fob_dir = _fob_dir + 180; 
};

// Naval FOB
if (_fob_class == "Land_Destroyer_01_base_F") then {
	_offset = [-2, -32, 8.5];
	_fob_dir = _fob_dir + 180;
};
if (_fob_class == "Land_Carrier_01_base_F") then {
	_offset = [110, 20, 23.5];
	_fob_dir = _fob_dir - 90;
};
