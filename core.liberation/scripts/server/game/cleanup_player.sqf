if (!isServer) exitWith {};
params [ "_uid" ];

_player = objNull;
{
	if (getPlayerUID _x == _uid) exitWith { _player = _x; };
} forEach allPlayers;

if !(isNull _player) then {

	// Remove Dog
	private _my_dog = _player getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then { deleteVehicle _my_dog };

	// Unlock Car too Far
	_cleanveh = [vehicles, {
		_x getVariable ["GRLIB_vehicle_owner", ""] == _uid &&
		((getPos _x) distance2D ([_x] call F_getNearestFob)) >= 500
	}] call BIS_fnc_conditionalSelect;

	{
		_x setVariable ["GRLIB_vehicle_owner", "", true];
		_x setVariable ["R3F_LOG_disabled", false, true];
		[_x, "UNLOCKED"] remoteExec ["setVehicleLock", 0];
	} forEach _cleanveh;

	// Remove Injured AI
	{
		if (!(lifeState _x in ["HEALTHY", "INJURED"])) then { deleteVehicle _x };
	} forEach units group _player;

	_text = format ["Bye bye %1, see you soon...", name _player];
	[gamelogic, _text] remoteExec ["globalChat", -2];
};


