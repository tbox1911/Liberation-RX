// Vehicle Paint v1.10 merged with VAM
// by pSiKO

VAM_arsenal_enable_weapons = true;
VAM_arsenal_enable_magazines = true;
VAM_arsenal_enable_uniforms = true;
VAM_arsenal_enable_backpacks = false;
VAM_arsenal_enable_glasses = false;

RPT_color = "#(rgb,1,1,1)color";
RPT_texDir = "addons\VAM\textures\";

RPT_colorList = [
	["Black", RPT_color + "(0.01,0.01,0.01,1)"], // #(argb,8,8,3)color(0.1,0.1,0.1,0.1)
	["Gray", RPT_color + "(0.15,0.151,0.152,1)"], // #(argb,8,8,3)color(0.5,0.51,0.512,0.3)
	["White", RPT_color + "(0.75,0.75,0.75,1)"], // #(argb,8,8,3)color(1,1,1,0.5)
	["Dark Blue", RPT_color + "(0,0.05,0.15,1)"], // #(argb,8,8,3)color(0,0.3,0.6,0.05)
	["Blue", RPT_color + "(0,0.03,0.5,1)"], // #(argb,8,8,3)color(0,0.2,1,0.75)
	["Teal", RPT_color + "(0,0.3,0.3,1)"], // #(argb,8,8,3)color(0,1,1,0.15)
	["Green", RPT_color + "(0,0.5,0,1)"], // #(argb,8,8,3)color(0,1,0,0.15)
	["Yellow", RPT_color + "(0.5,0.4,0,1)"], // #(argb,8,8,3)color(1,0.8,0,0.4)
	["Orange", RPT_color + "(0.4,0.09,0,1)"], // #(argb,8,8,3)color(1,0.5,0,0.4)
	["Red", RPT_color + "(0.45,0.005,0,1)"], // #(argb,8,8,3)color(1,0.1,0,0.3)
	["Pink", RPT_color + "(0.5,0.03,0.3,1)"], // #(argb,8,8,3)color(1,0.06,0.6,0.5)
	["Purple", RPT_color + "(0.1,0,0.3,1)"], // #(argb,8,8,3)color(0.8,0,1,0.1)
	["ARPA Navy", RPT_texDir + "arpa_navy.paa"],
	["ARPA Woodland", RPT_texDir + "arpa_woodland.paa"],
	["Abstract Red", RPT_texDir + "abstraitrouge.paa"],
	["Abstract Green", RPT_texDir + "abstraitvert.paa"],
	["Abstract Modern", RPT_texDir + "abstraitmoderne.paa"],
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
	["Urban", RPT_texDir + "urban.paa"],
	["Woodland", RPT_texDir + "woodland.paa"],
	["Woodland Tiger", RPT_texDir + "woodtiger.paa"]
];

private ["_name", "_texture"];
if (GRLIB_LRX_Texture_enabled) then {
	(
		"
		true
		"
		configClasses (configfile >> "LRX_TextureSources")
	) apply {
		_name = getText (_x >> "name");
		if (_name == "") then {_name = (configName _x)};
		_texture = getText (_x >> "texture");
		RPT_colorList pushback [_name, _texture];
	};
};

[] call compileFinal preprocessFileLineNumbers "addons\VAM\RPT_vip_textures.sqf";

if (isDedicated) exitWith {};

// Get Arsenal items
waitUntil {sleep 1; !isNil "LRX_arsenal_init_done"};
waitUntil {sleep 1; LRX_arsenal_init_done};

VAM_arsenal_class_names = [];

// Weapons
private _arsenal_enable_weapons = [];
if (VAM_arsenal_enable_weapons) then {
	// Weapons + Equipements (uniforme, etc..)
	(
		"
		getNumber (_x >> 'scope') > 1 &&
		([(configName _x)] call is_allowed_item)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { _arsenal_enable_weapons pushback (configName _x) };
};
_arsenal_enable_weapons sort true;

// Uniforms
private _arsenal_enable_uniforms = [];
private _arsenal_uniforms_sign = ["H_", "U_", "V_"];
_arsenal_enable_uniforms = _arsenal_enable_weapons select { ([_x, _arsenal_uniforms_sign] call F_startsWithMultiple) };
_arsenal_enable_weapons = _arsenal_enable_weapons - _arsenal_enable_uniforms;
if (!VAM_arsenal_enable_uniforms) then { _arsenal_enable_uniforms = [] };
_arsenal_enable_uniforms sort true;

private _arsenal_enable_magazines = [];
if (VAM_arsenal_enable_magazines) then {
	// Magazines
	(
		"
		getNumber (_x >> 'scope') > 1 &&
		(getNumber (_x >> 'type') == 256 || (getText (_x >> 'type') find '256') >= 0) &&
		tolower (configName _x) find '_tracer' < 0 &&
		([(configName _x)] call is_allowed_item)
		"
		configClasses (configfile >> "CfgMagazines")
	) apply { _arsenal_enable_magazines pushback (configName _x) };
};
_arsenal_enable_magazines sort true;

private _arsenal_enable_backpacks = [];
if (VAM_arsenal_enable_backpacks) then {
	// Others object (backpack, etc..)
	(
		"
		((configName _x) iskindof 'Bag_Base') &&
		([(configName _x)] call is_allowed_item)
		"
		configClasses (configfile >> "CfgVehicles" )
	) apply { _arsenal_enable_backpacks pushback (configName _x) };
};
_arsenal_enable_backpacks sort true;

private _arsenal_enable_glasses = [];
if (VAM_arsenal_enable_glasses) then {
	// Glasses
	(
		"
		([(configName _x)] call is_allowed_item)
		"
		configClasses (configfile >> "CfgGlasses" )
	) apply { _arsenal_enable_glasses pushback (configName _x) };
};
_arsenal_enable_glasses sort true;

VAM_arsenal_class_names = (_arsenal_enable_weapons + _arsenal_enable_magazines + _arsenal_enable_uniforms + _arsenal_enable_backpacks + _arsenal_enable_glasses) - whitelisted_from_arsenal;
VAM_arsenal_class_names = VAM_arsenal_class_names arrayIntersect VAM_arsenal_class_names;
VAM_arsenal_class_names = whitelisted_from_arsenal + VAM_arsenal_class_names;
