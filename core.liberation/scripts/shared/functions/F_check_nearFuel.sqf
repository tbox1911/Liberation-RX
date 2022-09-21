params ["_vehicle"];
private _ret = false;
private _nearfuel = getPosATL _vehicle nearEntities [[canister_fuel_typename, fuelbarrel_typename], 15];
if (count _nearfuel > 0) then {_ret = true};
_ret;