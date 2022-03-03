params [ "_vehicle" ];
private [ "_grp", "_vehcrew" ];

diag_log format [ "Spawning militia crew at %1", time ];

_grp = createGroup [GRLIB_side_enemy, true];
_vehcrew = [];
while { count units _grp < 3 } do {
	( selectRandom militia_squad ) createUnit [ getpos _vehicle, _grp,'this addMPEventHandler [''MPKilled'', {_this spawn kill_manager}]', 0.5, 'private'];
};
((units _grp) select 0) moveInDriver _vehicle;
((units _grp) select 1) moveInGunner _vehicle;
((units _grp) select 2) moveInCommander _vehicle;
sleep 1;
{
	if ( vehicle _x == _x ) then {
		deleteVehicle _x;
	} else {
		[ _x ] call loadout_crewman;
		_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_x addEventHandler ["HandleDamage", {_this call damage_manager_EH}];
		_x setSkill 0.65;
		_x setSkill ["courage", 1];
		_x allowFleeing 0;
	};
} foreach (units _grp);

(crew _vehicle) joinSilent _grp;
diag_log format [ "Done Spawning militia crew at %1", time ];
