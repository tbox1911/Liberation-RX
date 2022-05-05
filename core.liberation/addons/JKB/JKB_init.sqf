// exit if sog ?
// auto play
// random

// Music list
// manual
JKB_music_list = [
	["Radio", "radio_music"],
	["Fallout", "Fallout"],
	["Defcon", "Defcon"],
	["Wasteland", "Wasteland"],
	["SkyNet ", "SkyNet "]
];

// auto
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
	_title = getText(_x >> "name");
	if (_title == "") then {_title = (configName _x)};
	JKB_music_list pushback [_title, (configName _x)];
};

JKB_current_music = "";
JKB_last_music = 0;

player addAction [localize "STR_JKB_ACTION","addons\JKB\fn_openJukeBox.sqf","",0,false,true,"","!(isNull objectParent player)"];

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- JukeBox Initialized --------";
