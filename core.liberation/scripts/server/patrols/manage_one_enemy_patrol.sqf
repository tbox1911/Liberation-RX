params ["_readiness"];

if ( isNil "active_sectors" ) then { active_sectors = [] };
private [
	"_usable_sectors",
	"_spawnsector",
	"_sectorpos",
	"_opfor_grp",
	"_opfor_veh",
	"_unit_ttl"
];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	//sleep (300 + floor(random 300));
	while { opforcap > GRLIB_patrol_cap || (diag_fps < 35.0) || combat_readiness < _readiness } do {
		sleep 60;
	};

	_opfor_veh = objNull;
	_usable_sectors = [];
	{
		if ( (count ([getmarkerpos _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) && (count ([getmarkerpos _x, GRLIB_sector_size] call F_getNearbyPlayers) == 0) ) then {			
			_usable_sectors pushback _x;
		};
	} foreach (sectors_bigtown + sectors_capture + sectors_factory - active_sectors);

	if ( count _usable_sectors > 0 ) then {
		_spawnsector = (selectRandom _usable_sectors);
		_sectorpos = markerPos _spawnsector;

		// 50% in vehicles
		if ( floor(random 100) > 50 && count militia_vehicles > 0 ) then {
			_opfor_veh = [_sectorpos, (selectRandom militia_vehicles), false, false, GRLIB_side_enemy] call F_libSpawnVehicle;
			_opfor_grp = group (driver _opfor_veh);
			_opfor_veh addEventHandler ["Fuel", { if (!(_this select 1)) then {(_this select 0) setFuel 1}}];
			[_opfor_veh] spawn {
				params ["_vehicle"];
				if (typeOf _vehicle isKindOf "Air") exitWith {};
				while { alive _vehicle } do {
					// Correct static position
					if ((vectorUp _vehicle) select 2 < 0.70) then {
						_vehicle setpos [(getposATL _vehicle) select 0, (getposATL _vehicle) select 1, 0.5];
						_vehicle setVectorUp surfaceNormal position _vehicle;
					};
					sleep 5;
				};
			};
		} else {
			_opfor_grp = [_spawnsector, "militia", ([] call F_getAdaptiveSquadComp)] call F_spawnRegularSquad;
		};

		{ _x setVariable ["GRLIB_mission_AI", true, true] } forEach (units _opfor_grp);
		[_opfor_grp, _sectorpos] spawn add_civ_waypoints;

		if (local _opfor_grp) then {
			_headless_client = [] call F_lessLoadedHC;
			if (!isNull _headless_client) then {
				_opfor_grp setGroupOwner ( owner _headless_client );
			};
		};

		// Wait
		_unit_ttl = round (time + 1800);
		waitUntil {
			sleep 60;
			(
				GRLIB_global_stop == 1 ||
				(diag_fps < 25) ||
				({alive _x} count (units _opfor_grp) == 0) ||
				//(round (speed (leader _opfor_grp)) == 0) ||
				([getPos (leader _opfor_grp), GRLIB_spawn_max, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
				(time > _unit_ttl)
			)
		};

		// Cleanup
		waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_sectorpos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		if (!isNull _opfor_veh) then { [_opfor_veh] spawn clean_vehicle };
		{ deleteVehicle _x } forEach (units _opfor_grp);
		deleteGroup _opfor_grp;
	};
};
