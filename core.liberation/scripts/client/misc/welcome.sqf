/*
 Say hello, and set Rank/Insigna
*/

waitUntil {sleep 0.1; GRLIB_player_spawned && (player getVariable ["GRLIB_score_set", 0] == 1)};

private _score = [player] call F_getScore;
private _rank = player getVariable ["GRLIB_Rank", "Private"];
private _ammo_collected = player getVariable ["GREUH_ammo_count",0];

// set Rank
[_score] call set_rank;

// first time notice
if (_score == 0) then {	createDialog "liberation_notice" };

// disable UAVs
[player] call F_correctUAVT;
player connectTerminalToUAV objNull;

// HCI Command IA
hcRemoveAllGroups player;
if ([player] call F_getCommander) then {
	private _my_veh = vehicles select {
		(_x getVariable ["GRLIB_vehicle_manned", false]) &&
		([player, _x] call is_owner) &&
		(_x getVariable ["R3F_LOG_disabled", false]) &&
		!(typeOf _x in uavs_vehicles + static_vehicles_AI)
	};
	{ player hcSetGroup [group _x] } foreach _my_veh;
};

private _my_squad = player getVariable ["my_squad", nil];
if (!isNil "_my_squad") then {
	if (player != hcLeader _my_squad) then {
		(hcLeader _my_squad) hcRemoveGroup _my_squad;
		player hcSetGroup [_my_squad];
	};
};

private _reput = [player] call F_getReputText;
private _color = _reput select 0;
private _text = _reput select 1;

private _msg = format [localize "STR_UI_WELCOME_MSG", name player, _rank, _score, _ammo_collected, _color, _text];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

// Load Player Suad Context
if !(player getVariable ["GRLIB_squad_context_loaded", false]) then {
	[player] remoteExec ["load_squad_context_remote_call", 2];
};

GRLIB_player_configured = true;
diag_log format ["--- LRX Player %1 initialized ---", name player];
