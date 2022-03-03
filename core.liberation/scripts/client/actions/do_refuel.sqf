params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

private _jerycan = getPosATL _vehicle nearEntities [[canisterFuel, fuelbarrel_typename], 15] select 0;

if (!isNil "_jerycan") then {
	private _max_fuel = 0.30; // 0.1
	if (typeOf _jerycan == fuelbarrel_typename) then {_max_fuel = 0.7}; // 0.5
	[_vehicle, (fuel _vehicle) + _max_fuel] remoteExec ["setFuel", 0];
	[_jerycan] remoteExec ["deleteVehicle", 2];
	playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_refuel.wss", _vehicle];
	hintSilent localize "STR_DO_REFUEL";
};
