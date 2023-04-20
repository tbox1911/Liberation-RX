if (!isServer) exitWith {};
params ["_unit", "_id", "_uid", "_name"];

if !(isNull _unit) then {

	// Remove Dog
	private _my_dog = _unit getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then { deleteVehicle _my_dog };

	// Unlock Car too Far
	private _cleanveh = [vehicles, {
		_x getVariable ["GRLIB_vehicle_owner", ""] == _uid &&
		((getPos _x) distance2D ([_x] call F_getNearestFob)) >= 500
	}] call BIS_fnc_conditionalSelect;

	{
		_x setVariable ["GRLIB_vehicle_owner", "", true];
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVehicleLock "UNLOCKED";
	} forEach _cleanveh;

	// Remove Injured AI
	private _bros = allUnits select {(_x getVariable ["PAR_Grp_ID","0"]) == (_unit getVariable ["PAR_Grp_ID","1"])};
	{
		if (lifeState _x == "INCAPACITATED") then { deleteVehicle _x };
	} forEach _bros;

	// Remove Taxi
	private _taxi = _unit getVariable ["GRLIB_taxi_called", nil];
	if (!isNil "_taxi") then { deleteVehicle _taxi };

	// Remove Squad
	private _my_squad = _unit getVariable ["my_squad", nil];
	if (!isNil "_my_squad") then { {deleteVehicle _x} forEach units _my_squad };

	private _text = format ["Bye bye %1, see you soon...", _name];
	[gamelogic, _text] remoteExec ["globalChat", -2];

	// Delete body
	deleteVehicle _unit;
};
