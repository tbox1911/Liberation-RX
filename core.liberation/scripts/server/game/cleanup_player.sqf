if (!isServer) exitWith {};
params ["_unit", "_id", "_uid", "_name"];
if (_name in ["HC1","HC2","HC3" ]) exitWith {
	deleteMarker "fpsmarkerHC1";
	deleteMarker "fpsmarkerHC2";
	deleteMarker "fpsmarkerHC3";
};

if !(isNull _unit) then {
	diag_log format ["--- LRX: Cleanup player %1 (%2)", name _unit, _uid];

	// Remove Dog
	private _my_dog = _unit getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then { deleteVehicle _my_dog };

	// Unlock Car too Far
	private _cleanveh = [vehicles, {
		_x getVariable ["GRLIB_vehicle_owner", ""] == _uid &&
		((getPos _x) distance2D ([getPos _x] call F_getNearestFob)) >= 500
	}] call BIS_fnc_conditionalSelect;

	{
		_x setVariable ["GRLIB_vehicle_owner", "", true];
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVehicleLock "UNLOCKED";
	} forEach _cleanveh;

	// Remove Taxi
	private _taxi = _unit getVariable ["GRLIB_taxi_called", nil];
	if (!isNil "_taxi") then {
		deleteVehicle (nearestObjects [markerPos "taxi_lz", [taxi_helipad_type], 50] select 0);
		deleteMarkerLocal "taxi_lz";
		deleteVehicle (nearestObjects [markerPos "taxi_dz", [taxi_helipad_type], 50] select 0);
		deleteMarkerLocal "taxi_dz";
		{
			if (!isNil {_x getVariable ["GRLIB_counter_TTL", nil]}) then { deletevehicle _x };
		} forEach (crew _taxi);
		deleteVehicle _taxi;
	};

	// Remove Marker
	deletemarker format ["PAR_marker_%1", _name];

	// Remove Squad
	private _my_squad = _unit getVariable ["my_squad", nil];
	if (!isNil "_my_squad") then { {deleteVehicle _x} forEach units _my_squad };

	// Save Player Context
	private _score = 0; 
	{if ((_x select 0) == _uid) exitWith {_score = (_x select 1)}} forEach GRLIB_player_scores; 
	if (_score > 20) then { [_unit, _uid] call save_context };

	// Remove AI
	{ deleteVehicle _x } forEach (units _unit);

	private _text = format ["Bye bye %1, see you soon...", _name];
	[gamelogic, _text] remoteExec ["globalChat", -2];

	// Delete Body
	deleteVehicle _unit;

	// Remove Grave Box
	private _grave_box = _unit getVariable ["GRLIB_grave_box", nil];
	if (!isNil "_grave_box") then { deleteVehicle _grave_box };
};

private _player_left = count (AllPlayers - (entities "HeadlessClient_F"));
if (_player_left == 0) then {[] call save_game_mp};
