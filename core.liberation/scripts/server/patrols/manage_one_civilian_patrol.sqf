GRLIB_civilians_current = GRLIB_civilians_current + 1;
publicVariable "GRLIB_civilians_current";

sleep (30 + (floor random 150));
while { diag_fps <= 20 } do { sleep 60 };

private _civ_veh = objNull;
private _civ_grp = grpNull;
private _usable_sectors = [];
private _search_sectors = (sectors_allSectors + sectors_opforSpawn + A3W_mission_sectors - active_sectors) call BIS_fnc_arrayShuffle;
{
	if (count ([markerPos _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) exitWith {
		_usable_sectors pushback _x;
	};
	sleep 0.1;
} foreach _search_sectors;

if ( count _usable_sectors > 0 ) then {
	private _sector_pos = markerPos (selectRandom _usable_sectors);
	// 40% in vehicles
	if (floor random 100 >= 60) then {
		_civ_veh = [_sector_pos, (selectRandom civilian_vehicles), 3, false, GRLIB_side_civilian] call F_libSpawnVehicle;
		if !(isNull _civ_veh) then { _civ_grp = group (driver _civ_veh) };
	} else {
		_civ_grp = [_sector_pos] call F_spawnCivilians;
	};

	sleep 1;
	if (isNil "_civ_grp") exitWith {};
	[_civ_grp, _sector_pos] spawn add_civ_waypoints;
	if !(isNull _civ_veh) then {
		[_civ_veh] spawn civilian_ai_veh;
	};

	sleep 60;

	// Wait
	private _unit_ttl = round (time + 1800);
	private _unit_pos = getPosATL (leader _civ_grp);
	private _radius = GRLIB_spawn_max * 1.5;
	waitUntil {
		if (alive (leader _civ_grp)) then { _unit_pos = getPosATL (leader _civ_grp) };
		sleep 60;
		if (round (speed vehicle leader _civ_grp) == 0) then {
			[leader _civ_grp] spawn F_fixPosUnit;
			sleep 1;
			(leader _civ_grp) switchMove "AmovPercMwlkSrasWrflDf";
			(leader _civ_grp) playMoveNow "AmovPercMwlkSrasWrflDf";
		};
		(
			GRLIB_global_stop == 1 ||
			(diag_fps < 20) ||
			({alive _x} count (units _civ_grp) == 0) ||
			([_unit_pos, _radius, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
			(time > _unit_ttl)
		)
	};

	// Cleanup
	waitUntil { sleep 30; (GRLIB_global_stop == 1 || (diag_fps < 10) || [_unit_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
	[_civ_veh] call clean_vehicle;
	{ deleteVehicle _x } forEach (units _civ_grp);
	deleteGroup _civ_grp;
};

GRLIB_civilians_current = GRLIB_civilians_current - 1;
publicVariable "GRLIB_civilians_current";
