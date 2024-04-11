params ["_vehicle"];

if (!GRLIB_ACE_enabled) exitWith {};
if (isNull _vehicle) exitWith {};

private _vehicle_class = typeOf _vehicle;

// Check Blacklist
if (_vehicle_class in GRLIB_ACE_blacklist) exitWith {};

[_vehicle, false] call ace_dragging_fnc_setDraggable;
[_vehicle, false] call ace_dragging_fnc_setCarryable;
[_vehicle, -1] call ace_cargo_fnc_setSize;
