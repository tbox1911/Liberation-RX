private [ "_vehicle_to_spawn" ];

_vehicle_to_spawn = selectRandom (opfor_vehicles - opfor_troup_transports_truck);
if ( combat_readiness < 35 ) then {
	_vehicle_to_spawn = selectRandom (opfor_vehicles_low_intensity - opfor_troup_transports_truck);
};

_vehicle_to_spawn;
