params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

if (local _vehicle) then {
	[_vehicle, "unlock"] call F_vehicleLock;
} else {
	[_vehicle, "unlock", player] remoteExec ["vehicle_lock_remote_call", 2];
	waitUntil { sleep 1; local _vehicle };
};
_vehicle setVariable ["GRLIB_vehicle_owner", "", true];

private _texture = (configOf _vehicle >> "TextureSources") call Bis_fnc_getCfgSubClasses select 0;
if (!isNil "_texture") then {
    [_vehicle, _texture, ""] call RPT_fnc_TextureVehicle;
};
[_vehicle] call RPT_fnc_CompoVehicle;

hintSilent format [localize "STR_DO_ABANDON", [typeOf _vehicle] call F_getLRXName];
