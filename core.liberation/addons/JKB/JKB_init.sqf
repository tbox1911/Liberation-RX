// JukeBox v1.02
// by pSiKO

// Music list
JKB_music_list = [
	["Radio", "radio_music",0],
	["Fallout", "Fallout",0],
	["Defcon", "Defcon",0],
	["Wasteland", "Wasteland",0],
	["SkyNet ", "SkyNet",0]
];

JKB_music_blacklist = [
	"EventTrack01_F_Curator",
	"EventTrack02_F_Curator",
	"EventTrack03_F_Curator"
];

JKB_stopMusic = {
	params ["_sound"];
	if (!isNull _sound) then {
		deleteVehicle _sound;
		JKB_current_sound = objNull;
	} else { playMusic "" };
	JKB_current_music = "";
	play_music = 0;
	sleep 0.5;
};

// add SoG Music
(
	"
	( (configName _x) find 'vn_drmm_song_os_' >= 0) &&
	!((configName _x) in JKB_music_blacklist)
	"
	configClasses (configfile >> "CfgSounds")
) apply {
	private _title = getText (_x >> "name");
	if (_title == "") then {_title = (configName _x)};
	JKB_music_list pushback [_title, (configName _x), getNumber (_x >> "duration")];
};

// add Arma3 Music
(
	"
	( (configName _x) find 'Music' >= 0  || (configName _x) find 'Track' >= 0 ) &&
	!((configName _x) in JKB_music_blacklist)
	"
	configClasses (configfile >> "CfgMusic")
) apply {
	private _title = getText (_x >> "name");
	if (_title == "") then {_title = (configName _x)};
	JKB_music_list pushback [_title, (configName _x), getNumber (_x >> "duration")];
};

// Music player controls
JKB_current_music = "";
JKB_current_sound = objNull;
JKB_last_music = 0;
JKB_auto_play = false;
JKB_random = false;

// player Action
// player addAction [localize "STR_JKB_ACTION","addons\JKB\fn_openJukeBox.sqf","",0,false,true,"","!(isNull objectParent player)"];

addMusicEventHandler ["MusicStop", {
	if (JKB_auto_play) then {
		private _classname = "";
		private _title = "";
		if (JKB_random) then {
			JKB_last_music = floor random (count JKB_music_list);
		} else {
			if (JKB_last_music + 1 >= count JKB_music_list) then { JKB_last_music = -1 };
			JKB_last_music = JKB_last_music + 1;
		};
		_title = JKB_music_list select JKB_last_music select 0;
		_classname = JKB_music_list select JKB_last_music select 1;
		JKB_current_music = _title;
		if (_classname find 'vn_drmm_song_' >= 0) then {
			JKB_current_sound = playSound _classname;
		} else {
			playMusic _classname;
		};
		hintSilent format ["Now Playing:\n%1", JKB_current_music splitString "-" select 0];
	} else {
		[JKB_current_sound] spawn JKB_stopMusic;
	};
}];

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Juke Box Initialized --------";
