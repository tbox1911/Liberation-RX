params ["_grp"];
if (isNull _grp) exitWith {};

for "_i" from count (waypoints _grp) to 0 step -1 do {
	deleteWaypoint ((waypoints _grp) select _i);
};

sleep 0.5;