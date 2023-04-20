params [ "_classname", "_bounty", "_bonus", "_killer" ];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};
if (!GRLIB_player_spawned) exitWith {};

private _vehiclename = [_classname] call F_getLRXName;
private _playername = [_killer] call get_player_name;
gamelogic globalChat format [localize "STR_BOUNTY_MESSAGE"+".  Bonus Score %4pts !",  _bounty, _vehiclename, _playername, _bonus];

if (player == _killer) then {
	[_killer, _bounty, 0] remoteExec ["ammo_add_remote_call", 2];
	[_killer, _bonus] remoteExec ["F_addScore", 2];
	_killer addRating 500;
};
