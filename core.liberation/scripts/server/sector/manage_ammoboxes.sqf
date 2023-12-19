params [ "_sector" ];
private [ "_crates_amount", "_spawnpos", "_i", "_spawnclass", "_nearbuildings", "_intel_range", "_building_positions", "_used_positions", "_buildingposition", "_nbintel", "_compatible_classnames" ];

if ( isNil "GRLIB_military_sectors_already_activated" ) then { GRLIB_military_sectors_already_activated = [] };

if ( !( _sector in GRLIB_military_sectors_already_activated )) then {

	GRLIB_military_sectors_already_activated pushback _sector;

	if ( !GRLIB_passive_income ) then {
		_crates_amount = round ((1 + floor random 4) * GRLIB_resources_multiplier) min 6;
		if (GRLIB_difficulty_modifier > 1.5) then {
			_crates_amount = round (floor random 3);
		};
		_spawnpos = [4, (markerpos _sector), 100, 30, false] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
		if (count _spawnpos > 0) then {
			_vehicle = opfor_transport_truck createVehicle _spawnpos;
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