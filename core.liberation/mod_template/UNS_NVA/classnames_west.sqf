// *** FRIENDLIES ***
// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

// Unsung Men NVA (8th Battalion PAWN '65)

huron_typename = "uns_Mi8T_VPAF";
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "uns_nvatruck";
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_outpost = "Land_BagBunker_Tower_F";
FOB_box_outpost = "Land_Cargo10_grey_F";

Respawn_truck_typename = "uns_Type63_amb";
ammo_truck_typename = "uns_nvatruck_reammo";
fuel_truck_typename = "uns_nvatruck_refuel";
repair_truck_typename = "uns_nvatruck_repair";

pilot_classname = "uns_nvaf_pilot2";
crewman_classname = "uns_nvaf_pilot5";

//Arsenal_typename = "Land_vn_us_weapons_stack2";

A3W_BoxWps = "uns_resupply_crate_NVA";

repair_offroad = "C_Offroad_01_repair_F";

SHOP_Man = "uns_civilian4";	//"C_Man_formal_1_F";
SELL_Man = "uns_civilian3_b1";	//"C_Story_Mechanic_01_F";


Radio_tower = "Antenna";  // Unsung Antenna - default Antenna will not explode ???

//repair_sling_typename = "B_Slingload_01_repair_F";
//fuel_sling_typename = "B_Slingload_01_Fuel_F";
//ammo_sling_typename = "B_Slingload_01_Ammo_F";
//medic_sling_typename = "B_Slingload_01_Medevac_F";
//PAR_Medikit = "Medikit";
//PAR_AidKit = "FirstAidKit";
//waterbarrel_typename = "Land_WaterBottle_01_stack_F";
//fuelbarrel_typename = "Land_vn_metalbarrel_f";
//foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F";
//GRLIB_sar_wreck = "vn_air_uh1d_med_wreck";
//canisterFuel = "Land_CanisterFuel_Red_F";

// *********************************************************************


chimera_vehicle_overide = [
  ["B_Heli_Light_01_F", "B_Heli_Light_01_F"],
  ["B_Heli_Transport_01_F", ""]		// "O_Heli_Light_02_unarmed_F"
];


// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]

infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["uns_men_NVA_65_RF3",1,0,0,0],
	["uns_men_NVA_65_MED",1,0,0,0],
	["uns_men_NVA_65_AS8",1,0,0,GRLIB_perm_inf],
	["uns_men_NVA_65_LMG",1,0,0,GRLIB_perm_inf],
	["uns_men_NVA_65_MGS",1,0,0,GRLIB_perm_inf],
	["uns_men_NVA_65_MRK",1,0,0,GRLIB_perm_inf],
	["uns_men_NVA_65_AT2",1,0,0,GRLIB_perm_inf],
	["uns_men_NVA_65_AA",1,0,0,GRLIB_perm_inf],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_inf]
];

units_loadout_overide = [];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]

/* Ranking-System
0			Private
GRLIB_perm_inf		Corporal	200
GRLIB_perm_log		Sergeant	400
GRLIB_perm_tank		Captain		600
GRLIB_perm_air		Major		800
GRLIB_perm_max		Colonel		1000
GRLIB_perm_max*2	Super Colonel 	2000
*/

light_vehicles = [
["UNS_Zodiac_NVA",1,25,1,0],
["UNS_ASSAULT_BOAT_VC",2,180,5,GRLIB_perm_log],
["UNS_PATROL_BOAT_NVA",2,200,5,GRLIB_perm_log],
["uns_Type55",2,130,5,0],
["uns_nvatruck_mg",1,50,5,0],
["uns_Type55_MG",1,65,5,GRLIB_perm_inf],
["uns_Type55_M40",1,80,5,GRLIB_perm_inf],
["uns_Type55_twinMG",1,60,5,GRLIB_perm_log],
["uns_BTR152_ZPU",1,60,5,GRLIB_perm_log],
["uns_Type55_ZU",1,80,5,GRLIB_perm_log],
["uns_nvatruck_s60",1,100,5,GRLIB_perm_log],
["uns_nvatruck_type65",1,125,5,GRLIB_perm_log],
["uns_nvatruck_zpu",1,100,5,GRLIB_perm_log],
["uns_Type63_mg",1,200,8,GRLIB_perm_tank]
];

heavy_vehicles = [
["uns_ZSU23_NVA",2,225,10,GRLIB_perm_tank],
["uns_ZSU57_NVA",2,250,10,GRLIB_perm_tank],
["uns_ot34_85_nva",2,275,10,GRLIB_perm_tank],
["uns_pt76",2,300,10,GRLIB_perm_tank],
["uns_t34_85_nva",2,350,12,GRLIB_perm_tank],
["uns_t54_nva",2,375,12,GRLIB_perm_max],
["uns_t55_nva",2,400,12,GRLIB_perm_max],
["uns_to55_nva",2,450,12,GRLIB_perm_max]
];

air_vehicles = [
["uns_Mi8TV_VPAF_MG",2,200,5,GRLIB_perm_inf],
["uns_an2_bmb",3,800,10,GRLIB_perm_air],
["uns_an2_cas",4,900,12,GRLIB_perm_air],
["uns_Mig21_BMB",4,1000,12,GRLIB_perm_max],
["uns_Mig21_SEAD",4,1100,12,GRLIB_perm_max],
["uns_Mig21_CAS",4,1200,12,GRLIB_perm_max]
];


blufor_air = [
"uns_Mi8TV_VPAF_MG",
"uns_Mig21_BMB",
"uns_Mig21_CAS",
"uns_an2_bmb",
"uns_an2_cas"];

static_vehicles = [
	["uns_m1941_82mm_mortarNVA_arty",0,70,0,GRLIB_perm_log],
	["uns_M40_106mm_NVA",0,40,0,GRLIB_perm_log],
	["uns_KS19_NVA",0,40,0,GRLIB_perm_log],
	["uns_ZPU4_NVA",0,40,0,GRLIB_perm_log],

	["uns_pk_high_NVA",1,40,0,GRLIB_perm_log],
	["uns_dshk_armoured_NVA",1,140,0,GRLIB_perm_log],
	["uns_dshk_twin_NVA",1,40,0,GRLIB_perm_log],
	["uns_Type36_57mm_NVA",1,40,0,GRLIB_perm_log],
	["uns_Type74_NVA",1,40,0,GRLIB_perm_log],
	["uns_ZU23_NVA",1,40,0,GRLIB_perm_log]

];

// *** Static Weapon with AI ***
static_vehicles_AI = [
"uns_dshk_armoured_NVA",
"uns_dshk_twin_NVA",
"uns_pk_high_NVA",
"uns_Type36_57mm_NVA",
"uns_Type74_NVA",
"uns_ZU23_NVA"
];

support_vehicles_west = [
	["uns_nvatruck_refuel",5,200,15,GRLIB_perm_log],
	["uns_nvatruck_reammo",5,200,5,GRLIB_perm_log],
	["uns_nvatruck_repair",5,200,5,GRLIB_perm_tank]
];

buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["pook_Land_fort_artillery_nest_MUD",0,0,0,0],
	["Land_Illum_Tower",0,0,0,0],
	["Land_fortified_nest_small_ep1",0,0,0,0],
	["LAND_uns_bunker_troop2",0,0,0,0],
	["Land_Wood_Tower",0,0,0,0],
	["Land_bagfencecorner",0,0,0,0],
	["Land_bagfenceend",0,0,0,0],
	["Land_bagfencelong",0,0,0,0],
	["Land_bagfenceround",0,0,0,0],
	["Land_bagfenceshort",0,0,0,0],
	["LAND_sb_bunker_main",0,0,0,0],
	["LAND_sb_bunker_main02",0,0,0,0],
	["LAND_t_sb_cnr",0,0,0,0],
	["LAND_t_sb_bunker2",0,0,0,0],
	["LAND_t_sb_end",0,0,0,0],
	["LAND_t_sb_pit1",0,0,0,0],
	["LAND_t_sb_Tee",0,0,0,0],
	["LAND_t_sb_20",0,0,0,0],
	["LAND_t_sb_Cross",0,0,0,0],
	["Land_bagfencecorner",0,0,0,0],
	["Land_bagfenceend",0,0,0,0],
	["Land_bagfencelong",0,0,0,0],
	["Land_bagfenceround",0,0,0,0],
	["Land_bagfenceshort",0,0,0,0],
	["uns_FlagCarrierVC",0,0,0,0]
];

blufor_squad_inf_light = [
"uns_men_NVA_65_off",
"uns_men_NVA_65_MED",
"uns_men_NVA_65_RF2",
"uns_men_NVA_65_AS8"
];


blufor_squad_inf = [
"uns_men_NVA_65_off",
"uns_men_NVA_65_MED",
"uns_men_NVA_65_RF2",
"uns_men_NVA_65_AS8",
"uns_men_NVA_65_HMG",
"uns_men_NVA_65_AS8"
];


blufor_squad_at = [
"uns_men_NVA_65_off",
"uns_men_NVA_65_MED",
"uns_men_NVA_65_RF2",
"uns_men_NVA_65_AT",
"uns_men_NVA_65_AT2"
];

blufor_squad_aa = [
"uns_men_NVA_65_off",
"uns_men_NVA_65_MED",
"uns_men_NVA_65_RF2",
"uns_men_NVA_65_AA",
"uns_men_NVA_65_AA"
];

blufor_squad_mix = [
"uns_men_NVA_65_off",
"uns_men_NVA_65_MED",
"uns_men_NVA_65_RF2",
"uns_men_NVA_65_AA",
"uns_men_NVA_65_AT",
"uns_men_NVA_65_MRK",
"uns_men_NVA_65_LMG"
];

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,800,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
"uns_Mi8T_VPAF",
"uns_nvatruck_reammo",
"uns_M577_amb",
"Land_TentDome_F",
Arsenal_typename
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
"uns_Mi8T_VPAF",
"uns_M577_amb",
"Land_TentDome_F"
];


vehicle_rearm_sources_west = [
"uns_Mi8T_VPAF",
"uns_nvatruck_reammo",
Arsenal_typename
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [];


GRLIB_AirDrop_1 = [			// Unarmed Offroader 50
	"uns_Type55"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"uns_Type55_MG"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"uns_Type63_mg"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"uns_nvatruck_mg"
];

GRLIB_AirDrop_5 = [			// APC 750
	"uns_xm706e1"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"UNS_Zodiac_NVA"
];
