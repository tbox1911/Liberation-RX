params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

_jerycan = ((nearestObjects [(getPosATL _vehicle), [canisterFuel], 15]) select 0);
if (!isNil "_jerycan") then {
	[_vehicle, (fuel _vehicle) + 0.10] remoteExec ["setFuel", 0];
	[_jerycan] remoteExec ["deleteVehicle", 2];
	playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_refuel.wss", _vehicle];
	hintSilent "Fuel refilling Done.";
};
