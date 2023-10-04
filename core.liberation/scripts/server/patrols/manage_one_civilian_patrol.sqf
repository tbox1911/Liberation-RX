if ( isNil "active_sectors" ) then { active_sectors = [] };
private [
	"_usable_sectors",
	"_sectorpos",
	"_civ_grp",
	"_civ_veh",
	"_unit_ttl",
	"_unit",
	"_radius"
];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	sleep (30 + floor(random 150));
	while { civcap > GRLIB_civilians_amount || (diag_fps < 35.0) } do {
		sleep 60;
	};

	_civ_veh = objNull;
	_usable_sectors = [];
	{
		if ( (count ([getmarkerpos _x, GRLIB_spawn_max] call F_getNearbyPlayers) > 0) ) then {
			_usable_sectors pushback _x;
		};
	} foreach (sectors_bigtown + sectors_capture + sectors_factory - active_sectors);

	if ( count _usable_sectors > 0 ) then {
		_sectorpos = markerPos (selectRandom _usable_sectors);
		// 40% in vehicles
		if ( floor(random 100) >= 60  && count civilian_vehicles > 0) then {
			_veh_class = selectRandom civilian_vehicles;
			_civ_veh = [_sectorpos, _veh_class, false, false, GRLIB_side_civilian] call F_libSpawnVehicle;
			_civ_grp = [_sectorpos, 1] call F_spawnCivilians;
			_unit = (units _civ_grp) select 0;
			_unit assignAsDriver _civ_veh;
			_unit moveInDriver _civ_veh;
			[_unit] orderGetIn true;
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
		} else {
			_civ_grp = [_sectorpos, 1 + (floor (random 2))] call F_spawnCivilians;
		};

		[_civ_grp, _sectorpos] spawn add_civ_waypoints;

		if (local _civ_grp) then {
			_headless_client = [] call F_lessLoadedHC;
			if (!isNull _headless_client) then {
				_civ_grp setGroupOwner ( owner _headless_client );
			};
		};

		// Wait
		_radius = GRLIB_spawn_max;
		if (_civ_veh isKindOf "Air") then {
			sleep 120;
			_radius = GRLIB_spawn_max * 2;
		};
		_unit_ttl = round (time + 1800);
		waitUntil {
			sleep 60;
			(
				GRLIB_global_stop == 1 ||
				(diag_fps < 25) ||
				({alive _x} count (units _civ_grp) == 0) ||
				//(round (speed (leader _civ_grp)) == 0) ||
				([getPos (leader _civ_grp), _radius, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
				(time > _unit_ttl)
			)
		};

		// Cleanup
		if (!isNull _civ_veh) then { [_civ_veh] spawn clean_vehicle };
		{ deleteVehicle _x } forEach (units _civ_grp);
		deleteGroup _civ_grp;	
	};
};