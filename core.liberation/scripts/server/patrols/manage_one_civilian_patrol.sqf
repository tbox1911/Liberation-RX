if ( isNil "active_sectors" ) then { active_sectors = [] };
private [
	"_usable_sectors",
	"_spawnsector",
	"_grp",
	"_civ_veh",
	"_civ_unit",
	"_civ_unit_ttl"
];

while { GRLIB_endgame == 0 } do {
	sleep (30 + floor(random 30));
	while { [] call F_opforCap > GRLIB_patrol_cap || (diag_fps < 30.0) } do {
		sleep (30 + floor(random 30));
	};

	_civ_veh = objNull;
	_usable_sectors = [];
	{
		if ( ( ( [ getmarkerpos _x , 1000 , GRLIB_side_friendly ] call F_getUnitsCount ) == 0 ) && ( count ( [ getmarkerpos _x , 3500 ] call F_getNearbyPlayers ) > 0 ) ) then {
			_usable_sectors pushback _x;
		}
	} foreach ((sectors_bigtown + sectors_capture + sectors_factory) - (active_sectors));

	if ( count _usable_sectors > 0 ) then {
		_spawnsector = selectRandom _usable_sectors;
		_civ_unit = [_spawnsector] call F_spawnCivilians;
		if (!isNil "_civ_unit") then {
			_grp = group _civ_unit;

			// 40% in vehicles
			if ( floor(random 100) > 60 ) then {
				_civ_veh = [markerPos _spawnsector, (selectRandom civilian_vehicles), false, false, true] call F_libSpawnVehicle;
				_civ_unit moveInDriver _civ_veh;
				_civ_unit assignAsDriver _civ_veh;
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

			[_grp] spawn add_civ_waypoints;

			if ( local _grp ) then {
				_headless_client = [] call F_lessLoadedHC;
				if ( !isNull _headless_client ) then {
					_grp setGroupOwner ( owner _headless_client );
				};
			};

			_civ_unit_ttl = round(time + 1800);
			waitUntil {
				sleep 60;
				( (diag_fps < 20) || (!alive _civ_unit) || round (speed vehicle _civ_unit) == 0 || (count ([getPosATL _civ_unit , 4000] call F_getNearbyPlayers) == 0) || time > _civ_unit_ttl )
			};

			// Cleanup
			if (!isNull _civ_veh) then {
				if ( ({(alive _x) && (side group _x == GRLIB_side_friendly)} count (crew _civ_veh) == 0) || [_civ_veh] call is_abandoned ) then {
					[_civ_veh] call clean_vehicle;
					deleteVehicle _civ_veh;
				};
			};
			deletevehicle _civ_unit;
			deleteGroup _grp;
		};
	};
};