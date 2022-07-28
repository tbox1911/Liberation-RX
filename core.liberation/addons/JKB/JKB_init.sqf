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
JKB_last_music = 0;
JKB_auto_play = false;
JKB_random = false;

// Action and music events
player addAction [localize "STR_JKB_ACTION","addons\JKB\fn_openJukeBox.sqf","",0,false,true,"","!(isNull objectParent player)"];

addMusicEventHandler ["MusicStart", {
	{ if (_x select 1 == _this select 0) exitWith {hintSilent format ["Now Playing:\n%1", _x select 0]} } foreach JKB_music_list;
}];

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
		playMusic _classname;	
	} else {
		JKB_current_music = "";
	};
}];

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Juke Box Initialized --------";
