params [ "_veh" ];
private [ "_grp" ];

createVehicleCrew _veh;
sleep 1;

if ( count crew _veh == 0 ) then {
	 diag_log format ["ERROR: Cannot create crew for vehicle: %1", typeOf _veh];

    _grp = createGroup [GRLIB_side_friendly, true];
	while { count units _grp < 3 } do {
		crewman_classname createUnit [ getPos _veh, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]; this addEventHandler ["HandleDamage", {_this call damage_manager_EH}]'];
		sleep 0.1;
	};
	((units _grp) select 0) moveInDriver _veh;
	((units _grp) select 1) moveInGunner _veh;
	((units _grp) select 2) moveInCommander _veh;
	sleep 0.1;
	{ if ( vehicle _x == _x ) then { deleteVehicle _x }; } foreach (units _grp);
	sleep 1;
 };

if ( count crew _veh > 0 ) then {
	if ( side (group ((crew _veh) select 0)) != GRLIB_side_friendly ) then {
		_grp = createGroup [GRLIB_side_friendly, true];
		(crew _veh) joinSilent _grp;
	};

	(group ((crew _veh) select 0)) setCombatMode "GREEN";
	(group ((crew _veh) select 0)) setBehaviour "SAFE";
};
