/*
 Say hello, and set Rank/Insigna
*/
waitUntil {sleep 1; GRLIB_player_spawned};

private _score = [player] call F_getScore;
private _rank = player getVariable ["GRLIB_Rank", "Private"];
private _ammo_collected = player getVariable ["GREUH_ammo_count",0];

// first time notice
if (_score == 0) then {	createDialog "liberation_notice" };

// disable UAVs
player connectTerminalToUAV objNull;
private _my_uavs = allUnitsUAV select { [player, _x] call is_owner };
{
    player disableUAVConnectability [_x, true];
} forEach _my_uavs;

// HCI Command IA
hcRemoveAllGroups player;
if (player == ([] call F_getCommander)) then {
	private _my_veh = vehicles select {
		!([_x, "LHD", GRLIB_sector_size] call F_check_near) &&
		[player, _x] call is_owner &&
		_x getVariable ["GRLIB_vehicle_manned", false] &&
		count (crew _x) > 0
	};
	{ player hcSetGroup [group _x] } foreach _my_veh;
};

private _my_squad = player getVariable ["my_squad", nil];
if (!isNil "_my_squad") then { player hcSetGroup [_my_squad] };
private _my_veh = vehicles select {([_x, uavs] call F_itemIsInClass) && [player, _x] call is_owner};
{player hcSetGroup [group _x]} forEach _my_veh;

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

[player] remoteExec ["load_context_remote_call", 2];
