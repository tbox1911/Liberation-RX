params [ "_vehicle" ];

diag_log format [ "Spawn militia crew at %1", time ];

private _grp = createGroup [GRLIB_side_enemy, true];
private _driver = _grp createUnit [(selectRandom militia_squad), getpos _vehicle, [], 5, "NONE"];
[_driver] joinSilent _grp;
_driver moveInDriver _vehicle;
private _gunner = _grp createUnit [(selectRandom militia_squad), getpos _vehicle, [], 5, "NONE"];
[_gunner] joinSilent _grp;
_gunner moveInGunner _vehicle;
private _commander = _grp createUnit [(selectRandom militia_squad), getpos _vehicle, [], 5, "NONE"];
[_commander] joinSilent _grp;
_commander moveInCommander _vehicle;
sleep 1;

{
	if ( vehicle _x == _x ) then {
		deleteVehicle _x;
	} else {
		[_x] call loadout_crewman;
		[_x] call reammo_ai;
		_x addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
		_x addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
		_x setSkill 0.65;
		_x allowFleeing 0;
	};
} foreach (units _grp);

diag_log format [ "Done Spawning militia crew at %1", time ];
