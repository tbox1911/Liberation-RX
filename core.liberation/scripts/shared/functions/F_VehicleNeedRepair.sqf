params ["_vehicle"];
if (isNil "_vehicle") exitWith {0};
if (isNull _vehicle) exitWith {0};

private _vehicle_damage = [_vehicle] call F_getVehicleDamage;
(_vehicle_damage >= 0.04 || damage _vehicle >= 0.04);   // 5% damaged
