if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_attack_destination"];

private _location_name = [_attack_destination] call F_getLocationName;
["lib_incoming", [_location_name]] call BIS_fnc_showNotification;

private _marker = createMarkerLocal [format ["opfor_incoming_marker_%1", _location_name], _attack_destination];
_marker setMarkerTypeLocal "selector_selectedMission";
_marker setMarkerColorLocal GRLIB_color_enemy_bright;

sleep 180;
deleteMarkerLocal _marker;
