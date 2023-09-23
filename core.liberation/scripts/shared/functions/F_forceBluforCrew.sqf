params [ "_veh"];

private _grp = GRLIB_side_friendly createVehicleCrew _veh;
sleep 0.1;
{
	_x addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
	_x setSkill 0.65;
	_x allowFleeing 0;	
} foreach (units _grp);

_veh allowCrewInImmobile [true, false];
_veh setUnloadInCombat [true, false];

_grp setCombatMode "WHITE";
_grp setBehaviour "AWARE";