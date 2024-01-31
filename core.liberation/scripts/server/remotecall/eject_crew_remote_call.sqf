if (!isServer && hasInterface) exitWith {};
params ["_player", "_vehicle"];

private _crew = crew _vehicle;
if (count _crew == 0) exitWith {};

private _grp = group (_crew select 0);
{ [_x, false] spawn F_ejectUnit; sleep 0.1 } forEach _crew;

if (side _grp == GRLIB_side_civilian && !([_player, _vehicle] call is_owner)) then {
    [localize "STR_DO_EJECT"] remoteExec ["hintSilent", owner _player];
    ["vtolAlarm"] remoteExec ["playSoundNow", owner _player];
	[_player, -5] call F_addScore;
	[_vehicle, "abandon"] call F_vehicleLock;

	private _sector = [sectors_allSectors, _vehicle] call F_nearestPosition;
	if (_sector != "") then {
		[_grp, markerPos _sector] spawn add_civ_waypoints;
	} else {
		sleep 60;
		{ deleteVehicle _x } forEach _crew;
	};
};
