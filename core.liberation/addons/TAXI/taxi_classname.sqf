
// Heli Taxi classname definition

// Taxi classname by size 
taxi_type_2 = [];
taxi_type_6 = [];
taxi_type_8 = [];
taxi_type_14 = [];

// *** DEFAULT ***
if ( isNil "taxi_helipad_type" ) then { taxi_helipad_type = "Land_HelipadCivil_F" };

default_taxi_type_2 = [
	"C_Heli_light_01_blue_F",
	"C_Heli_light_01_red_F",
	"C_Heli_light_01_ion_F",
    "C_Heli_light_01_blueLine_F",
	"C_Heli_light_01_digital_F",
	"C_Heli_light_01_elliptical_F",
	"C_Heli_light_01_furious_F",
	"C_Heli_light_01_graywatcher_F",
	"C_Heli_light_01_jeans_F",
	"C_Heli_light_01_light_F",
	"C_Heli_light_01_sheriff_F",
	"C_Heli_light_01_speedy_F",
	"C_Heli_light_01_sunset_F",
	"C_Heli_light_01_wasp_F",
	"C_Heli_light_01_luxe_F"
];

default_taxi_type_6 = [
	"I_Heli_light_03_unarmed_F",
	"I_E_Heli_light_03_unarmed_F"
];

default_taxi_type_8 = [
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_01_camo_F"
];

default_taxi_type_14 = [
	"I_Heli_Transport_02_F",
	"B_Heli_Transport_03_unarmed_green_F",
	"B_Heli_Transport_03_black_F"
];

if (GRLIB_mod_preset_taxi in [0,1]) then {
	// *** FRIENDLIES ***
	private _path = format ["mod_template\%1\classnames_taxi.sqf", GRLIB_mod_west];
	[_path] call F_getTemplateFile;
	if (isNil "overide_taxi_type_2") then { overide_taxi_type_2 = default_taxi_type_2 };
	taxi_type_2 append overide_taxi_type_2;
	if (isNil "overide_taxi_type_6") then { overide_taxi_type_6 = default_taxi_type_6 };
	taxi_type_6 append overide_taxi_type_6;
	if (isNil "overide_taxi_type_8") then { overide_taxi_type_8 = default_taxi_type_8 };
	taxi_type_8 append overide_taxi_type_8;
	if (isNil "overide_taxi_type_14") then { overide_taxi_type_14 = default_taxi_type_14 };
	taxi_type_14 append overide_taxi_type_14;
};

if (GRLIB_mod_preset_taxi in [0,2]) then {
	// *** BADDIES ***
	private _path = format ["mod_template\%1\classnames_taxi.sqf", GRLIB_mod_east];
	[_path] call F_getTemplateFile;
	taxi_type_2 append overide_taxi_type_2;
	taxi_type_6 append overide_taxi_type_6;
	taxi_type_8 append overide_taxi_type_8;
	taxi_type_14 append overide_taxi_type_14;
};

// Filter (remove dup)
taxi_type_2 = taxi_type_2 arrayIntersect taxi_type_2;
taxi_type_6 = taxi_type_6 arrayIntersect taxi_type_6;
taxi_type_8 = taxi_type_8 arrayIntersect taxi_type_8;
taxi_type_14 = taxi_type_14 arrayIntersect taxi_type_14;
