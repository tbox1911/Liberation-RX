/*
 Say hello, and set Rank/Insigna
*/
waitUntil {sleep 1;GRLIB_player_spawned};

private _score = score player;
private _rank = [player] call set_rank;
private _ammo_collected = player getVariable ["GREUH_ammo_count",0];

// Loadout
if (isNil "GRLIB_loadout_overide") then { GRLIB_loadout_overide = false };
if (!GRLIB_loadout_overide) then {
	if (GRLIB_forced_loadout > 0) then {
		[player] call compile preprocessFileLineNumbers (format ["mod_template\%1\loadout\player_set%2.sqf", GRLIB_mod_west, GRLIB_forced_loadout]);
	} else {
		[player, configfile >> "CfgVehicles" >> typeOf player] call BIS_fnc_loadInventory;
	};
	if (typeOf player in units_loadout_overide) then {
		_loadouts_folder = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower (typeOf player)];
		[player] call compileFinal preprocessFileLineNUmbers _loadouts_folder;
	};
	if (!(isNil "GRLIB_respawn_loadout")) then {
		[player, GRLIB_respawn_loadout] call F_setLoadout;
	};
	[player] call F_filterLoadout;
	// gamelogic globalChat "You pay your Startup Equipments";
	// [player] call F_payLoadout;
};

// first time notice
if (_score == 0) then {	createDialog "liberation_notice" };

private _msg = format ["Welcome <t color='#00008f'>%1</t> !<br/><br/>
Your Rank : <t color='#000080'>%2</t><br/>
Your Score : <t color='#008000'>%3</t><br/>
Your Credit : <t color='#800000'>%4</t>", name player, _rank, _score, _ammo_collected];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

// Recover AI
[player, GRLIB_squad_size_bonus] remoteExec ["recover_ai_remote_call", 2];
