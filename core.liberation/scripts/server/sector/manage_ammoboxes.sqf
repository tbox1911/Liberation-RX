params [ "_sector" ];
private [ "_crates_amount", "_vehicle"];

if ( isNil "GRLIB_military_sectors_already_activated" ) then { GRLIB_military_sectors_already_activated = [] };

if ( !( _sector in GRLIB_military_sectors_already_activated )) then {

	GRLIB_military_sectors_already_activated pushback _sector;

	if ( !GRLIB_passive_income ) then {
		_crates_amount = round ((1 + floor random 4) * GRLIB_resources_multiplier) min 6;
		if (GRLIB_difficulty_modifier > 1.5) then {
			_crates_amount = (1 + floor random 3);
		};
		// _spawnpos = [(markerpos _sector), 3] call F_findSafePlace;
		// if (count _spawnpos > 0) then {
		// 	// _vehicle = opfor_transport_truck createVehicle _spawnpos;
		// 	// _vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		// 	// _vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
		// };
		_vehicle = [markerPos _sector, opfor_transport_truck, false, false, GRLIB_side_civilian, false] call F_libSpawnVehicle;
		if (isNull _vehicle) then {
			diag_log format ["--- LRX Error: No place to build %1 at sector %2", opfor_transport_truck, _sector];
		} else {
			_vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
		};
		for "_i" from 1 to _crates_amount do {
			_newbox = [ammobox_o_typename, markerpos _sector, true] call boxSetup;
			[_newbox] call F_clearCargo;
		};
	};
	[markerPos _sector] spawn manage_intels;
};