// JukeBox v1.01
// by pSiko

private["_title","_time","_selected","_classname"];
play_music = 0;

createDialog "JKB_dialog";
waitUntil { dialog };

if(!isNull (findDisplay 2306)) then {
	{
		lbAdd[231,format["%1", _x select 0]];
		lbSetData [231, (lbSize 231)-1, _x select 1];
	} foreach JKB_music_list;

	lbSetCurSel [231, JKB_last_music];

	while { dialog && alive player } do {
		if (play_music == 1) then {
			_selected = lbcursel 231;
			if (_selected == -1) exitWith {};
			_title = lbText [231, _selected];
			_classname = lbData[231, _selected];
			playMusic _classname;
			gamelogic globalChat format ["Playing music: %1", _title];
			JKB_current_music = _title;
			JKB_last_music = _selected;
			play_music = 0;
		};

		if (play_music == 2) then {
			playMusic "";
			JKB_current_music = "";
			play_music = 0;
		};

		_title = "---";
		_time = "0:00";
		if (JKB_current_music != "") then {
			_title = JKB_current_music;
			_time = getMusicPlayedTime
		};
		ctrlSetText [230, format ["%1 - (%2)", _title, _time]];
		sleep 0.5;
	};
	closeDialog 0;
};