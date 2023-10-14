params ["_fob","_owner"];

private _fob_class = typeOf _fob;

// Add owner sign
private _offset = [0,0,0];
private _fob_dir = getDir _fob;

if (_fob_class isKindOf "Cargo_HQ_base_F" ) then {
	_offset = [5, -6, -0.2];
	_fob_dir = _fob_dir + 90;
	[_fob] call fob_init_officer;
};
if (_fob_class isKindOf "Land_BagBunker_Tower_F") then {
	_offset = [4, -4, -0.2];
	_fob_dir = _fob_dir - 90;
};
if (_fob_class == "Land_Destroyer_01_hull_04_F") then {
	_offset = [-2, 13, 9.5]; 
	_fob_dir = _fob_dir + 180; 
};
if (_fob_class == "Land_Carrier_01_island_02_F") then {
	_offset = [0, -8, -1.2];
	_fob_dir = _fob_dir - 90;
};

private _sign_pos = (getposASL _fob) vectorAdd ([_offset, -_fob_dir] call BIS_fnc_rotateVector2D);
private _sign = FOB_sign createVehicle zeropos;
_sign allowDamage false;
_sign setDir _fob_dir;
_sign setPosASL _sign_pos;
_sign enableSimulationGlobal false;
_sign setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];
_sign setVariable ["GRLIB_vehicle_owner", _owner, true];

if (count GRLIB_all_fobs == 0) then {
	_sign setVariable ["GRLIB_vehicle_owner", "public", true];
};

// if (GRLIB_enable_arsenal == 0) then {
// 	sleep 1;
// 	private _ammo_pos = (getposATL _sign) vectorAdd ([[10, 0, 0], -(getDir _sign) - 90] call BIS_fnc_rotateVector2D);
// 	{
// 		_ammo1 = createVehicle [_x, _ammo_pos, [], 1, "NONE"];
// 		_ammo1 allowDamage false;
// 		_ammo1 setVariable ["GRLIB_vehicle_owner", "public", true];
// 		_ammo1 setVariable ["R3F_LOG_disabled", true, true];
// 		if (_x == Box_Ammo_typename) then { _ammo1 addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2] };
// 		sleep 0.5;
// 	} forEach [Box_Weapon_typename, Box_Ammo_typename];
// };
