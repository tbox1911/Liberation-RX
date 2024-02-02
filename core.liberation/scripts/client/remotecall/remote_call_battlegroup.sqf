if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_battlegroup_position"];

"opfor_bg_marker" setMarkerPosLocal _battlegroup_position;
private _location_name = [_battlegroup_position] call F_getLocationName;
["lib_battlegroup", [_location_name]] call BIS_fnc_showNotification;

sleep 600;

"opfor_bg_marker" setMarkerPosLocal markers_reset;