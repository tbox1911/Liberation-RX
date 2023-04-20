params [ "_veh"];

createVehicleCrew _veh;
sleep 0.1;
_grp = createGroup [GRLIB_side_friendly, true];
{
	_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	[_x] joinSilent _grp;
} foreach (crew _veh);

_grp setCombatMode "GREEN";
_grp setBehaviour "SAFE";