params ["_vehicle"];
if (isNil "_vehicle") exitWith {};
private ["_fuel", "_can", "_result"];

_fuel = fuel _vehicle;
if (_fuel >= 0.25) then {
	_result = [format [localize "STR_DO_DEFUEL", typeOf _vehicle], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
	if (_result) then {
		_can = createVehicle [canister_fuel_typename, (player modelToWorld [0,1,1]), [], 0, "CAN_COLLIDE"];
		_can enableSimulationGlobal false;
		[_can, player, 0, true] spawn R3F_LOG_FNCT_objet_deplacer;
		[_vehicle, _fuel - 0.25] remoteExec ["setFuel", 0];
		hintSilent localize "STR_FUEL_READY";
		sleep 3;
		_can enableSimulationGlobal true;
	};
};
