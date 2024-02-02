if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params [ "_civname", "_civ_penalty", "_killer" ];

private _playername = [_killer] call get_player_name;
gamelogic globalChat format [localize "STR_CIV_PENALTY_MESSAGE",  _civ_penalty, _civname, _playername];