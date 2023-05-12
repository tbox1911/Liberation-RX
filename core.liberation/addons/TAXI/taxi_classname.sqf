
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
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Light_02_v2_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_01_camo_F"
];

default_taxi_type_14 = [
	"I_Heli_Transport_02_F",
	"B_Heli_Transport_03_unarmed_green_F",
	"B_Heli_Transport_03_black_F",
	"O_Heli_Transport_04_bench_F",
	"O_Heli_Transport_04_covered_F"
];

// *** FRIENDLIES ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_taxi.sqf", GRLIB_mod_west];
if ( count overide_taxi_type_2 == 0 ) then { overide_taxi_type_2 = default_taxi_type_2 };
taxi_type_2 append overide_taxi_type_2;
if ( count overide_taxi_type_6 == 0 ) then { overide_taxi_type_6 = default_taxi_type_6 };
taxi_type_6 append overide_taxi_type_6;
if ( count overide_taxi_type_8 == 0 ) then { overide_taxi_type_8 = default_taxi_type_8 };
taxi_type_8 append overide_taxi_type_8;
if ( count overide_taxi_type_14 == 0 ) then { overide_taxi_type_14 = default_taxi_type_14 };
taxi_type_14 append overide_taxi_type_14;

// *** BADDIES ***
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\classnames_taxi.sqf", GRLIB_mod_east];
taxi_type_2 append overide_taxi_type_2;
taxi_type_6 append overide_taxi_type_6;
taxi_type_8 append overide_taxi_type_8;
taxi_type_14 append overide_taxi_type_14;

// Filter (remove dup)
taxi_type_2 = taxi_type_2 arrayIntersect taxi_type_2;
taxi_type_6 = taxi_type_6 arrayIntersect taxi_type_6;
taxi_type_8 = taxi_type_8 arrayIntersect taxi_type_8;
taxi_type_14 = taxi_type_14 arrayIntersect taxi_type_14;
