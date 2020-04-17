/*
 Say hello, and set Rank/Insigna
*/
waitUntil {sleep 1;GRLIB_player_spawned};

while {	(player getVariable "GRLIB_score_set" == 0) } do {
	_msg= "... Loading Player Data ...";
    [_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	uIsleep 2;
	_msg= "... Please Wait ...";
    [_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	uIsleep 2;
};

// Load Loadout
if (! isNil "GRLIB_respawn_loadout" && isNil "GRLIB_loadout_overide") then {
	GRLIB_backup_loadout = [player] call F_getLoadout;
	player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];
	[player, GRLIB_respawn_loadout] call F_setLoadout;
	[player] call F_payLoadout;
};

private _score = score player;
private _rank = [player] call set_rank;
private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
// notice
if (_score == 0) then {	_dialog = createDialog "liberation_notice" };
private _msg = format ["Welcome <t color='#00008f'>%1</t> !<br/><br/>
Your Rank : <t color='#000080'>%2</t><br/>
Your Score : <t color='#008000'>%3</t><br/>
Your Credit : <t color='#800000'>%4</t>", name player, _rank, _score, _ammo_collected];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;
