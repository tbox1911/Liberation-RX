// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_west_modder = "Z@Warrior";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf
// Requires: IFA3 AIO; optional additionally: WW2 Tanks, Flying Legends, Secret Weapons Reloaded


huron_typename = "";
FOB_typename = "Land_WW2_Kladovka2";
Respawn_truck_typename = "LIB_OpelBlitz_Ambulance_w";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "LIB_OpelBlitz_Ammo_w";
ammo_truck_typename = "LIB_OpelBlitz_Ammo_w";
fuel_truck_typename = "LIB_OpelBlitz_Fuel_w";
repair_truck_typename = "LIB_OpelBlitz_Parm_w";
repair_offroad = "LIB_DAK_OpelBlitz_Parm";
Radio_tower = "Land_Vysilac_FM2";
GRLIB_sar_wreck = "Land_Wreck_C130J_EP1_ruins";
pilot_classname = "LIB_GER_pilot";
crewman_classname = "LIB_GER_Soldier_camo_MP40_w";
A3W_BoxWps = "LIB_BasicWeaponsBox_GER";
SHOP_Man = "LIB_CIV_Citizen_2";
SELL_Man = "LIB_CIV_Villager_1";
WRHS_Man = "LIB_CIV_SchoolTeacher";			// Man in Warehouse
commander_classname = "LIB_CIV_Assistant";		// Sell-Man in FOB

chimera_vehicle_overide = [
	["B_Heli_Light_01_F", "LIB_Kfz1_w"],
	["B_Heli_Transport_01_F", "LIB_OpelBlitz_Open_Y_Camo_w"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["LIB_GER_Rifleman_w",1,0,0,0],
	["LIB_GER_Medic_w",1,0,0,0],
	["LIB_GER_Sapper_w",1,0,0,0],
	["LIB_GER_Scout_ober_grenadier_w",1,0,0,GRLIB_perm_inf],
	["LIB_GER_Stggunner_w",1,0,0,GRLIB_perm_inf],
	["LIB_GER_AT_soldier_w",1,0,0,GRLIB_perm_inf],
	["LIB_GER_Mgunner_w",1,0,0,GRLIB_perm_log],
	["LIB_GER_Scout_sniper_w",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

// *** RESISTANCE
resistance_squad = [
	"LIB_GER_Radioman_w",
	"LIB_GER_Gun_lieutenant_w",
	"LIB_GER_Hauptmann_w",
	"LIB_GER_Lieutenant_w",
	"LIB_GER_Scout_lieutenant_w",
	"LIB_GER_Ober_lieutenant_w",
	"LIB_GER_Ober_rifleman_w",
	"LIB_GER_Sapper_gefr_w",
	"LIB_GER_Recruit_w",
	"LIB_GER_Unequip_w",
	"LIB_GER_Scout_unterofficer_w",
	"LIB_GER_AT_soldier_w"
];

light_vehicles = [
	["LIB_Kfz1_w",1,50,2,0],
	["LIB_Kfz1_Hood_w",1,75,2,GRLIB_perm_inf],
	["LIB_SdKfz_7_w",1,200,3,GRLIB_perm_inf],
	["LIB_Sdkfz251_w",1,250,3,GRLIB_perm_inf],
	["LIB_SdKfz251_FFV_w",1,300,3,GRLIB_perm_inf]
];

heavy_vehicles = [
	["LIB_SdKfz_7_AA_w",5,350,5,GRLIB_perm_log],
	["LIB_FlakPanzerIV_Wirbelwind_w",10,400,10,GRLIB_perm_log],
	["LIB_StuG_III_G_w",10,500,10,GRLIB_perm_tank],
	["LIB_PzKpfwIV_H_w",10,600,10,GRLIB_perm_tank],
	["LIB_PzKpfwV_w",10,700,10,GRLIB_perm_max],
	["LIB_PzKpfwVI_B_w",15,800,15,GRLIB_perm_max],
	["LIB_PzKpfwVI_E_w",15,850,15,GRLIB_perm_max]
];

air_vehicles = [
	["LIB_FW190F8_2_w",10,700,15,GRLIB_perm_air],
	["LIB_FW190F8_w",10,800,15,GRLIB_perm_air],
	["LIB_Ju87_w",10,800,15,GRLIB_perm_max]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	air_vehicles pushBack ["sab_fl_bf109e",15,800,15,GRLIB_perm_max];
	air_vehicles pushBack ["sab_fl_fw190a",15,800,15,GRLIB_perm_max];
	air_vehicles pushBack ["sab_fl_he162",15,900,20,GRLIB_perm_max];
	air_vehicles pushBack ["sab_fl_ju88a",15,1000,20,GRLIB_perm_max];
};

blufor_air = [
	"LIB_FW190F8_2_w",
	"LIB_FW190F8_w",
	"LIB_Ju87_w"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  blufor_air pushBack ["sab_fl_ju88a"];
};

static_vehicles = [
	["LIB_MG34_Lafette_Deployed",1,100,0,GRLIB_perm_log],
	["LIB_MG42_Lafette_Deployed",1,125,0,GRLIB_perm_log],
	["LIB_GrWr34",0,125,0,GRLIB_perm_log],
	["LIB_Nebelwerfer41_Camo",0,150,0,GRLIB_perm_log],
	["LIB_FlaK_30_w",0,250,0,GRLIB_perm_log],
	["LIB_FlaK_38_w",0,300,0,GRLIB_perm_tank],
	["LIB_Flakvierling_38_w",1,400,0,GRLIB_perm_air],
	["LIB_Pak40_w",1,400,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = ["LIB_Flakvierling_38_w","LIB_Pak40_w","LIB_MG34_Lafette_Deployed","LIB_MG42_Lafette_Deployed"
];

support_vehicles_west = [
	["LIB_OpelBlitz_Ammo",5,250,10,GRLIB_perm_inf],
	["LIB_OpelBlitz_Parm",5,250,10,GRLIB_perm_inf],
	["LIB_OpelBlitz_Fuel",5,250,15,GRLIB_perm_inf]
];

buildings_west = [
	["WireFence",0,0,0,GRLIB_perm_inf],
	["FenceWood",0,0,0,GRLIB_perm_inf],
	["Concrete_Wall_EP1",0,0,0,GRLIB_perm_inf],
	["Land_Budova3",0,0,0,GRLIB_perm_inf],
	["Fortress1",0,0,0,GRLIB_perm_inf],
	["Fortress2",0,0,0,GRLIB_perm_inf],
	["LIB_FlagCarrier_GER",0,0,0,0]
];

blufor_squad_inf_light = [
	"LIB_GER_Unterofficer_w",
	"LIB_GER_Soldier_camo_MP40_w",
	"LIB_GER_Rifleman_ADS_w",
	"LIB_GER_ober_grenadier_w",
	"LIB_GER_Medic_w"
];

blufor_squad_inf = [
	"LIB_GER_Soldier_camo_MP40_w",
	"LIB_GER_Rifleman_ADS_w",
	"LIB_GER_ober_grenadier_w",
	"LIB_GER_Medic_w",
	"LIB_GER_Soldier_camo_MP40_w",
	"LIB_GER_Sapper_w",
	"LIB_GER_Scout_lieutenant_w"
];

blufor_squad_at = [
	"LIB_GER_Soldier_camo_MP40_w",
	"LIB_GER_Rifleman_ADS_w",
	"LIB_GER_ober_grenadier_w",
	"LIB_GER_Medic_w",
	"LIB_GER_Scout_lieutenant_w",
	"LIB_GER_LAT_Rifleman_w",
	"LIB_GER_AT_soldier_w"
];

blufor_squad_aa = [
	"LIB_GER_Soldier_camo_MP40_w",
	"LIB_GER_Rifleman_ADS_w",
	"LIB_GER_ober_grenadier_w",
	"LIB_GER_Medic_w",
	"LIB_GER_Scout_lieutenant_w",
	"LIB_GER_Mgunner_w",
	"LIB_GER_Scout_mgunner_w"
];

blufor_squad_mix = [
	"LIB_GER_Soldier_camo_MP40_w",
	"LIB_GER_Rifleman_ADS_w",
	"LIB_GER_ober_grenadier_w",
	"LIB_GER_Medic_w",
	"LIB_GER_Scout_lieutenant_w",
	"LIB_GER_Scout_mgunner_w",
	"LIB_GER_LAT_Rifleman_w",
	"LIB_GER_AT_grenadier_w",
	"LIB_GER_Sapper_w"
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
  "LIB_OpelBlitz_Ammo_w",
  "LIB_OpelBlitz_Parm_w"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"LIB_OpelBlitz_Ambulance_w",
	"LIB_OpelBlitz_Parm_w"
];

vehicle_rearm_sources_west = [
	"LIB_OpelBlitz_Ammo_w"
];

vehicle_big_units_west = [
];

GRLIB_vehicle_whitelist_west = [
];

GRLIB_vehicle_blacklist_west = [
];


GRLIB_AirDrop_1 = [			// Unarmed Offroader 50
	"LIB_Kfz1_w"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"LIB_Kfz1_MG42"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"LIB_Sdkfz251_w"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"LIB_OpelBlitz_Tent_Y_Camo_w"
];

GRLIB_AirDrop_5 = [			// APC 750
	"LIB_SdKfz251"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"B_Boat_Transport_01_F"
];
