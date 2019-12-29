params [ "_unit" ];

private _group = group _unit;
[_group, 1] setWPPos (getpos _unit);
sleep 1;
 while {(count (waypoints _group)) > 0} do
 {
  deleteWaypoint ((waypoints _group) select 0);
 };