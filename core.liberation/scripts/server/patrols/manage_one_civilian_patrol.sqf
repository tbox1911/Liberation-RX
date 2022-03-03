if ( isNil "active_sectors" ) then { active_sectors = [] };

while { GRLIB_endgame == 0 } do {
	sleep (30 + floor(random 30));
	while { [] call F_opforCap > GRLIB_patrol_cap || (diag_fps < 25.0) } do {
		sleep (30 + floor(random 30));
	};

	private _civveh = objNull;
	private _spawnsector = "";
	private _usable_sectors = [];
	{
		if ( ( ( [ getmarkerpos _x , 1000 , GRLIB_side_friendly ] call F_getUnitsCount ) == 0 ) && ( count ( [ getmarkerpos _x , 3500 ] call F_getNearbyPlayers ) > 0 ) ) then {
			_usable_sectors pushback _x;
		}
	} foreach ((sectors_bigtown + sectors_capture + sectors_factory) - (active_sectors));

	if ( count _usable_sectors > 0 ) then {
		private _spawnsector = selectRandom _usable_sectors;
		private _civ = ([_spawnsector, 1] call F_spawnCivilians) select 0;

		if (!isNil "_civ") then {
			private _grp = group _civ;

			if ( floor(random 100) > 60 ) then {
				private _nearestroad = objNull;
				private _max_try = 10;
				while { isNull _nearestroad && _max_try > 0} do {
					_nearestroad = [ [getmarkerpos (_spawnsector), floor(random 100), random 360] call BIS_fnc_relPos, 200, [] ] call BIS_fnc_nearestRoad;
					_max_try = _max_try - 1;
					sleep 0.5;
				};

				if (!isNull _nearestroad) then {
					private _spawnpos = getposATL _nearestroad;
					private _classname = selectRandom civilian_vehicles;
					if ( _classname isKindOf "Air" ) then {
						_civveh = createVehicle [_classname, _spawnpos, [], 0, 'FLY'];
						_civveh setPosATL (getPosATL _civveh vectorAdd [0, 0, 150]);
						_civveh flyInHeight 150;
					} else {
						if (surfaceIsWater _spawnpos) then {
							_classname = selectRandom boats_names;
						};
						_civveh = _classname createVehicle _spawnpos;
						_civveh setposATL _spawnpos;
					};
					_civ moveInDriver _civveh;

					_civveh addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
					_civveh addEventHandler ["HandleDamage", { 
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
					_civveh addEventHandler ["Fuel", { if (!(_this select 1)) then {(_this select 0) setFuel 1}}];
					[_grp] call add_civ_waypoints;
				};
			};

			if ( local _grp ) then {
				_headless_client = [] call F_lessLoadedHC;
				if ( !isNull _headless_client ) then {
					_grp setGroupOwner ( owner _headless_client );
				};
			};

			waitUntil {
				sleep 10;
				( (!alive _civ) || ( count ([getpos _civ , 4000] call F_getNearbyPlayers) == 0 ) )
			};

			if ( alive _civ ) then {
				if ( !(isNull _civveh) ) then {
					if ( {(alive _x) && (side group _x == GRLIB_side_friendly)} count (crew _civveh) == 0 && [_civveh] call is_abandoned) then {
						[_civveh] call clean_vehicle;
						deleteVehicle _civveh;
					};
				};
				deletevehicle _civ;
				deleteGroup _grp;
			};
		};
	};
};