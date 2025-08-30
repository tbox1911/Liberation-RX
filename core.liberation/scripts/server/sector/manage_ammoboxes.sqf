params [ "_sector" ];
private [ "_crates_amount", "_vehicle"];

if ( isNil "GRLIB_military_sectors_already_activated" ) then { GRLIB_military_sectors_already_activated = [] };

if ( !( _sector in GRLIB_military_sectors_already_activated )) then {

	GRLIB_military_sectors_already_activated pushBackUnique _sector;

	if (GRLIB_passive_income == 0) then {
		_crates_amount = round ((1 + floor random 4) * GRLIB_resources_multiplier) min 6;
		if (GRLIB_difficulty_modifier > 1.5) then {
			_crates_amount = (1 + floor random 3);
		};
		_vehicle = [markerPos _sector, opfor_transport_truck, 3, false, GRLIB_side_enemy, false] call F_libSpawnVehicle;
		if (isNull _vehicle) then {
			diag_log format ["--- LRX Error: No place to build %1 at sector %2", opfor_transport_truck, _sector];
		} else {
			[_vehicle, "lock", "server"] call F_vehicleLock;
			_vehicle enableSimulationGlobal true;
		};
		for "_i" from 1 to _crates_amount do {
			_newbox = [ammobox_o_typename, markerpos _sector, true] call boxSetup;
			[_newbox] call F_clearCargo;
		};
	};
	[markerPos _sector] spawn manage_intels;
};