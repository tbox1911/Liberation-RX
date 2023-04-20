params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, "UNLOCKED"] remoteExec ["setVehicleLock", 0];
_vehicle setVariable ["GRLIB_vehicle_owner", "", true];
_vehicle setVariable ["R3F_LOG_disabled", false, true];

_veh_texture_list = colorList select 0;
_name = _veh_texture_list select 0;
_texture = _veh_texture_list select 1;
[_vehicle, _texture, _name, []] call RPT_fnc_TextureVehicle;

_text = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
hintSilent format ["%1 is now public !", _text];