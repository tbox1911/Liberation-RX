if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_attack_destination"];

private _marker_name = format ["opfor_incoming_marker_%1", (round time)];
private _marker = createMarkerLocal [_marker_name, _attack_destination];
_marker setMarkerTypeLocal "selector_selectedMission";
_marker setMarkerColorLocal GRLIB_color_enemy_bright;

private _location_name = [_attack_destination] call F_getLocationName;
["lib_incoming", [_location_name]] call BIS_fnc_showNotification;

sleep 180;
deleteMarkerLocal _marker;
