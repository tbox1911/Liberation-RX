// JukeBox v1.02
// by pSiKO

private ["_title","_time","_selected","_classname"];
play_music = 0;

createDialog "JKB_dialog";
waitUntil { dialog };

if(!isNull (findDisplay 2306)) then {
	{
		lbAdd[231,format["%1 - (%2)", _x select 0 select [0,60], _x select 2]];
		lbSetData [231, (lbSize 231)-1, _x select 1];
	} foreach JKB_music_list;

	ctrlSetText [232, format ["%1", count JKB_music_list]];
	lbSetCurSel [231, JKB_last_music];
	if (JKB_auto_play) then { (findDisplay 2306 displayCtrl 233) ctrlSetChecked true; };
	if (JKB_random) then { (findDisplay 2306 displayCtrl 234) ctrlSetChecked true; };

	while { dialog && alive player } do {
		if (play_music == 1) then {
			if (JKB_random) then {
				_selected = floor random (count JKB_music_list);
				lbSetCurSel [231, _selected];
			} else {
				_selected = lbcursel 231;
			};
			_title = lbText [231, _selected];
			_classname = lbData[231, _selected];

			[JKB_current_sound] call JKB_stopMusic;
			if (_classname find 'vn_drmm_song_' >= 0) then {
				JKB_current_sound = playSound _classname;
			} else {
				playMusic _classname;
			};
			JKB_current_music = _title;
			JKB_last_music = _selected;
			hintSilent format ["Now Playing:\n%1", JKB_current_music splitString "-" select 0];
			play_music = 0;
		};

		if (play_music == 2) then {
			[JKB_current_sound] call JKB_stopMusic;
		};

		_title = "- - -";
		_time = "0:00";
		if (JKB_current_music != "") then {
			_title = JKB_current_music;
			_time = getMusicPlayedTime
		};
		ctrlSetText [230, format ["%1 - (%2)", _title select [0,26], _time]];
		sleep 0.5;
	};
	closeDialog 0;
};