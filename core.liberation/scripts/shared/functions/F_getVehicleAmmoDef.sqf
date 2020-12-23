params ["_vehicle"];
if (isNil "_vehicle") exitWith { 0 };

_totalCurAmmo = 0;
_getVehicleAmmoDef = 0;
_VehAmmoArray = [];
_defAmmoCount = 0;

// default ammo per magazine
_VehAmmoArray =  getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "Turrets" >> "MainTurret" >> "magazines");
_defAmmoCount = getNumber (configFile >> "CfgMagazines" >> ((magazines _vehicle) select 0) >> "count");

_defTotalAmmo = 0;
{
	_defTotalAmmo = _defTotalAmmo + (getNumber (configFile >> "CfgMagazines" >> _x >> "count"));
} forEach _VehAmmoArray;

if (typeOf _vehicle ==  "B_G_Offroad_01_armed_F") then {_defTotalAmmo = 400};   // cheat as it's not defined in CfgVehicles // need to update this for O_G_Offroad_01_armed_F

_totalCurAmmo = 0;
{
	_totalCurAmmo = _totalCurAmmo + (_x select 1);
} forEach (magazinesAmmo _vehicle);

if (_defTotalAmmo != 0 ) then {
	_getVehicleAmmoDef = (_totalCurAmmo/_defTotalAmmo);
};
_getVehicleAmmoDef;