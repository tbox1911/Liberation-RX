private _vehicle_heavy = (opfor_vehicles - opfor_troup_transports_truck);
private _vehicle_light = (opfor_vehicles_low_intensity - opfor_troup_transports_truck);
private _vehicle_apc = _vehicle_heavy select { ([_x, ["Wheeled_APC_F", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "APC_Tracked_03_base_F"]] call F_itemIsInClass) };
private _vehicle_tank = (_vehicle_heavy select { _x isKindOf "Tank" }) - _vehicle_apc;

private _vehicle_pool = _vehicle_light - _vehicle_apc;
if ( combat_readiness > 15 ) then { _vehicle_pool = _vehicle_light };
if ( combat_readiness > 35 ) then { _vehicle_pool = _vehicle_light + _vehicle_apc };
if ( combat_readiness > 55 ) then { _vehicle_pool = _vehicle_heavy - _vehicle_tank };
if ( combat_readiness > 75 ) then { _vehicle_pool = _vehicle_heavy };

(selectRandom _vehicle_pool);
