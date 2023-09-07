params [ ["_mission_cost", 0], "_caller" ];

private _spawnpos = [];
private _spawnlist = [];
{
	_spawnpos = [markerPos _x, 0, GRLIB_sector_size, 30, 0, 15, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
	if !(_spawnpos isEqualTo zeropos) then {_spawnlist pushBack _spawnpos};
} foreach sectors_allSectors;
if (count _spawnlist == 0) exitWith {[gamelogic, "Could not find enough free space for Armageddon mission"] remoteExec ["globalChat", 0]};

diag_log format ["--- LRX: %1 start static mission: Armageddon at %2", _caller, time];
resources_intel = resources_intel - _mission_cost;
GRLIB_secondary_in_progress = 3;
publicVariable "GRLIB_secondary_in_progress";

GRLIB_global_stop = 1;
publicVariable "GRLIB_global_stop";

[] remoteExec ["remote_call_final_fight", 0];

{ deleteVehicle _x } foreach (units GRLIB_SELL_Group);
{ deleteVehicle _x } foreach (units GRLIB_SHOP_Group);

// weather cloudy
[] spawn {
	while { overcast <= 0.85 } do {
		chosen_weather = (overcast + 0.10);
		publicVariable "chosen_weather";
		0 setOvercast chosen_weather;
		forceWeatherChange;
		sleep 20;
	};
};

// create marker
_spawnpos = selectRandom _spawnlist;
private _marker = createMarkerLocal ["final_fight", _spawnpos];
_marker setMarkerTypeLocal "mil_destroy";
_marker setMarkerSizeLocal [1.25, 1.25];
_marker setMarkerColorLocal GRLIB_color_enemy_bright;
_marker setMarkerText "FINAL FIGHT";
sectors_allSectors = sectors_allSectors + [_marker];
blufor_sectors = [_marker];
GRLIB_secondary_used_positions pushbackUnique _marker;

// spawn nuclear device + static + def squad
private _base_output = [_spawnpos, false, true] call createOutpost;
opfor_target = createVehicle ["Land_Device_disassembled_F", _spawnpos, [], 1, "CAN_COLLIDE"];
opfor_target addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_killer"];
	private _ret = damage _unit;
	private _amountOfDamage = (_damage - _ret);
	if (!isNull _killer && side _killer == GRLIB_side_friendly && _amountOfDamage > 1) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			_ret = _ret + 0.05;
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
		};
	};
	_ret;
}];

publicVariable "opfor_target";

[_marker, 4] spawn static_manager;
private _grp = [_marker, "csat", ([] call F_getAdaptiveSquadComp)] call F_spawnRegularSquad;
[_grp, _spawnpos, 200] spawn add_defense_waypoints;

private _vehicle = [_spawnpos, (selectRandom opfor_vehicles)] call F_libSpawnVehicle;
(driver _vehicle) doFollow leader _grp;

private _mission_delay = (45 * 60);
private _timer = round (time + _mission_delay);
private _continue = true;
private _success = false;
private _last_send = 0;
private _target = objNull;

[_marker, 1, _mission_delay] remoteExec ["remote_call_sector", 0];
sleep 60;

while { _continue } do {
	combat_readiness = 100;

	if ((time > _last_send || opforcap < 50) && opforcap < GRLIB_sector_cap ) then {
		_last_send = round (time + 300);
		_target = objNull;
		while { isNull _target } do {
			_target = selectRandom ((units GRLIB_side_friendly) select { _x distance2D lhd > GRLIB_fob_range && !(typeOf (vehicle _x) in uavs) });
			if (isNil "_target") then { sleep 10; _target = objNull };
			//if (isNil "_target") then { _target = selectRandom (units GRLIB_FOB_Group) };
		};

		[getPosATL _target] spawn send_paratroopers;
		if (_target distance2D opfor_target > GRLIB_spawn_max) then {
			[getPosATL _target, GRLIB_side_enemy, 3] spawn spawn_air;
		};

		_int = floor random 3;
		switch (_int) do {
			case 0: { [_spawnpos] spawn send_paratroopers };
			case 1: { [_spawnpos, _int] spawn spawn_battlegroup_direct };
			case 2: { [_spawnpos, GRLIB_side_enemy, 3] spawn spawn_air };
		};

		[_int] remoteExec ["BIS_fnc_earthquake", 0];

		sleep 5;
	};

	if (time > _timer) then { _continue = false };
	if (damage opfor_target == 1) then { _success = true; _continue = false };
	sleep 2;
};

deleteMarker _marker;
GRLIB_secondary_in_progress = -1;
publicVariable "GRLIB_secondary_in_progress";

if (_success) then {
	[5] remoteExec ["BIS_fnc_earthquake", 0];
	private _smoke = "test_EmptyObjectForSmoke" createVehicle (getPos opfor_target);
	_smoke attachTo [opfor_target, [0, 1.5, 0]];
	{ _x setDamage 1 } foreach (units GRLIB_side_enemy);
	0 setOvercast 0;
	forceWeatherChange;
	sleep 5;
	blufor_sectors = sectors_allSectors;
	opfor_sectors = [];
	[] spawn check_victory_conditions;
} else {
	{ deleteVehicle _x } foreach (units GRLIB_side_enemy);
	0 setFog 0;
	0 setRain 0;
	forceWeatherChange;
	sleep 9;
	private _savedpos = getPosWorld opfor_target;
    private _nextdir = [vectorDir opfor_target, vectorUp opfor_target];
	opfor_target hideObjectGlobal true;
	private _opfor_target_assembled = createVehicle ["Land_Device_assembled_F", _savedpos, [], 1, "CAN_COLLIDE"];
	_opfor_target_assembled setVectorDirAndUp [_nextdir select 0, _nextdir select 1];
	_opfor_target_assembled setPosWorld _savedpos;
	GRLIB_endgame = 2;
	publicVariable "GRLIB_endgame";
	sleep 100;
	endMission "END";
	forceEnd;
};
