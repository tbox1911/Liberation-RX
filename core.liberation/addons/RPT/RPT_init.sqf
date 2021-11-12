RPT_color = "#(rgb,1,1,1)color";
RPT_texDir = "addons\RPT\textures\";

fnc_getVIP = compileFinal preprocessFileLineNumbers "addons\RPT\RPT_vip_textures.sqf";

RPT_colorList =[
	["Black", RPT_color + "(0.01,0.01,0.01,1)"], // #(argb,8,8,3)color(0.1,0.1,0.1,0.1)
	["Gray", RPT_color + "(0.15,0.151,0.152,1)"], // #(argb,8,8,3)color(0.5,0.51,0.512,0.3)
	["White", RPT_color + "(0.75,0.75,0.75,1)"], // #(argb,8,8,3)color(1,1,1,0.5)
	["Dark Blue", RPT_color + "(0,0.05,0.15,1)"], // #(argb,8,8,3)color(0,0.3,0.6,0.05)
	["Blue", RPT_color + "(0,0.03,0.5,1)"], // #(argb,8,8,3)color(0,0.2,1,0.75)
	//["Teal", RPT_color + "(0,0.3,0.3,1)"], // #(argb,8,8,3)color(0,1,1,0.15)
	["Green", RPT_color + "(0,0.5,0,1)"], // #(argb,8,8,3)color(0,1,0,0.15)
	["Yellow", RPT_color + "(0.5,0.4,0,1)"], // #(argb,8,8,3)color(1,0.8,0,0.4)
	["Orange", RPT_color + "(0.4,0.09,0,1)"], // #(argb,8,8,3)color(1,0.5,0,0.4)
	["Red", RPT_color + "(0.45,0.005,0,1)"], // #(argb,8,8,3)color(1,0.1,0,0.3)
	["Pink", RPT_color + "(0.5,0.03,0.3,1)"], // #(argb,8,8,3)color(1,0.06,0.6,0.5)
	//["Purple", RPT_color + "(0.1,0,0.3,1)"], // #(argb,8,8,3)color(0.8,0,1,0.1)
	["ARPA Navy", RPT_texDir + "arpa_navy.paa"],
	["ARPA Woodland", RPT_texDir + "arpa_woodland.paa"],
	["Abstract Red", RPT_texDir + "abstraitrouge.paa"],
	["Abstract Green", RPT_texDir + "abstraitvert.paa"],
	["Abstract Modern", RPT_texDir + "abstraitmoderne.paa"],
	["Camo Chris", RPT_texDir + "camo_chris.paa"],
	["Camo Green 1", RPT_texDir + "camovert1.paa"],
	["Camo Green 2", RPT_texDir + "camovert2.paa"],
	["Digital", RPT_texDir + "digi.paa"],
	["Digital Black", RPT_texDir + "digi_black.paa"],
	["Digital Desert", RPT_texDir + "digi_desert.paa"],
	["Digital Desert 2", RPT_texDir + "digi_desert2.paa"],
	["Digital Woodland", RPT_texDir + "digi_wood.paa"],
	["Forest 1", RPT_texDir + "foret1.paa"],
	["Forest 2", RPT_texDir + "raven.paa"],
	["Jungle", RPT_texDir + "jungle.paa"],
	["Panzer Grey", RPT_texDir + "panzergris.paa"],
	["Raven", RPT_texDir + "raven.paa"],
	["Urban", RPT_texDir + "urban.paa"],
	["Woodland", RPT_texDir + "woodland.paa"],
	["Woodland Tiger", RPT_texDir + "woodtiger.paa"]
];

if ( hasInterface ) then {
	waitUntil {!(isNull (findDisplay 46))};
	systemChat "-------- Paint Shop Initialized --------";
};