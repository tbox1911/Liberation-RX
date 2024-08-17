params ["_vehicle"];

if (isNil "_vehicle") exitWith {};

_vehicle setVariable ["GRLIB_vehicle_color", "", true];
_vehicle setVariable ["GRLIB_vehicle_color_name", "", true];
_vehicle setVariable ["GRLIB_vehicle_composant", [], true];

[_vehicle, ""] spawn RPT_fnc_TextureVehicle;
[_vehicle, true, [true]] spawn bis_fnc_initVehicle;
