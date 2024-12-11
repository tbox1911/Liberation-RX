params ["_vehicle"];

private _vehicle_damage = [_vehicle] call F_getVehicleDamage;
(_vehicle_damage >= 0.05 || damage _vehicle >= 0.05);   // 5% damaged
