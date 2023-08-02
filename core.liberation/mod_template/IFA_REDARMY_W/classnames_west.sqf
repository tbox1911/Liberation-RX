// *** FRIENDLIES ***
GRLIB_side_friendly = EAST;
GRLIB_west_modder = "Z@Warrior";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf
// Requires: IFA3 AIO; optional additionally: WW2 Tanks, Flying Legends, Secret Weapons Reloaded

huron_typename = "";
FOB_typename = "Land_WW2_Kladovka2";
Respawn_truck_typename = "LIB_Zis5v_med_w";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "LIB_US6_Ammo";
ammo_truck_typename = "LIB_US6_Ammo";
fuel_truck_typename = "LIB_Zis5v_fuel_w";
repair_truck_typename = "LIB_Zis6_parm_w";
repair_offroad = "LIB_DAK_OpelBlitz_Parm";
SHOP_Man = "LIB_CIV_Citizen_2";
SELL_Man = "LIB_CIV_Villager_1";
Radio_tower = "Land_Vysilac_FM2";
GRLIB_sar_wreck = "Land_Wreck_C130J_EP1_ruins";
WRHS_Man = "LIB_CIV_SchoolTeacher";			// Man in Warehouse
commander_classname = "LIB_CIV_Assistant";		// Sell-Man in FOB
pilot_classname = "LIB_SOV_pilot";
crewman_classname = "LIB_SOV_Smgunner_w";
A3W_BoxWps = "LIB_BasicWeaponsBox_SU";

chimera_vehicle_overide = [
	["B_Heli_Light_01_F", "LIB_Willys_MB_w"],
	["B_Heli_Transport_01_F", "LIB_Zis5v_w"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["LIB_SOV_Rifleman_w",1,0,0,0],
	["LIB_SOV_Medic_w",1,0,0,0],
	["LIB_SOV_Sapper_w",1,0,0,0],
	["LIB_SOV_grenadier_w",1,0,0,GRLIB_perm_inf],
	["LIB_SOV_AT_M1A1_soldier_w",1,0,0,GRLIB_perm_inf],
	["LIB_SOV_AT_soldier_w",1,0,0,GRLIB_perm_inf],
	["LIB_SOV_scout_mgunner_w",1,0,0,GRLIB_perm_log],
	["LIB_SOV_scout_sniper_w",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

// *** RESISTANCE
resistance_squad = [
	"LIB_SOV_Scout_p_officer_w",
	"LIB_SOV_Operator_w",
	"LIB_SOV_LC_rifleman_w",
	"LIB_SOV_Scout_smgunner_w",
	"LIB_SOV_grenadier_w",
	"LIB_SOV_Captain_w",
	"LIB_SOV_Scout_lieutenant_w",
	"LIB_SOV_Scout_mgunner_w",
	"LIB_SOV_Scout_sergeant_w",
	"LIB_SOV_Medic_w",
	"LIB_SOV_Rifleman_ADS_w",
	"LIB_SOV_Scout_rifleman_w",
	"LIB_SOV_scout_atrifle_gunner_w",
	"LIB_SOV_AT_soldier_w"
];

light_vehicles = [
	["O_Boat_Transport_01_F",1,25,1,0],
	["LIB_GazM1_SOV",1,25,1,0],
	["LIB_Willys_MB_w",1,75,3,GRLIB_perm_inf],
	["LIB_Scout_M3",1,150,3,GRLIB_perm_inf],
	["LIB_SOV_M3_Halftrack_w",1,250,5,GRLIB_perm_inf],
	["LIB_SdKfz251_captured_w",1,300,5,GRLIB_perm_tank],
	["LIB_SdKfz251_captured_FFV_w",1,325,5,GRLIB_perm_tank]
];

heavy_vehicles = [
	["LIB_Zis5v_61K",10,400,10,GRLIB_perm_log],
	["LIB_US6_BM13",10,500,10,GRLIB_perm_log],
	["LIB_T34_76_w",10,600,10,GRLIB_perm_tank],
	["LIB_T34_85_w",10,700,10,GRLIB_perm_tank],
	["LIB_SU85_w",10,750,15,GRLIB_perm_max],
	["LIB_JS2_43_w",10,800,15,GRLIB_perm_max],
	["LIB_M4A2_SOV_w",10,700,15,GRLIB_perm_tank]
];

air_vehicles = [
	["LIB_P39_w",10,500,15,GRLIB_perm_air],
	["LIB_RA_P39_2",10,600,15,GRLIB_perm_air],
	["LIB_Pe2_w",10,700,15,GRLIB_perm_max]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  air_vehicles pushBack ["sab_fl_yak3",15,800,15,GRLIB_perm_max];
};

blufor_air = [
	"LIB_P39_w",
	"LIB_Pe2_w"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  blufor_air pushBack ["sab_fl_yak3"];
};

static_vehicles = [
	["LIB_BM37",0,150,0,GRLIB_perm_log],
	["LIB_Zis3_w",1,300,0,GRLIB_perm_tank],
	["LIB_Maxim_M30_base",1,150,0,GRLIB_perm_log],
	["LIB_61k",1,250,0,GRLIB_perm_log],
	["LIB_SU_SearchLight",1,50,0,GRLIB_perm_log]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"LIB_Maxim_M30_base",
	"LIB_61k",
	"LIB_SU_SearchLight",
	"LIB_Zis3_w"
];

support_vehicles_west = [
	["LIB_Zis6_parm_w",5,250,10,GRLIB_perm_inf],
	["LIB_US6_Ammo",5,250,10,GRLIB_perm_inf],
	["LIB_Zis5v_fuel_w",5,250,15,GRLIB_perm_inf]
];

buildings_west = [
	["WireFence",0,0,0,GRLIB_perm_inf],
	["FenceWood",0,0,0,GRLIB_perm_inf],
	["Concrete_Wall_EP1",0,0,0,GRLIB_perm_inf],
	["Land_Budova3",0,0,0,GRLIB_perm_inf],
	["Fortress1",0,0,0,GRLIB_perm_inf],
	["Fortress2",0,0,0,GRLIB_perm_inf],
	["LIB_FlagCarrier_SU",0,0,0,0]
];

blufor_squad_inf_light = [
	"LIB_SOV_scout_lieutenant_w",
	"LIB_SOV_scout_rifleman_w",
	"LIB_SOV_scout_rifleman_w",
	"LIB_SOV_sapper_w",
	"LIB_SOV_grenadier_w",
	"LIB_SOV_medic_w"
];


blufor_squad_inf = [
	"LIB_SOV_scout_lieutenant_w",
	"LIB_SOV_scout_rifleman_w",
	"LIB_SOV_sapper_w",
	"LIB_SOV_grenadier_w",
	"LIB_SOV_medic_w",
	"LIB_SOV_scout_sniper_w",
	"LIB_SOV_scout_mgunner_w"
];


blufor_squad_at = [
	"LIB_SOV_scout_lieutenant_w",
	"LIB_SOV_scout_rifleman_w",
	"LIB_SOV_sapper_w",
	"LIB_SOV_grenadier_w",
	"LIB_SOV_medic_w",
	"LIB_SOV_AT_M1A1_soldier_w",
	"LIB_SOV_AT_soldier_w"
];

blufor_squad_aa = [
	"LIB_SOV_scout_lieutenant_w",
	"LIB_SOV_scout_rifleman_w",
	"LIB_SOV_sapper_w",
	"LIB_SOV_grenadier_w",
	"LIB_SOV_medic_w",
	"LIB_SOV_scout_mgunner_w",
	"LIB_SOV_scout_mgunner_w"
];

blufor_squad_mix = [
	"LIB_SOV_scout_lieutenant_w",
	"LIB_SOV_scout_rifleman_w",
	"LIB_SOV_sapper_w",
	"LIB_SOV_grenadier_w",
	"LIB_SOV_medic_w",
	"LIB_SOV_scout_mgunner_w",
	"LIB_SOV_smgunner_summer_w",
	"LIB_SOV_scout_atrifle_gunner_w",
	"LIB_SOV_AT_soldier_w"
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
	"LIB_US6_Ammo",
	"LIB_Zis6_Parm",
	"LIB_Zis6_parm_w"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"LIB_Zis5v_Med",
	"LIB_Zis5v_med_w"
];

vehicle_rearm_sources_west = [
	"LIB_US6_Ammo"
];

vehicle_big_units_west = [
];

GRLIB_vehicle_whitelist_west = [
];

GRLIB_vehicle_blacklist_west = [
];

GRLIB_AirDrop_1 = [			// Unarmed Offroader 50
	"LIB_Willys_MB_w"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"LIB_Scout_M3_FFV_w"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"LIB_SOV_M3_Halftrack_w"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"LIB_Zis5v_w"
];

GRLIB_AirDrop_5 = [			// APC 750
	"LIB_SdKfz251_captured_FFV_w"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"B_Boat_Transport_01_F"
];
