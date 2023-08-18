// the LRX Admin Tool by pSiKO
//
// godmode / teleport
// import / export save game
// create object
// manage player ban/score/ammo

createDialog "liberation_admin";
waitUntil { dialog };
disableSerialization;
if (isNil "do_admin" || isDamageAllowed player) then { do_admin = 0 };
if (isNil "last_build") then { last_build = 0 };
if (isNil "do_teleport") then { do_teleport = 0 };
do_unban = 0;
do_score = 0;
do_spawn = 0;
do_ammo = 0;
do_change = 0;
do_export = 0;
do_import = 0;
do_kick = 0;
do_ban = 0;

private _msg = "";
private _getBannedUID = {
	params ["_ban_combo"];
	lbClear _ban_combo;
	{
		private _r1 = BTC_logic getVariable [_x, 0];
		if (typeName _r1 == "SCALAR") then {
			if (_r1 > 0) then { _ban_combo lbAdd format["%1", _x] };
		};
	} foreach allVariables BTC_logic;
};

private _addBuild = {
	params ["_i", "_list", "_color"];
	{
		_strname = [(_x select 0)] call F_getLRXName;
		if (_strname == "") then {
			diag_log format ["--- LRX Error: Classname not found: %1", (_x select 0)];
		} else {
			_build_combo lbAdd format["%1", _strname];
			_build_combo lbSetData [_i, ( _x select 0 )];
			_build_combo lbSetColor [_i, _color ];
			_i = _i + 1;
		};
	} forEach _list;
	_i;
};

private _color = getArray (configFile >> "CfgMarkerColors" >> GRLIB_color_friendly >> "color") call BIS_fnc_colorConfigToRGBA;
private _display = findDisplay 5204;

// GodMode ?
if (do_admin == 1) then { (_display displayCtrl 1607) ctrlSetChecked true; };

// Teleport ?
if (do_teleport == 1) then { (_display displayCtrl 1620) ctrlSetChecked true; };

// Clear listbox
_ban_combo = _display displayCtrl 1611;
lbClear _ban_combo;
_score_combo = _display displayCtrl 1612;
lbClear _score_combo;
_build_combo = _display displayCtrl 1618;
lbClear _build_combo;

// Input for XP / Ammo
_ammount_edit = _display displayCtrl 1619;
_ammount_edit ctrlSetText "50";

// Clear input
private _input_controls = [521,522,523,524,525,526,527];
{ ctrlShow [_x, false] } foreach _input_controls;

// Clear output
private _output_controls = [531,532,533,534,535,536];
{ ctrlShow [_x, false] } foreach _output_controls;

// Action buttons
private _button_controls = [1600,1601,1602,1603,1604,1609,1610,1611,1612,1613,1614,1615,1616,1617,1618,1619];
private _disabled_controls = [1606,1607,1608,1609,1610,1613,1614,1620];

(_display displayCtrl 1603) ctrlSetText getMissionPath "res\ui_confirm.paa";
(_display displayCtrl 1603) ctrlSetToolTip "Add XP Score";
(_display displayCtrl 1615) ctrlSetText getMissionPath "res\ui_arsenal.paa";
(_display displayCtrl 1615) ctrlSetToolTip "Add Ammo credit";
(_display displayCtrl 1616) ctrlSetText getMissionPath "res\ui_rotation.paa";
(_display displayCtrl 1616) ctrlSetToolTip "Rejoin player";
(_display displayCtrl 1619) ctrlSetToolTip "Amount of Ammo or Experience Points to add";
(_display displayCtrl 1621) ctrlSetText getMissionPath "res\ui_redeploy.paa";
(_display displayCtrl 1621) ctrlSetToolTip "Kick player!";
(_display displayCtrl 1622) ctrlSetText getMissionPath "res\skull.paa";
(_display displayCtrl 1622) ctrlSetToolTip "BAN player!";

// Build Banned
[_ban_combo] call _getBannedUID;

// Build Players list
private _i = 0;
private _list = [];
{
	_uid = getPlayerUID _x;
	_list pushBack _uid;
	_score_combo lbAdd format["%1", name _x];
	_score_combo lbSetData [_i, _uid];
	_score_combo lbSetColor [_i, _color];
	_i = _i + 1;
} foreach (AllPlayers - (entities "HeadlessClient_F"));

{
	_uid = _x  select 0;
	if !(_uid in _list) then {
		_score_combo lbAdd format["%1", _x select 4];
		_score_combo lbSetData [_i, _uid];
		_score_combo lbSetColor [_i, _color];
		_i = _i + 1;
	};
} foreach GRLIB_player_scores;

// Build Vehicles list
private _indx = 0;
_indx = [_indx, light_vehicles + heavy_vehicles + air_vehicles, [0,0.3,0.7,1]] call _addBuild;
_indx = [_indx, static_vehicles, [0,0.8,0,1]] call _addBuild;
_indx = [_indx, support_vehicles, [0.5,0.6,0.4,1]] call _addBuild;
_indx = [_indx, opfor_recyclable, [0.8,0,0,1]] call _addBuild;

_ban_combo lbSetCurSel 0;
_score_combo lbSetCurSel 0;
_build_combo lbSetCurSel last_build;

// Limit Moderators Menu
if (getPlayerUID player in GRLIB_whitelisted_moderators) then {
	{
		ctrlEnable  [_x, false];
		ctrlShow [_x, false];
	} forEach _disabled_controls;
	_button_controls = _disabled_controls;
};

while { alive player && dialog } do {
	if (do_unban == 1) then {
		do_unban = 0;
		_dst_id = _ban_combo lbText (lbCurSel _ban_combo);
		if (_dst_id != "") then {
			BTC_logic setVariable [_dst_id, 0, true];
			_msg = format ["Unban player UID: %1", _dst_id];
			hint _msg;
			systemchat _msg;
			lbClear _ban_combo;
			[_ban_combo] call _getBannedUID;
		};
	};

	if (do_score == 1) then {
		do_score = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		_amount = parseNumber (ctrlText _ammount_edit);
		[_uid, _amount] remoteExec ["F_addPlayerScore", 2];
		_msg = format ["Add %1 XP to player: %2.", _amount, _name];
		hint _msg;
		systemchat _msg;
		sleep 1;
	};

	if (do_spawn == 1) then {
		do_spawn = 0;
		_veh_text = _build_combo lbText (lbCurSel _build_combo);
		_veh_class = _build_combo lbData (lbCurSel _build_combo);
		_msg = format ["Build Vehicle: %1", _veh_text];
		hint _msg;
		systemchat _msg;
		buildtype = 9;
		build_unit = [_veh_class,[],1,[],[],[]];
		dobuild = 1;
		last_build = (lbCurSel _build_combo);
		closeDialog 0;
	};

	if (do_ammo == 1) then {
		do_ammo = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		_amount = parseNumber (ctrlText _ammount_edit);
		[_uid, _amount] remoteExec ["F_addPlayerAmmo", 2];
		_msg = format ["Add %1 Ammo to player: %2.", _amount, _name];
		hint _msg;
		systemchat _msg;
		sleep 1;
	};

	if (do_change == 1) then {
		do_change = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		_player = _uid call BIS_fnc_getUnitByUID;
		if (!isNull _player) then {
			hint format ["Teleport to player: %1.", _name];
			player setPos (_player getRelPos [3, 0]);
			closeDialog 0;
		} else {
			hint "Player must be online!";
		};
	};

	if (do_export == 1) then {
		do_export = 0;
		if (isServer) then {
			[true] call save_game_mp;
			copyToClipboard str (profileNamespace getVariable [GRLIB_save_key, []]);
			_msg = format ["Savegame %1 Exported to clipboard.", GRLIB_save_key];
			hint _msg;
		} else {
			{ ctrlEnable  [_x, false] } foreach _button_controls;
			{ ctrlShow [_x, true] } foreach _output_controls;
			output_save = [];
			[player, {
				[true] call save_game_mp;
				[missionNamespace, ["output_save", (profileNamespace getVariable GRLIB_save_key)]] remoteExec ["setVariable", owner _this];
				["Copy the Savegame from Text Field."] remoteExec ["hint", owner _this];
			}] remoteExec ["bis_fnc_call", 2];

			waitUntil {uiSleep 0.3; ((count output_save > 0) || !(dialog) || !(alive player))};
			ctrlSetText [ 536, str output_save ];
			waitUntil {uiSleep 0.3; (!(dialog) || !(alive player)) };

			{ ctrlShow [_x, false] } foreach _output_controls;
			{ ctrlEnable  [_x, true] } foreach _button_controls;
		};
	};

	if (do_import == 1) then {
		do_import = 0;
		{ ctrlEnable  [_x, false] } foreach _button_controls;
		{ ctrlShow [_x, true] } foreach _input_controls;	
		input_save = "";
		waitUntil {uiSleep 0.3; ((input_save != "") || !(dialog) || !(alive player))};
		if ( input_save select [0,1] == "[" && input_save select [(count input_save)-1,(count input_save)] == "]") then {
			closeDialog 0;
			titleText ["Restarting now..." ,"BLACK FADED", 100];
			disableUserInput true;
			[(parseSimpleArray input_save), {
				GRLIB_server_stopped = true;
				profileNamespace setVariable [GRLIB_save_key, _this];
				saveProfileNamespace;
				["END"] remoteExec ["endMission", 0];
			}] remoteExec ["bis_fnc_call", 2];
			disableUserInput false;
		} else { systemchat "Error: Invalid data!" };
		{ ctrlShow [_x, false] } foreach _input_controls;
		{ ctrlEnable  [_x, true] } foreach _button_controls;
	};
	if (do_kick == 1) then {
		do_kick = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		[_uid, {
			_player = _this call BIS_fnc_getUnitByUID;
			if (isPlayer _player) then {
				["LOSER"] remoteExec ["endMission", owner _player];
				_msg = format ["Admin kick player %1.", name _player];				
				[_msg] remoteExec ["systemchat", -2];
				serverCommand format ["#kick %1", name _player];
			};
		}] remoteExec ["bis_fnc_call", 2];
		sleep 1;
	};
	if (do_ban == 1) then {
		do_ban = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		[_uid, {
			_player = _this call BIS_fnc_getUnitByUID;
			if (isPlayer _player) then {
				BTC_logic setVariable [_this, 99, true];
				[_player] remoteExec ["LRX_tk_actions", owner _player];
				_msg = format ["Admin BAN player %1.", name _player];
				[_msg] remoteExec ["systemchat", -2];
			};
		}] remoteExec ["bis_fnc_call", 2];
		sleep 1;
	};		
	sleep 0.5;
};
closeDialog 0;
hintSilent "";
