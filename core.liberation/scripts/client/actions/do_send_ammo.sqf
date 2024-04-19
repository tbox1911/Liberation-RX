private ["_dst_id", "_ammo", "_fuel", "_display", "_player_combo", "_ammo_combo", "_fuel_combo" ];

if ([player] call F_getScore < GRLIB_min_score_player) exitWith { hintSilent "The ATM is closed!\nYour score is too LOW..." };
private _src = player;
private _src_ammo = _src getVariable ["GREUH_ammo_count",0];
private _src_fuel = _src getVariable ["GREUH_fuel_count",0];
send_ammo = 0;
createDialog "liberation_send_resources";
waitUntil { dialog };

if(!isNull (findDisplay 2337)) then {
	_display = findDisplay 2337;

	ctrlSetText [230, format ["%1: %2", localize "STR_AMMO", _src_ammo]];
	ctrlSetText [234, format ["%1: %2", localize "STR_FUEL", _src_fuel]];
	_player_combo = _display displayCtrl 231;
	_ammo_combo = _display displayCtrl 232;
	_fuel_combo = _display displayCtrl 233;
	lbClear _player_combo;
	lbClear _ammo_combo;
	lbClear _fuel_combo;

	_i = 0;
	{
		_player_combo lbAdd format["%1", name _x];
		_player_combo lbSetData [_i, getPlayerUID _x];
		_i = _i + 1;
	} foreach (AllPlayers - (entities "HeadlessClient_F"));

	_i = 0;
	{
		if (_src_ammo >= _x) then {
			_ammo_combo lbAdd str _x;
			_ammo_combo lbSetValue [_i, _x];
			_i = _i + 1;
		};
	} foreach [0, 50, 100, 150, 200, 300, 500, 1000, 2000, 5000];

	_i = 0;
	{
		if (_src_fuel >= _x) then {
			_fuel_combo lbAdd str _x;
			_fuel_combo lbSetValue [_i, _x];
			_i = _i + 1;
		};
	} foreach [0, 10, 20, 30, 50, 100, 150, 200, 300, 500];

	_player_combo lbSetCurSel 0;
	_ammo_combo lbSetCurSel 0;
	_fuel_combo lbSetCurSel 0;

	while { dialog && (alive player) } do {
		if (send_ammo == 1) then {
			_dst_id = _player_combo lbData (lbCurSel _player_combo);
			if (_dst_id != getPlayerUID _src) then {
				_ammo = _ammo_combo lbValue (lbCurSel _ammo_combo);
				_fuel = _fuel_combo lbValue (lbCurSel _fuel_combo);
				[_src, _dst_id, _ammo, _fuel] remoteExec ["sendammo_remote_call", 2];
			};
			send_ammo = 0;
		};
		sleep 0.2;
	};
};