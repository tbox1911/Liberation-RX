params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

[_vehicle, "UNLOCKED"] remoteExec ["setVehicleLock", 0];
_vehicle setVariable ["GRLIB_vehicle_owner", "", true];
_vehicle setVariable ["R3F_LOG_disabled", false, true];

_texture = (configfile >> "CfgVehicles" >> typeOf _vehicle >> "TextureSources") call Bis_fnc_getCfgSubClasses select 0;
if (!isNil "_texture") then {
    [_vehicle, [_texture], "",[]] call RPT_fnc_TextureVehicle;
};

_text = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
hintSilent format [localize "STR_DO_ABANDON", _text];
