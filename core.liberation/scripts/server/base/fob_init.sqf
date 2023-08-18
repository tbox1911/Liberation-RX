params ["_fob", "_owner"];

_fob addEventHandler ["HandleDamage", {0}];
_fob allowDamage false;

private _fob_class = typeOf _fob;

// Add owner sign
private _fobdir = getDir _fob;
private _offset = [[-6, -5, -0.2], -_fobdir];
if (_fob_class == FOB_outpost ) then { _offset = [[5, -3, -0.2], -_fobdir] };
private _sign_pos = (getposATL _fob) vectorAdd (_offset call BIS_fnc_rotateVector2D);
private _sign = createVehicle [FOB_sign, _sign_pos, [], 0, "CAN_COLLIDE"];

_sign allowDamage false;
if (_fob_class == FOB_outpost ) then {
	_sign setDir (_fobdir - 90);
} else {
	_sign setDir (_fobdir + 90);
	[_fob] call fob_init_officer;
};

_sign setObjectTextureGlobal [0, getMissionPath "res\splash_libe2.paa"];
_sign setVariable ["GRLIB_vehicle_owner", _owner, true];
if (count GRLIB_all_fobs == 0) then {
	_sign setVariable ["GRLIB_vehicle_owner", "public", true];
};

if (GRLIB_enable_arsenal == 0) then {
	sleep 1;
	private _ammo_pos = (getposATL _sign) vectorAdd ([[10, 0, 0], -(getDir _sign) - 90] call BIS_fnc_rotateVector2D);
	{
		_ammo1 = createVehicle [_x, _ammo_pos, [], 1, "NONE"];
		_ammo1 allowDamage false;
		_ammo1 setVariable ["GRLIB_vehicle_owner", "public", true];
		_ammo1 setVariable ["R3F_LOG_disabled", true, true];
		if (_x == Arsenal_typename) then { _ammo1 addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2] };
		sleep 0.5;
	} forEach [Box_Weapon_typename, Box_Ammo_typename];
};
