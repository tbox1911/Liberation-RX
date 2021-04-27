//waitUntil { !isNil "GRLIB_permissions" };
private [ "_dialog", "_players_array" ];

_players_array = [];
_dialog = createDialog "liberation_admin";
waitUntil { dialog };
disableSerialization;
_ctrl = (findDisplay 5204) displayCtrl 1607;

if (!isDamageAllowed player) then {
	_ctrl ctrlSetChecked true;
} else {
	_ctrl ctrlSetChecked false;
};
player onMapSingleClick "if (_alt) then {player setPosATL _pos}";

_getBannedUID = {
	params ["_ban_combo"];
	lbClear _ban_combo;
	{
		private _r1 = BTC_logic getVariable [_x, 0];
		if (typeName _r1 == "SCALAR") then {
			if (_r1 > 0) then { _ban_combo lbAdd format["%1", _x] };
		};
	} foreach allVariables BTC_logic;
};

do_unban = 0;
do_score = 0;
do_spawn = 0;
do_ammo = 0;

// Clear listbox
_display = findDisplay 5204;
_ban_combo = _display displayCtrl 1611;
lbClear _ban_combo;
_score_combo = _display displayCtrl 1612;
lbClear _score_combo;
_ammo_combo = _display displayCtrl 1616;
lbClear _ammo_combo;
_build_combo = _display displayCtrl 1614;
lbClear _build_combo;

[_ban_combo] call _getBannedUID;

_i = 0;
{
	_score_combo lbAdd format["%1", name _x];
	_score_combo lbSetData [_i, getPlayerUID _x];
	_ammo_combo lbAdd format["%1", name _x];
	_ammo_combo lbSetData [_i, getPlayerUID _x];
	_i = _i + 1;
} foreach AllPlayers;

_i = 0;
{
	_build_combo lbAdd format["%1", getText(configFile >> "cfgVehicles" >> ( _x select 0 ) >> "DisplayName")];
	_build_combo lbSetData [_i, ( _x select 0 )];
	_i = _i + 1;
} forEach light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + opfor_recyclable;

_ban_combo lbSetCurSel 0;
_score_combo lbSetCurSel 0;
_build_combo lbSetCurSel 0;
_ammo_combo lbSetCurSel 0;

while { dialog && (alive player) } do {
	if (do_unban == 1) then {
		_dst_id = _ban_combo lbText (lbCurSel _ban_combo);
		if (_dst_id != "") then {
			BTC_logic setVariable [_dst_id, 0, true];
			systemchat format ["Unban player UID: %1", _dst_id];
			[_ban_combo] call _getBannedUID;
			sleep 1;
		};
		do_unban = 0;
	};

	if (do_score == 1) then {
		_dst_name = _score_combo lbText (lbCurSel _score_combo);
		_dst_id = _score_combo lbData (lbCurSel _score_combo);
		_player = _dst_id call BIS_fnc_getUnitByUID;
		if (!isNull _player) then {
			[_player, 200] remoteExec ["addScore", 2];
			systemchat format ["Add 200 XP to player: %1.", _dst_name];
			sleep 1;
		};
		do_score = 0;
	};

	if (do_spawn == 1) then {
		_veh_text = _build_combo lbText (lbCurSel _build_combo);
		_veh_class = _build_combo lbData (lbCurSel _build_combo);
		systemchat format ["Build Vehicle: %1", _veh_text];
		buildtype = 9;
		build_unit = [_veh_class,[],1,[],[]];
		dobuild = 1;
		do_spawn = 0;
		closeDialog 0;
	};

	if (do_ammo == 1) then {
		_dst_name = _ammo_combo lbText (lbCurSel _ammo_combo);
		_dst_id = _ammo_combo lbData (lbCurSel _ammo_combo);
		_player = _dst_id call BIS_fnc_getUnitByUID;

		if (!isNull _player) then {
			_tmp = _player getVariable ['GREUH_ammo_count', 0];
			[_player, ['GREUH_ammo_count', _tmp + 300, true]] remoteExec ['setVariable', 2];
			systemchat format ["Add 300 Ammo to player: %1.", _dst_name];
			sleep 1;
		};
		do_ammo = 0;
	};

	sleep 0.5;
};
closeDialog 0;
hintSilent "";