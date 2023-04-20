_color = "#(rgb,1,1,1)color";
_texDir = "addons\RPT\textures\";

colorList =[
	["Black", _color + "(0.01,0.01,0.01,1)"], // #(argb,8,8,3)color(0.1,0.1,0.1,0.1)
	["Gray", _color + "(0.15,0.151,0.152,1)"], // #(argb,8,8,3)color(0.5,0.51,0.512,0.3)
	["White", _color + "(0.75,0.75,0.75,1)"], // #(argb,8,8,3)color(1,1,1,0.5)
	["Dark Blue", _color + "(0,0.05,0.15,1)"], // #(argb,8,8,3)color(0,0.3,0.6,0.05)
	["Blue", _color + "(0,0.03,0.5,1)"], // #(argb,8,8,3)color(0,0.2,1,0.75)
	//["Teal", _color + "(0,0.3,0.3,1)"], // #(argb,8,8,3)color(0,1,1,0.15)
	["Green", _color + "(0,0.5,0,1)"], // #(argb,8,8,3)color(0,1,0,0.15)
	["Yellow", _color + "(0.5,0.4,0,1)"], // #(argb,8,8,3)color(1,0.8,0,0.4)
	["Orange", _color + "(0.4,0.09,0,1)"], // #(argb,8,8,3)color(1,0.5,0,0.4)
	["Red", _color + "(0.45,0.005,0,1)"], // #(argb,8,8,3)color(1,0.1,0,0.3)
	["Pink", _color + "(0.5,0.03,0.3,1)"], // #(argb,8,8,3)color(1,0.06,0.6,0.5)
	//["Purple", _color + "(0.1,0,0.3,1)"], // #(argb,8,8,3)color(0.8,0,1,0.1)
	["ARPA Navy", _texDir + "arpa_navy.paa"],
	["ARPA Woodland", _texDir + "arpa_woodland.paa"],
	["Abstract Green", _texDir + "abstraitvert.paa"],
	["Camo Green 1", _texDir + "camovert1.paa"],
	["Camo Green 2", _texDir + "camovert2.paa"],
	["Digital", _texDir + "digi.paa"],
	["Digital Black", _texDir + "digi_black.paa"],
	["Digital Desert", _texDir + "digi_desert.paa"],
	["Digital Desert 2", _texDir + "digi_desert2.paa"],
	["Digital Woodland", _texDir + "digi_wood.paa"],
	["Forest 1", _texDir + "foret1.paa"],
	["Jungle", _texDir + "jungle.paa"],
	["Panzer Grey", _texDir + "panzergris.paa"],
	["Urban", _texDir + "urban.paa"],
	["Woodland", _texDir + "woodland.paa"],
	["Woodland Tiger", _texDir + "woodtiger.paa"]
];

//pSikO
if (getPlayerUID player in ["76561198085724439"]) then {
	colorList = colorList +	[["pSiKO", _texDir + "hex.paa"]];
};
// Barbare
if (getPlayerUID player in ["76561198085724439", "76561198098904932"]) then {
	colorList = colorList +	[["Barbare", _texDir + "hellokitty.paa"]];
};
// Raven
if (getPlayerUID player in ["76561198085724439", "76561198017505587"]) then {
	colorList = colorList +	[["Raven", _texDir + "raven.paa"]];
};
// Christophe
if (getPlayerUID player in ["76561198085724439", "76561198299706821"]) then {
	colorList = colorList +	[["Christophe", _texDir + "camo_chris.paa"]];
};


//moved to ./shared/ for server use
//RPT_fnc_TextureVehicle = compileFinal preprocessFileLineNumbers "addons\RPT\fn_textureVehicle.sqf";

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Paint Shop Initialized --------";