params ["_vehicle"];
if (isNil "_vehicle") exitWith { 0 };

private _totalCurAmmo = 0;
private _defTotalAmmo = 0;
private _getVehicleAmmoDef = 1;
private _ignore_ammotype = ["Laserbatteries", "8Rnd_82mm_Mo_Flare_white", "8Rnd_82mm_Mo_Smoke_white"];

{
	if (! ((_x select 0) in _ignore_ammotype)) then {
		_totalCurAmmo = _totalCurAmmo + (_x select 1);
		_defTotalAmmo = _defTotalAmmo + (getNumber (configFile >> "CfgMagazines" >> (_x select 0) >> "count"));
	};
} forEach (magazinesAmmo [_vehicle, true]);

if (typeOf _vehicle ==  "B_G_Offroad_01_armed_F") then {_defTotalAmmo = 400};   // cheat as it's not defined in CfgVehicles
if (typeOf _vehicle ==  "O_G_Offroad_01_armed_F") then {_defTotalAmmo = 400}; 

if (_defTotalAmmo != 0 ) then {
	_getVehicleAmmoDef = (_totalCurAmmo/_defTotalAmmo);
};
_getVehicleAmmoDef;