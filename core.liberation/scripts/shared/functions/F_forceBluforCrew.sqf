params [ "_veh"];

createVehicleCrew _veh;
sleep 0.1;
_grp = createGroup [GRLIB_side_friendly, true];
(crew _veh) joinSilent _grp;
{
	_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	_x addEventHandler ["HandleDamage", {_this call damage_manager_EH}];
} foreach (crew _veh);

_grp setCombatMode "GREEN";
_grp setBehaviour "SAFE";