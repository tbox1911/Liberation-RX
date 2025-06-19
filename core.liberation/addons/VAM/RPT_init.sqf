// Vehicle Paint v1.10 merged with VAM
// by pSiKO

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

// dedicated server / HC need no more
if (isDedicated) exitWith {};
if (!isDedicated && !hasInterface && isMultiplayer) exitWith {};

// Get Arsenal items
waitUntil {sleep 1; !isNil "LRX_arsenal_init_done"};
waitUntil {sleep 1; LRX_arsenal_init_done};

VAM_arsenal_class_names = [];
VAM_arsenal_cargo_class_names = [
	Arsenal_typename,
	mobile_respawn,
	repairbox_typename,
	canister_fuel_typename,
	medicalbox_typename,
	"Land_CncBarrierMedium4_F",
	"Land_BagFence_Short_F"
];

// Default source for Shop
VAM_arsenal_enable_weapons = true;
VAM_arsenal_enable_magazines = true;
VAM_arsenal_enable_uniforms = false;
VAM_arsenal_enable_backpacks = false;
VAM_arsenal_enable_glasses = false;

// ACE use only whitelist
if (GRLIB_ACE_enabled) then {
	VAM_arsenal_enable_weapons = false;
	VAM_arsenal_enable_magazines = false;
	VAM_arsenal_enable_uniforms = false;
	VAM_arsenal_enable_backpacks = false;
	VAM_arsenal_enable_glasses = false;
	// Add missing objects
	VAM_arsenal_cargo_class_names append  [
		"ACE_Wheel",
		"ACE_Track"
	];
};

if (GRLIB_filter_arsenal == 4) then {
	VAM_arsenal_enable_weapons = false;
	VAM_arsenal_enable_magazines = false;
};

// Weapons
private _arsenal_enable_weapons = [];
if (VAM_arsenal_enable_weapons) then {
	// Weapons + Equipements (uniforme, etc..)
	(
		"
		getNumber (_x >> 'scope') > 1 &&
		tolower (configName _x) find '_uniform' < 0 &&
		([(configName _x)] call is_allowed_item)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { _arsenal_enable_weapons pushback (configName _x) };
	_arsenal_enable_weapons sort true;
};

// Uniforms
private _arsenal_enable_uniforms = [];
if (VAM_arsenal_enable_uniforms) then {
	private _arsenal_uniforms_sign = ["H_", "U_", "V_"];
	_arsenal_enable_uniforms = _arsenal_enable_weapons select { ([_x, _arsenal_uniforms_sign] call F_startsWithMultiple) };
	_arsenal_enable_weapons = _arsenal_enable_weapons - _arsenal_enable_uniforms;
	_arsenal_enable_uniforms sort true;
};

// Others object (backpack, etc..)
private _arsenal_enable_backpacks = [];
if (VAM_arsenal_enable_backpacks) then {
	(
		"
		((configName _x) iskindof 'Bag_Base') &&
		([(configName _x)] call is_allowed_item)
		"
		configClasses (configfile >> "CfgVehicles" )
	) apply { _arsenal_enable_backpacks pushback (configName _x) };
	_arsenal_enable_backpacks sort true;
};
sleep 0.5;

// Glasses
private _arsenal_enable_glasses = [];
if (VAM_arsenal_enable_glasses) then {
	(
		"
		([(configName _x)] call is_allowed_item)
		"
		configClasses (configfile >> "CfgGlasses" )
	) apply { _arsenal_enable_glasses pushback (configName _x) };
	_arsenal_enable_glasses sort true;
};
sleep 0.5;

// Magazines
private _arsenal_enable_magazines = [];
if (VAM_arsenal_enable_magazines) then {
	(
		"
		getNumber (_x >> 'scope') > 1 &&
		(getNumber (_x >> 'type') == 256 || (getText (_x >> 'type') find '256') >= 0)
		"
		configClasses (configfile >> "CfgMagazines")
	) apply { _arsenal_enable_magazines pushback (configName _x) };
	_arsenal_enable_magazines sort true;
};

waitUntil {sleep 1; !isNil "whitelisted_from_arsenal"};
private _arsenal_class_names = [];
_arsenal_class_names = whitelisted_from_arsenal + (_arsenal_enable_weapons + _arsenal_enable_uniforms + _arsenal_enable_backpacks + _arsenal_enable_glasses + _arsenal_enable_magazines);
_arsenal_class_names = _arsenal_class_names arrayIntersect _arsenal_class_names;
VAM_arsenal_class_names = VAM_arsenal_cargo_class_names + _arsenal_class_names;
