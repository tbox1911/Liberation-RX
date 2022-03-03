private ["_src", "_src_ammo", "_dst_id", "_ammo", "_display", "_player_combo", "_ammo_combo" ];

// if (score player <= 20) exitWith { hintSilent "The ATM is closed!\nYour score is too LOW..." };
_src = player;
_src_ammo = _src getVariable ["GREUH_ammo_count",0];
send_ammo = 0;
createDialog "liberation_sendammo_menu";
waitUntil { dialog };

if(!isNull (findDisplay 2337)) then {
	_display = findDisplay 2337;

	ctrlSetText [230, format ["%1: %2", localize "STR_AMMO", _src_ammo]];
	_player_combo = _display displayCtrl 231;
	_ammo_combo = _display displayCtrl 232;
	lbClear _player_combo;
	lbClear _ammo_combo;

	_i = 0;
	{
		_player_combo lbAdd format["%1", name _x];
		_player_combo lbSetData [_i, getPlayerUID _x];
		_i = _i + 1;
	} foreach AllPlayers;

	_i = 0;
	{
		if (_src_ammo >= _x) then {
			_ammo_combo lbAdd str _x;
			_ammo_combo lbSetValue [_i, _x];
			_i = _i + 1;
		};
	} foreach [50, 100, 150, 200, 300, 500, 1000, 2000, 5000];

	_player_combo lbSetCurSel 0;
	_ammo_combo lbSetCurSel 0;

	while { dialog && (alive player) } do {
		if (send_ammo == 1) then {
			_dst_id = _player_combo lbData (lbCurSel _player_combo);
			if (_dst_id != getPlayerUID _src) then {
				_ammo = _ammo_combo lbValue (lbCurSel _ammo_combo);
				[_src, _dst_id, _ammo] remoteExec ["sendammo_remote_call", 2];
			};
			send_ammo = 0;
		};
		sleep 0.1;
	};
};