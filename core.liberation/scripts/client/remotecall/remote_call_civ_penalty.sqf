if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params [ "_civname", "_civ_penalty", "_killer" ];

gamelogic globalChat format [localize "STR_CIV_PENALTY_MESSAGE",  _civ_penalty, _civname, name _killer];