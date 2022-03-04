if ( isDedicated ) exitWith {};

params [ "_classname", "_bounty", "_bonus", "_killer" ];

private _vehiclename =  getText ( configFile >> "cfgVehicles" >> _classname >> "displayName" );
private _playername = "";
if(count (squadParams _killer) != 0) then {
	_playername = "[" + ((squadParams _killer select 0) select 0) + "] ";
};
_playername = _playername + name _killer;

gamelogic globalChat format [localize "STR_BOUNTY_MESSAGE"+".  Bonus Score %4pts !",  _bounty, _vehiclename, _playername, _bonus];

if (player == _killer) then {
	[_killer, _bounty] remoteExec ["ammo_add_remote_call", 2];
	[_killer, _bonus] remoteExec ["addScore", 2];
	_killer addRating 500;
};
