// Vehicle Paint v1.10 merged with VAM
// by pSiKO - client side

[] call compileFinal preprocessFileLineNumbers "addons\VAM\RPT_init_static.sqf";

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

private _arsenal_class_names = [] + whitelisted_from_arsenal + (_arsenal_enable_weapons + _arsenal_enable_uniforms + _arsenal_enable_backpacks + _arsenal_enable_glasses + _arsenal_enable_magazines);
_arsenal_class_names = _arsenal_class_names arrayIntersect _arsenal_class_names;
VAM_arsenal_class_names = VAM_arsenal_cargo_class_names + _arsenal_class_names;
