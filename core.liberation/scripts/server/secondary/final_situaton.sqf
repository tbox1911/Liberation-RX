params [ ["_mission_cost", 0], "_caller" ];

private _spawnpos = [];
private _spawnlist = [];
{
	_spawnpos = [(markerpos _x), 15, 0] call F_findSafePlace;
	if (count _spawnpos > 0) then {_spawnlist pushBack [_spawnpos select 0, _spawnpos select 1, 0]};
} foreach sectors_allSectors;
if (count _spawnlist == 0) exitWith {[gamelogic, "Could not find enough free space for Armageddon mission"] remoteExec ["globalChat", 0]};

diag_log format ["--- LRX: %1 start static mission: Armageddon at %2", _caller, time];
resources_intel = resources_intel - _mission_cost;

GRLIB_secondary_in_progress = 3;
publicVariable "GRLIB_secondary_in_progress";
GRLIB_global_stop = 1;
publicVariable "GRLIB_global_stop";

{ deleteVehicle _x } foreach (units GRLIB_side_enemy);
{ deleteVehicle (agent _x) } foreach agents;

// weather cloudy
[] spawn {
	while { overcast <= 0.85 } do {
		_chosen_weather = (overcast + 0.10);
		0 setOvercast _chosen_weather;
		forceWeatherChange;
		sleep 20;
	};
};

skipTime ((10 - dayTime + 24) % 24);
setTimeMultiplier 0;

sector_timer = round (serverTime + (35 * 60));
publicVariable "sector_timer";
[] remoteExec ["remote_call_final_fight", 0];

// create marker
_spawnpos = selectRandom _spawnlist;
private _marker = createMarkerLocal ["final_fight", _spawnpos];
_marker setMarkerTypeLocal "mil_destroy";
_marker setMarkerSizeLocal [1.25, 1.25];
_marker setMarkerColorLocal GRLIB_color_enemy_bright;
_marker setMarkerText "           FINAL FIGHT";
[_marker, 1] remoteExec ["remote_call_sector", 0];

sectors_allSectors = sectors_allSectors + [_marker];
blufor_sectors = [_marker];
GRLIB_secondary_used_positions pushbackUnique _marker;

// spawn nuclear device + static + def squad
private _base_output = [_spawnpos, false, true] call createOutpost;
opfor_target = createVehicle ["Land_Device_disassembled_F", _spawnpos, [], 1, "CAN_COLLIDE"];
opfor_target addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];
	if (!isNull _instigator) then {
		if (isNull (getAssignedCuratorLogic _instigator)) then {
			_killer = _instigator;
		};
	} else {
		if (!(_killer isKindOf "CAManBase")) then {
			_killer = effectiveCommander _killer;
		};
	};

	private _currentDamage = damage _unit;
	private _newDamage = _currentDamage;
	private _now = serverTime;
	if (_damage >= 0.9 && side _killer == GRLIB_side_friendly && (_now > (_unit getVariable ["GRLIB_isProtected", 0]))) then {
		_unit setVariable ["GRLIB_isProtected", round(_now + 5), true];
		_newDamage = (_currentDamage + 0.03) min 1;
	};
	_newDamage;
}];
publicVariable "opfor_target";

private _savedpos = getPosWorld opfor_target;
opfor_target_assembled = createVehicle ["Land_Device_assembled_F", zeropos, [], 1, "CAN_COLLIDE"];
opfor_target_assembled setVectorDirAndUp [vectorDir opfor_target, vectorUp opfor_target];
opfor_target_assembled hideObjectGlobal true;

[_marker, 4] spawn spawn_static;
private _grp = [_marker, "csat", ([] call F_getAdaptiveSquadComp), true] call F_spawnRegularSquad;
[_grp, _spawnpos, 200] spawn defence_ai;

private _vehicle = [_spawnpos, (selectRandom opfor_vehicles)] call F_libSpawnVehicle;
(driver _vehicle) doFollow leader _grp;

private _players = [];
private _last_send = 0;
private _target = objNull;
private _continue = true;
private _success = false;
private _last = 0;

while { _continue } do {
	combat_readiness = 100;

	if ({alive _x} count (units _grp) == 0) then {
		if (time > _last) then {
			_grp = [_marker, "csat", ([] call F_getAdaptiveSquadComp), true] call F_spawnRegularSquad;
			[_grp, _spawnpos, 200] spawn defence_ai;
			_last = round (time + 180);
		};
	};

	if ((time > _last_send || opforcap < 50) && !opforcap_max) then {
		_last_send = round (time + 300);
		_players = (AllPlayers - (entities "HeadlessClient_F")) select { _x distance2D lhd > GRLIB_sector_size && _x distance2D (markerPos GRLIB_respawn_marker) > GRLIB_sector_size};
		_target = selectRandom _players;
		if (isNil "_target") then {
			[getPosATL _target] spawn send_paratroopers;
			sleep 5;
		};
		if (_target distance2D opfor_target > GRLIB_spawn_max) then {
			[getPosATL _target, GRLIB_side_enemy, 3] spawn spawn_air;
			sleep 5;
		};

		_int = floor random 3;
		switch (_int) do {
			case 0: { [_spawnpos] spawn send_paratroopers };
			case 1: { [_spawnpos, _int] spawn spawn_battlegroup_direct };
			case 2: { [_spawnpos, GRLIB_side_enemy, 3] spawn spawn_air };
		};
		sleep 5;
		[_int] remoteExec ["BIS_fnc_earthquake", 0];
		sleep 5;
	};

	if (time > sector_timer) then { _continue = false };
	if (damage opfor_target >= 1) then { _success = true; _continue = false };
	sleep 2;
};

deleteMarker _marker;
sector_timer = 0;
publicVariable "sector_timer";

if (_success) then {
	[5] remoteExec ["BIS_fnc_earthquake", 0];
	{ _x setDamage 1 } foreach (units GRLIB_side_enemy);
	private _smoke = GRLIB_sar_fire createVehicle (getPos opfor_target);
	_smoke attachTo [opfor_target, [0, 1.5, 0]];
	0 setFog 0;
	0 setRain 0;
	0 setOvercast 0;
	forceWeatherChange;
	sleep 5;
	[] spawn blufor_victory;
} else {
	{ if (count crew _x > 0) then {deleteVehicle _x} } foreach vehicles;
	{ deleteVehicle _x } foreach (units GRLIB_side_enemy);
	{ deleteVehicle _x } foreach (units GRLIB_side_friendly);
	sleep 3;
	opfor_target hideObjectGlobal true;
	opfor_target_assembled setPosWorld _savedpos;
	opfor_target_assembled hideObjectGlobal false;
	sleep 1;
	GRLIB_endgame = 2;
	publicVariable "GRLIB_endgame";
	//sleep 300;
};

GRLIB_secondary_in_progress = -1;
publicVariable "GRLIB_secondary_in_progress";