private _vehicle_pool = (opfor_vehicles - opfor_troup_transports_truck);

if ( combat_readiness < 35 ) then {
	_vehicle_pool = (opfor_vehicles_low_intensity - opfor_troup_transports_truck);
};

(selectRandom _vehicle_pool)
