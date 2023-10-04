params [ "_vehicle" ];

diag_log format [ "Spawn militia crew at %1", time ];

private _grp = createGroup [GRLIB_side_enemy, true];
private _driver = _grp createUnit [(selectRandom militia_squad), zeropos, [], 5, "NONE"];
_driver moveInDriver _vehicle;
private _gunner = _grp createUnit [(selectRandom militia_squad), zeropos, [], 5, "NONE"];
_gunner moveInGunner _vehicle;
private _commander = _grp createUnit [(selectRandom militia_squad), zeropos, [], 5, "NONE"];
_commander moveInCommander _vehicle;
sleep 1;

private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_east, "crewman"];
{
	if ( vehicle _x == _x ) then {
		deleteVehicle _x;
	} else {
		[_path, _x] call F_getTemplateFile; 
		[_x] joinSilent _grp;
		[_x] call reammo_ai;
		_x addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
		_x addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
		_x setSkill 0.65;
		_x allowFleeing 0;
	};
} foreach [_driver, _gunner, _commander];

_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

_grp setCombatMode "WHITE";
_grp setBehaviour "AWARE";

diag_log format ["Done Spawning militia crew at %1", time];
