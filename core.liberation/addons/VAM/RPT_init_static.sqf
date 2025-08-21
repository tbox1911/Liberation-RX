// Vehicle Paint v1.10 merged with VAM
// by pSiKO - server side

RPT_color = "#(rgb,1,1,1)color";
RPT_texDir = "addons\VAM\textures\";

RPT_colorList = [
	["Black", ".#(0.01,0.01,0.01,1)"], // #(argb,8,8,3)color(0.1,0.1,0.1,0.1)
	["Gray", ".#(0.15,0.151,0.152,1)"], // #(argb,8,8,3)color(0.5,0.51,0.512,0.3)
	["White", ".#(0.75,0.75,0.75,1)"], // #(argb,8,8,3)color(1,1,1,0.5)
	["Dark Blue", ".#(0,0.05,0.15,1)"], // #(argb,8,8,3)color(0,0.3,0.6,0.05)
	["Blue", ".#(0,0.03,0.5,1)"], // #(argb,8,8,3)color(0,0.2,1,0.75)
	["Teal", ".#(0,0.3,0.3,1)"], // #(argb,8,8,3)color(0,1,1,0.15)
	["Green", ".#(0,0.5,0,1)"], // #(argb,8,8,3)color(0,1,0,0.15)
	["Yellow", ".#(0.5,0.4,0,1)"], // #(argb,8,8,3)color(1,0.8,0,0.4)
	["Orange", ".#(0.4,0.09,0,1)"], // #(argb,8,8,3)color(1,0.5,0,0.4)
	["Red", ".#(0.45,0.005,0,1)"], // #(argb,8,8,3)color(1,0.1,0,0.3)
	["Pink", ".#(0.5,0.03,0.3,1)"], // #(argb,8,8,3)color(1,0.06,0.6,0.5)
	["Purple", ".#(0.1,0,0.3,1)"], // #(argb,8,8,3)color(0.8,0,1,0.1)
	["ARPA Navy", "./arpa_navy.paa"],
	["ARPA Woodland", "./arpa_woodland.paa"],
	["Abstract Red", "./abstraitrouge.paa"],
	["Abstract Green", "./abstraitvert.paa"],
	["Abstract Modern", "./abstraitmoderne.paa"],
	["Camo Green 1", "./camovert1.paa"],
	["Camo Green 2", "./camovert2.paa"],
	["Digital", "./digi.paa"],
	["Digital Black", "./digi_black.paa"],
	["Digital Desert", "./digi_desert.paa"],
	["Digital Desert 2", "./digi_desert2.paa"],
	["Digital Woodland", "./digi_wood.paa"],
	["Forest 1", "./foret1.paa"],
	["Forest 2", "./raven.paa"],
	["Jungle", "./jungle.paa"],
	["Panzer Grey", "./panzergris.paa"],
	["Urban", "./urban.paa"],
	["Woodland", "./woodland.paa"],
	["Woodland Tiger", "./woodtiger.paa"]
];

private ["_name", "_texture"];
if (GRLIB_LRX_Texture_enabled) then {
	(
		"true"
		configClasses (configfile >> "LRX_TextureSources")
	) apply {
		_name = getText (_x >> "name");
		if (_name == "") then {_name = (configName _x)};
		_texture = getText (_x >> "texture");
		RPT_colorList pushback [_name, _texture];
	};
};

[] call compileFinal preprocessFileLineNumbers "addons\VAM\RPT_vip_textures.sqf";
