if ( isNil "active_sectors" ) then { active_sectors = [] };
private [
	"_usable_sectors",
	"_spawnsector",
	"_civ_grp",
	"_civ_veh",
	"_unit_ttl"
];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	sleep (30 + floor(random 30));
	while { [] call F_opforCap > GRLIB_patrol_cap || (diag_fps < 35.0) } do {
		sleep (30 + floor(random 30));
	};

	_civ_veh = objNull;
	_usable_sectors = [];
	{
		//(([getmarkerpos _x, 1000, GRLIB_side_friendly] call F_getUnitsCount) == 0) &&
		if ( (count ([getmarkerpos _x, 3500] call F_getNearbyPlayers) > 0) ) then {
			_usable_sectors pushback _x;
		}
	} foreach (sectors_bigtown + sectors_capture + sectors_factory - active_sectors);

	if ( count _usable_sectors > 0 ) then {
		_spawnsector = selectRandom _usable_sectors;
		_civ_grp = [_spawnsector] call F_spawnCivilians;
		if (!isNull _civ_grp) then {
				// 40% in vehicles
			if ( floor(random 100) > 60 ) then {
				_civ_veh = [markerPos _spawnsector, (selectRandom civilian_vehicles), false, false, GRLIB_side_civilian] call F_libSpawnVehicle;
				{ _x moveInAny _civ_veh } forEach (units _civ_grp);
				_civ_veh lockDriver true;
				_civ_veh lockCargo true;
				_civ_veh addEventHandler ["HandleDamage", {
					params ["_unit", "_selection", "_damage", "_source"];
					private _dam = 0;
					if ( side _source == GRLIB_side_friendly ) then {
						_dam = _damage;
					};
					if ( side(driver _unit) == GRLIB_side_friendly ) then {
						_dam = _damage;
					};
					_dam;
				}];
				_civ_veh addEventHandler ["Fuel", { if (!(_this select 1)) then {(_this select 0) setFuel 1}}];
				[_civ_veh] spawn {
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
			};

			[_civ_grp] spawn add_civ_waypoints;

			if (local _civ_grp) then {
				_headless_client = [] call F_lessLoadedHC;
				if (!isNull _headless_client) then {
					_civ_grp setGroupOwner ( owner _headless_client );
				};
			};

			_unit_ttl = round (time + 1800);
			waitUntil {
				sleep 30;
				( GRLIB_global_stop == 1 || (diag_fps < 25) || ({alive _x} count (units _civ_grp) == 0) || (round (speed (leader _civ_grp)) == 0) || (count ([getPosATL (leader _civ_grp), 3000] call F_getNearbyPlayers) == 0) || (time > _unit_ttl) )
			};

			// Cleanup
			if (!isNull _civ_veh) then { [_civ_veh] spawn clean_vehicle };
			{ deleteVehicle _x } forEach (units _civ_grp);
			deleteGroup _civ_grp;
		};
	};
};