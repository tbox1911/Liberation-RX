// the LRX Admin Tool by pSiKO
//
// godmode / teleport
// import / export save game
// create object
// manage player ban/score/ammo

createDialog "liberation_admin";
waitUntil { dialog };

if (isNil "do_admin" || isDamageAllowed player) then { do_admin = 0 };
if (isNil "last_build") then { last_build = 0 };
if (isNil "do_teleport") then { do_teleport = 0 };

do_unban = 0;
do_score = 0;
do_spawn = 0;
do_ammo = 0;
do_fuel = 0;
do_rejoin = 0;
do_export = 0;
do_import = 0;
do_kick = 0;
do_ban = 0;
do_zeus = 0;
do_capture = 0;
do_save = 0;
do_skip = 0;
do_unlock = 0;
do_delete = 0;

// Watchdog
if (isNil "lrx_admin_watchdog") then {
	lrx_admin_watchdog = true;
	[] spawn {
		while {true} do {
			if (do_admin == 0 && !(isDamageAllowed player)) then { player allowDamage true };
			if (do_admin == 1 && (isDamageAllowed player)) then { player allowDamage false };
			sleep 0.5;
		};
	};
};

private _msg = "";
private _admin_msg = "";
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
if (do_admin == 1) then { (_display displayCtrl 1607) ctrlSetChecked true };

// Teleport ?
if (do_teleport == 1) then { (_display displayCtrl 1620) ctrlSetChecked true };

// Zeus mode ?
if (!isNil "GRLIB_active_commander") then {
	if (GRLIB_active_commander in (call BIS_fnc_listCuratorPlayers)) then { ctrlEnable [1625, false] };
};

// Capture Sector ?
private _sector = [GRLIB_sector_size, player] call F_getNearestSector;
if (_sector == "" || _sector in blufor_sectors) then { ctrlEnable [1627, false] };

// GC
if (GRLIB_force_cleanup) then { ctrlEnable [1629, false] };

// Clear listbox
private _ban_combo = _display displayCtrl 1611;
lbClear _ban_combo;
private _score_combo = _display displayCtrl 1612;
lbClear _score_combo;
private _build_combo = _display displayCtrl 1618;
lbClear _build_combo;

// Input for XP / Ammo
private _ammount_edit = _display displayCtrl 1619;
_ammount_edit ctrlSetText "50";

// Clear input
private _input_controls = [521,522,523,524,525,526,527];
{ ctrlShow [_x, false] } foreach _input_controls;

// Clear output
private _output_controls = [531,532,533,534,535,536];
{ ctrlShow [_x, false] } foreach _output_controls;

// Action buttons
private _button_controls = [1600,1601,1602,1603,1604,1609,1610,1611,1612,1613,1614,1615,1616,1617,1618,1619,1623,1624,1625,1626];
private _disabled_controls = [1606,1607,1608,1609,1610,1613,1614,1620,1626];

(_display displayCtrl 1603) ctrlSetText getMissionPath "res\ui_confirm.paa";
(_display displayCtrl 1603) ctrlSetToolTip localize "STR_ADD_XP_TOOLTIP";
(_display displayCtrl 1615) ctrlSetText getMissionPath "res\ui_arsenal.paa";
(_display displayCtrl 1615) ctrlSetToolTip localize "STR_ADD_AMMO_TOOLTIP";
(_display displayCtrl 1624) ctrlSetText getMissionPath "res\ui_wfuel.paa";
(_display displayCtrl 1624) ctrlSetToolTip localize "STR_ADD_FUEL_TOOLTIP";
(_display displayCtrl 1616) ctrlSetText getMissionPath "res\ui_rotation.paa";
(_display displayCtrl 1616) ctrlSetToolTip localize "STR_REJOIN_PLAYER_TOOLTIP";
(_display displayCtrl 1612) ctrlSetToolTip localize "STR_SELECTED_PLAYER_TOOLTIP";
(_display displayCtrl 1619) ctrlSetToolTip localize "STR_ADD_AMOUNT_TOOLTIP";
(_display displayCtrl 1621) ctrlSetText getMissionPath "res\ui_redeploy.paa";
(_display displayCtrl 1621) ctrlSetToolTip localize "STR_KICK_PLAYER_TOOLTIP";
(_display displayCtrl 1622) ctrlSetText getMissionPath "res\skull.paa";
(_display displayCtrl 1622) ctrlSetToolTip localize "STR_BAN_PLAYER_TOOLTIP";
(_display displayCtrl 1610) ctrlSetToolTip localize "STR_DELETE_OBJECT_TOOLTIP";
(_display displayCtrl 1626) ctrlSetToolTip localize "STR_CALL_MAGIC_MOWER_TOOLTIP";
(_display displayCtrl 1628) ctrlSetToolTip localize "STR_FORCE_SAVE_TOOLTIP";
(_display displayCtrl 1629) ctrlSetToolTip localize "STR_FORCE_CLEANUP_TOOLTIP";

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
	_uid = _x select 0;
	if !(_uid in _list) then {
		_score_combo lbAdd format["%1", _x select 5];
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
if (PAR_Grp_ID in GRLIB_whitelisted_moderators) then {
	{
		ctrlEnable [_x, false];
		ctrlShow [_x, false];
	} forEach _disabled_controls;
	_button_controls = _disabled_controls;
};

while { alive player && dialog } do {
	_msg = "";
	_admin_msg = "";

	if (do_spawn >= 1) then {
		private ["_veh_text", "_veh_class"];
		if (do_spawn == 100) then {
			_veh_text = _build_combo lbText (lbCurSel _build_combo);
			_veh_class = _build_combo lbData (lbCurSel _build_combo);
		} else {
			switch (do_spawn) do {
				case 1: {
					_veh_text = "Arsenal";
					_veh_class = Arsenal_typename;
				};
				case 2: {
					_veh_text = "AmmoBox";
					_veh_class = ammobox_b_typename;
				};
				case 3: {
					_veh_text = "Mobile Respawn";
					_veh_class = mobile_respawn;
				};
				default { playSound3D ["a3\sounds_f\air\Heli_Light_01\warning.wss", player] };
			};
		};
		do_spawn = 0;
		if (isNil "_veh_class") exitWith {};
		_admin_msg = format ["Admin (%1) build vehicle %2 (%3)", name player, _veh_text, _veh_class];
		buildtype = GRLIB_BuildTypeDirect;
		build_unit = [_veh_class,[],1,[],[],[],[]];
		dobuild = 1;
		last_build = (lbCurSel _build_combo);
		closeDialog 0;
	};

	if (do_score == 1) then {
		do_score = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		_amount = parseNumber (ctrlText _ammount_edit);
		[_uid, _amount] remoteExec ["F_addPlayerScore", 2];
		_msg = format ["Add %1 XP to player: %2.", _amount, _name];
		_admin_msg = format ["Admin (%1) add %2 XP to player %3", name player, _amount, _name];
	};

	if (do_ammo == 1) then {
		do_ammo = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		_amount = parseNumber (ctrlText _ammount_edit);
		[_uid, _amount] remoteExec ["F_addPlayerAmmo", 2];
		_msg = format ["Add %1 Ammo to player: %2.", _amount, _name];
		_admin_msg = format ["Admin (%1) add %2 Ammo to player %3", name player, _amount, _name];
	};

	if (do_fuel == 1) then {
		do_fuel = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		_amount = parseNumber (ctrlText _ammount_edit);
		_player = _uid call BIS_fnc_getUnitByUID;
		[_player, 0, _amount] remoteExec ["ammo_add_remote_call", 2];
		_msg = format ["Add %1 Fuel to player: %2.", _amount, _name];
		_admin_msg = format ["Admin (%1) add %2 Fuel to player %3", name player, _amount, _name];
	};

	if (do_rejoin == 1) then {
		do_rejoin = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		_player = _uid call BIS_fnc_getUnitByUID;
		if (!isNull _player) then {
			_msg = format ["Admin Teleport near player %1.", _name];
			_pos = getPos _player;
			if (surfaceIsWater _pos) then {
				player setPosASL _pos;
			} else {
				player setPosATL (_player getRelPos [3, 0]);
			};
			closeDialog 0;
		} else {
			hintSilent "Player must be online!";
		};
	};

	if (do_export == 1) then {
		do_export = 0;
		if (isServer) then {
			[] call save_game_mp;
			copyToClipboard str (profileNamespace getVariable [GRLIB_save_key, []]);
			_msg = format ["Savegame %1 Exported to clipboard.", GRLIB_save_key];
		} else {
			{ ctrlEnable [_x, false] } foreach _button_controls;
			{ ctrlShow [_x, true] } foreach _output_controls;
			output_save = [];
			[player, {
				[] call save_game_mp;
				[missionNamespace, ["output_save", (profileNamespace getVariable GRLIB_save_key)]] remoteExec ["setVariable", owner _this];
				["Copy the save game from the text field."] remoteExec ["hintSilent", owner _this];
			}] remoteExec ["bis_fnc_call", 2];
			waitUntil {uiSleep 0.3; ((count output_save > 0) || !(dialog) || !(alive player))};
			ctrlSetText [ 536, str output_save ];
			waitUntil {uiSleep 0.3; (!(dialog) || !(alive player)) };
			{ ctrlShow [_x, false] } foreach _output_controls;
			{ ctrlEnable [_x, true] } foreach _button_controls;
			_admin_msg = format ["Admin (%1) export the save game (%2)", name player, GRLIB_save_key];
		};
	};

	if (do_import == 1) then {
		do_import = 0;
		{ ctrlEnable [_x, false] } foreach _button_controls;
		{ ctrlShow [_x, true] } foreach _input_controls;
		input_save = "";
		waitUntil {uiSleep 0.3; ((input_save != "") || !(dialog) || !(alive player))};
		if ( input_save select [0,1] == "[" && input_save select [(count input_save)-1,(count input_save)] == "]") then {
			_admin_msg = format [localize "STR_ADMIN_IMPORT_SAVE", name player, GRLIB_save_key];
			[_admin_msg] remoteExec ["diag_log", 2];
			closeDialog 0;
			titleText [localize "STR_RESTARTING_NOW", "BLACK FADED", 100];
			disableUserInput true;
			[(parseSimpleArray input_save), {
				GRLIB_server_stopped = true;
				profileNamespace setVariable [GRLIB_save_key, _this];
				saveProfileNamespace;
				["END"] remoteExec ["endMission", 0];
			}] remoteExec ["bis_fnc_call", 2];
			disableUserInput false;
		} else { _msg = localize "STR_ERROR_INVALID_DATA";};
		{ ctrlShow [_x, false] } foreach _input_controls;
		{ ctrlEnable [_x, true] } foreach _button_controls;
	};

	if (do_kick == 1) then {
		do_kick = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		[_uid, {
			private _kicked = _this call BIS_fnc_getUnitByUID;
			if (isPlayer _kicked) then {
				private _name = name _kicked;
				["LOSER"] remoteExec ["endMission", owner _kicked];
				serverCommand format ["#kick %1", _name];
				private _msg = format [localize "STR_ADMIN_KICK_PLAYER", _name];
				[gamelogic, _msg] remoteExec ["globalChat", -2];
			};
		}] remoteExec ["bis_fnc_call", 2];
		_admin_msg = format ["Admin (%1) kick player %2", name player, _name];
	};

	if (do_ban == 1) then {
		do_ban = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		[_uid, {
			private _player = _this call BIS_fnc_getUnitByUID;
			if (isPlayer _player) then {
				BTC_logic setVariable [_this, 99, true];
				[_player] remoteExec ["LRX_tk_actions", owner _player];
				private _msg = format [localize "STR_ADMIN_BAN_PLAYER", name _player];
				[gamelogic, _msg] remoteExec ["globalChat", -2];
			};
		}] remoteExec ["bis_fnc_call", 2];
		_admin_msg = format [localize "STR_ADMIN_BAN_PLAYER_BY", name player, _name];
	};

	if (do_unban == 1) then {
		do_unban = 0;
		_dst_id = _ban_combo lbText (lbCurSel _ban_combo);
		if (_dst_id != "") then {
			BTC_logic setVariable [_dst_id, 0, true];
			_msg = format [localize "STR_UNBAN_PLAYER_UID", _dst_id];
			_admin_msg = format [localize "STR_ADMIN_UNBAN_PLAYER", name player, _dst_id];
			lbClear _ban_combo;
			[_ban_combo] call _getBannedUID;
		};
	};

	if (do_zeus == 1) then {
		do_zeus = 0;
		GRLIB_active_commander = player;
		publicVariable 'GRLIB_active_commander';
		_msg = localize "STR_YOU_ARE_ZEUS_NOW";
		_admin_msg = format [localize "STR_ADMIN_BECOME_ZEUS", name player];
		ctrlEnable [1625, false];
	};

	if (do_capture == 1) then {
		do_capture = 0;
		[_sector, {
			blufor_sectors pushBackUnique _this;
			opfor_sectors = (sectors_allSectors - blufor_sectors);
			publicVariable "blufor_sectors";
		}] remoteExec ["bis_fnc_call", 2];
		_msg = format [localize "STR_SECTOR_FORCEFULLY_CAPTURED", markerText _sector];
		_admin_msg = format [localize "STR_ADMIN_FORCE_CAPTURE_SECTOR", name player, markerText _sector];
		closeDialog 0;
	};

	if (do_save == 1) then {
		do_save = 0;
		[{
			{ [_x, getPlayerUID _x] call save_context } foreach (AllPlayers - (entities "HeadlessClient_F"));
			[] call save_game_mp;
		}] remoteExec ["bis_fnc_call", 2];
		_msg = format [localize "STR_GAME_FORCEFULLY_SAVED", GRLIB_save_key];
		_admin_msg = format [localize "STR_ADMIN_FORCE_SAVE_GAME", name player, GRLIB_save_key];
		closeDialog 0;
	};

	if (do_skip == 1) then {
		do_skip = 0;
		10 remoteExec ['SkipTime', 2];
		_msg = localize "STR_TIME_SKIPPED_MESSAGE";
		_admin_msg = format [localize "STR_ADMIN_SKIP_TIME", name player];
	};

	if (do_unlock == 1) then {
		do_unlock = 0;
		_vehicle = cursorobject;
		if (isNull _vehicle) exitWith {};
		_vehicle_name = [typeOf _vehicle] call F_getLRXName;
		_vehicle setvariable ['R3F_LOG_disabled', false, true];
		_vehicle setvariable ['GRLIB_vehicle_owner', '', true];
		_msg = format [localize "STR_VEHICLE_UNLOCKED_BY_ADMIN", _vehicle_name];
		_admin_msg = format [localize "STR_ADMIN_UNLOCK_VEHICLE", name player, _vehicle_name, typeOf _vehicle];
	};

	if (do_delete == 1) then {
		do_delete = 0;
		_vehicle = cursorobject;
		if (isNull _vehicle) exitWith {};
		_vehicle_name = [typeOf _vehicle] call F_getLRXName;
		_vehicle setDamage [1, false];
		deleteVehicle _vehicle;
		_msg = format [localize "STR_VEHICLE_DELETED_BY_ADMIN", _vehicle_name];
		_admin_msg = format [localize "STR_ADMIN_DELETE_VEHICLE", name player, _vehicle_name, typeOf _vehicle];
		closeDialog 0;
	};

	if (_admin_msg != "") then { [_admin_msg] remoteExec ["diag_log", 2] };
	if (_msg != "") then { hintSilent _msg;	systemchat _msg };
	if (GRLIB_force_cleanup) then { ctrlEnable [1629, false] } else { ctrlEnable [1629, true] };
	if (!isNull cursorObject) then {
		private _vehicle = cursorObject;
		private _owner = [_vehicle] call F_getVehicleOwner;
		private _fuel = round (fuel _vehicle * 100);
		private _ammo = round (([_vehicle] call F_getVehicleAmmoDef) * 100);
		private _damage = round (([_vehicle] call F_getVehicleDamage) * 100);
		private _cargo = [_vehicle] call R3F_LOG_FNCT_calculer_chargement_vehicule;
		hintSilent format [localize "STR_PAR_VEHICLE_STATUS_HINT", _owner, _damage, _fuel, _ammo, _cargo select 0, _cargo select 1];
	} else {
		hintSilent "";
	};
	sleep 0.5;
};
closeDialog 0;

sleep 1;
hintSilent "";
