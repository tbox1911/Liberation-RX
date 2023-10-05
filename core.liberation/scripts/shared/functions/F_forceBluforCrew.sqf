params [ "_vehicle" ];

private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, "crewman"];
private _grp = GRLIB_side_friendly createVehicleCrew _vehicle;
sleep 0.2;
{
	[_path, _x] call F_getTemplateFile; 
	[_x] call reammo_ai;
	_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
	_x addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_x setSkill 0.65;
	_x allowFleeing 0;
} foreach (units _grp);

_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

_grp setCombatMode "WHITE";
_grp setBehaviour "AWARE";
