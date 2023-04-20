if ( isDedicated ) exitWith {};

params [ "_classname", "_bounty", "_bonus", "_killer" ];
private [ "_vehiclename", "_playername", "_ammo_collected" ];

_vehiclename =  getText ( configFile >> "cfgVehicles" >> _classname >> "displayName" );
_playername = "";
if(count (squadParams _killer) != 0) then {
	_playername = "[" + ((squadParams _killer select 0) select 0) + "] ";
};
_playername = _playername + name _killer;

gamelogic globalChat (format [localize "STR_BOUNTY_MESSAGE"+".  Bonus Score %4pts !",  _bounty, _vehiclename, _playername, _bonus] );

if (player == _killer) then {
	_ammo_collected = _killer getVariable ["GREUH_ammo_count",0];
	_killer setVariable ["GREUH_ammo_count", (_ammo_collected + _bounty), true];
	[_killer, _bonus] remoteExec ["addScore", 2];
	_killer addRating 500;
};
