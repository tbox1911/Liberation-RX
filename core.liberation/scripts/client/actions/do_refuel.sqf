params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

private _max_fuel = 1;
private _jerycan = (_vehicle nearEntities [[canister_fuel_typename, fuelbarrel_typename], 15]) select { alive _x && getObjectType _x >= 8 } select 0;

if (!isNil "_jerycan") then {
	if (_jerycan isKindOf canister_fuel_typename) then {_max_fuel = 0.20};
	if (_jerycan isKindOf fuelbarrel_typename) then {_max_fuel = 0.40};
	deleteVehicle _jerycan;
};

[_vehicle, (fuel _vehicle) + _max_fuel] remoteExec ["setFuel", 0];
playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_refuel.wss", _vehicle];
hintSilent localize "STR_DO_REFUEL";
