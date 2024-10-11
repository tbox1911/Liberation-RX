/*
 Say hello, and set Rank/Insigna
*/
waitUntil {sleep 1; GRLIB_player_spawned};
waitUntil {sleep 1; (player getVariable ["GRLIB_Rank", "init"] != "init")};

private _score = [player] call F_getScore;
private _rank = player getVariable ["GRLIB_Rank", "Private"];
private _ammo_collected = player getVariable ["GREUH_ammo_count",0];

// first time notice
if (_score == 0) then {
	createDialog "liberation_notice";
	profileNamespace setVariable [format ["GRLIB_personal_arsenal_%1", GRLIB_game_ID], nil];
};

// disable UAVs
private _my_uavs = allUnitsUAV select { [player, _x] call is_owner };
{ player disableUAVConnectability [_x, true] } forEach _my_uavs;
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
if (!isNil "_my_squad") then { player hcSetGroup [_my_squad] };

// set Rank
[] call set_rank;
private _reput = [player] call F_getReputText;
private _color = _reput select 0;
private _text = _reput select 1;

private _msg = format [
	"Welcome <t color='#00008f'>%1</t> !<br/><br/>
	Your Rank : <t color='#000080'>%2</t><br/>
	Your Score : <t color='#008000'>%3</t> XP<br/>
	Your Credit : <t color='#800000'>%4</t> AMMO <br/><br/>
	Your Reputation with Civilians is <t color='%5'>%6</t>",
	name player, _rank, _score, _ammo_collected, _color, _text
];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;
