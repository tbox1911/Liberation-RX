params ["_vehicle"];

private _owner = [_vehicle] call F_getVehicleOwner;
private _fuel = round (fuel _vehicle * 100);
private _ammo = round (([_vehicle] call F_getVehicleAmmoDef) * 100);
private _damage = round (([_vehicle] call F_getVehicleDamage) * 100);
private _cargo = [_vehicle] call R3F_calculer_chargement_vehicule;
hintSilent format [localize "STR_PAR_VEHICLE_STATUS_HINT", _owner, _damage, _fuel, _ammo, _cargo select 0, _cargo select 1];
sleep 5;
hintSilent "";
