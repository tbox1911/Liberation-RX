createDialog "liberation_admin";
waitUntil { dialog };
disableSerialization;
do_unban = 0;
do_score = 0;
do_spawn = 0;
do_ammo = 0;
do_change = 0;

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

private _color = getArray (configFile >> "CfgMarkerColors" >> GRLIB_color_friendly >> "color") call BIS_fnc_colorConfigToRGBA;
private _display = findDisplay 5204;

// GodMode ?
if (!isDamageAllowed player) then {
	(_display displayCtrl 1607) ctrlSetChecked true;
} else {
	(_display displayCtrl 1607) ctrlSetChecked false;
};

// Teleport on map
// player onMapSingleClick "if (_alt) then {player setPosATL _pos}";

// Clear listbox
_ban_combo = _display displayCtrl 1611;
lbClear _ban_combo;
_score_combo = _display displayCtrl 1612;
lbClear _score_combo;
_build_combo = _display displayCtrl 1614;
lbClear _build_combo;

(_display displayCtrl 1603) ctrlSetText getMissionPath "res\ui_confirm.paa";
(_display displayCtrl 1603) ctrlSetToolTip "Add 5 XP Score";
(_display displayCtrl 1615) ctrlSetText getMissionPath "res\ui_arsenal.paa";
(_display displayCtrl 1615) ctrlSetToolTip "Add 50 Ammo";
(_display displayCtrl 1616) ctrlSetText getMissionPath "res\ui_rotation.paa";
(_display displayCtrl 1616) ctrlSetToolTip "Rejoin player";

// Build Banned
[_ban_combo] call _getBannedUID;

// Build Players list
_i = 0;
{
	_score_combo lbAdd format["%1", name _x];
	_uid = getPlayerUID _x;
	_score_combo lbSetData [_i, _uid];
	_score_combo lbSetColor [_i, _color];
	_i = _i + 1;
} foreach AllPlayers;

{
	_score_combo lbAdd format["%1", _x select 3];
	_uid = _x  select 0;
	_score_combo lbSetData [_i, _uid];
	_score_combo lbSetColor [_i, _color];
	_i = _i + 1;
} foreach GRLIB_player_scores;

// Build Vehicles list
_i = 0;
{
	_strname = getText(configFile >> "cfgVehicles" >> ( _x select 0 ) >> "DisplayName");
	if (isNil "_strname" ||_strname == "") then {
		diag_log format ["--- LRX Error: Classname not found: %1", ( _x select 0 )];
	} else {
		_build_combo lbAdd format["%1", _strname];
		_build_combo lbSetData [_i, ( _x select 0 )];
		_i = _i + 1;
	};
} forEach light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + opfor_recyclable;

_ban_combo lbSetCurSel 0;
_score_combo lbSetCurSel 0;
_build_combo lbSetCurSel 0;

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
		[_uid, 5] remoteExec ["F_addPlayerScore", 2];
		_msg = format ["Add 5 XP to player: %1.", _name];
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
		build_unit = [_veh_class,[],1,[],[]];
		dobuild = 1;
		closeDialog 0;
	};

	if (do_ammo == 1) then {
		do_ammo = 0;
		_name = _score_combo lbText (lbCurSel _score_combo);
		_uid = _score_combo lbData (lbCurSel _score_combo);
		[_uid, 50] remoteExec ["F_addPlayerAmmo", 2];
		_msg = format ["Add 50 Ammo to player: %1.", _name];
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
			player setPos (getPos _player);
			closeDialog 0;
		} else {
			hint "Player must be online!";
		};
	};

	sleep 0.5;
};
closeDialog 0;
hintSilent "";