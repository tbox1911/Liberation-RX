// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_west_modder = "Z@Warrior";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf
// Requires: IFA3 AIO; optional additionally: WW2 Tanks, Flying Legends, Secret Weapons Reloaded

huron_typename = "";			
FOB_typename = "Land_WW2_Kladovka2"; 
Respawn_truck_typename = "LIB_OpelBlitz_Ambulance";
FOB_box_typename = "B_Slingload_01_Cargo_F",
FOB_truck_typename = "LIB_SdKfz_7_Ammo";
ammo_truck_typename = "LIB_OpelBlitz_Ammo";
fuel_truck_typename = "LIB_OpelBlitz_Fuel";
repair_truck_typename = "LIB_OpelBlitz_Parm";
repair_offroad = "LIB_DAK_OpelBlitz_Parm";
Radio_tower = "Land_Vysilac_FM2";
GRLIB_sar_wreck = "Land_Wreck_C130J_EP1_ruins";
pilot_classname = "LIB_GER_pilot";
crewman_classname = "LIB_GER_soldier_camo5_base";
A3W_BoxWps = "LIB_BasicWeaponsBox_GER";
SHOP_Man = "LIB_CIV_Citizen_2";
SELL_Man = "LIB_CIV_Villager_1";
WRHS_Man = "LIB_CIV_SchoolTeacher";			// Man in Warehouse
commander_classname = "LIB_CIV_Assistant";		// Sell-Man in FOB

chimera_vehicle_overide = [
	["B_Heli_Light_01_F", "LIB_Kfz1_camo"],
	["B_Heli_Transport_01_F", "LIB_OpelBlitz_Open_Y_Camo"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["LIB_GER_soldier_camo5_base",1,0,0,0],
	["LNRD_Luftwaffe_medic",1,0,0,0],
	["LIB_GER_sapper",1,0,0,0],
	["LIB_GER_scout_ober_grenadier",1,0,0,GRLIB_perm_inf],
	["LNRD_Luftwaffe_stggunner",1,0,0,GRLIB_perm_inf],
	["LNRD_Luftwaffe_AT_soldier",1,0,0,GRLIB_perm_inf],
	["LNRD_Luftwaffe_mgunner",1,0,0,GRLIB_perm_log],
	["LNRD_Luftwaffe_sniper",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

// *** RESISTANCE
resistance_squad = [
	"LIB_GER_smgunner",
	"LIB_GER_ober_grenadier",
	"LIB_GER_mgunner",
	"LIB_GER_lieutenant",
	"LIB_GER_ober_rifleman",
	"LIB_GER_LAT_Rifleman",
	"LIB_GER_AT_grenadier",
	"LIB_GER_sapper",
	"LIB_GER_medic",
	"LIB_GER_Soldier2",
	"LIB_GER_Soldier3",
	"LIB_GER_stggunner",
	"LIB_GER_unterofficer"
];

light_vehicles = [
	["LIB_GazM1_dirty",1,25,1,0],
	["B_Boat_Transport_01_F",1,30,1,0],
	["LIB_Kfz1_Hood_camo",1,25,3,GRLIB_perm_inf],
	["LIB_Kfz1_MG42_camo",1,50,3,GRLIB_perm_inf],
	["LIB_SdKfz_7",1,50,5,GRLIB_perm_inf],
	["LIB_SdKfz251",1,75,7,GRLIB_perm_tank],
	["LIB_SdKfz251_FFV",1,100,7,GRLIB_perm_tank]
];

heavy_vehicles = [
	["LIB_FlakPanzerIV_Wirbelwind",10,300,10,GRLIB_perm_log],
	["LIB_SdKfz_7_AA",10,400,10,GRLIB_perm_log],
	["LIB_SdKfz124",15,500,10,GRLIB_perm_log],
	["LIB_T34_76_captured",15,650,15,GRLIB_perm_log],
	["LIB_PzKpfwVI_E_tarn51d",15,800,15,GRLIB_perm_max],
	["LIB_PzKpfwVI_E_tarn52d",20,850,15,GRLIB_perm_max],
	["LIB_PzKpfwVI_E",20,900,15,GRLIB_perm_max]
];

// Additional TAnks from Mod WW2 Tanks
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  heavy_vehicles pushBack ["FA_Pz38t",15,500,15,GRLIB_perm_tank];
  heavy_vehicles pushBack ["FA_T26_Captured",15,600,15,GRLIB_perm_tank];
  heavy_vehicles pushBack ["FA_Panzer2",15,700,20,GRLIB_perm_tank];
};

air_vehicles = [
	["LIB_FW190F8",10,800,15,GRLIB_perm_air],
	["LIB_Ju87_Italy",10,900,15,GRLIB_perm_air],
	["LIB_Ju87",10,1000,15,GRLIB_perm_max]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  air_vehicles pushBack ["sab_fl_bf109e",15,1000,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_fl_fw190a",15,1100,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_fl_he162",15,1200,20,GRLIB_perm_max];
  air_vehicles pushBack ["sab_fl_ju88a",15,1300,20,GRLIB_perm_max];
};

// Additional Airplanes from Mod Secret Weapons (requ. Mod Flying Legends):
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  air_vehicles pushBack ["sab_sw_do335",15,900,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_sw_bf110",15,1000,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_sw_he177",15,1200,20,GRLIB_perm_max];
  air_vehicles pushBack ["sab_sw_ar234",15,1400,20,GRLIB_perm_max];
};

blufor_air = [
	"LIB_FW190F8",
	"LIB_FW190F8_2",
	"LIB_Ju87"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  blufor_air pushBack ["sab_fl_ju88a"];
};

static_vehicles = [
	["LIB_MG42_Lafette_Deployed",0,100,0,GRLIB_perm_log],
	["LIB_GrWr34",0,125,0,GRLIB_perm_log],
	["LIB_Nebelwerfer41_Camo",0,150,0,GRLIB_perm_log],
	["LIB_leFH18",0,200,0,GRLIB_perm_log],
	["LIB_FlaK_30",0,300,0,GRLIB_perm_tank],
	["LIB_FlaK_38",0,350,0,GRLIB_perm_tank],
	["LIB_GER_SearchLight",1,75,0,GRLIB_perm_log],
	["LIB_MG34_Lafette_Deployed",1,75,0,GRLIB_perm_log],
	["LIB_Flakvierling_38",2,375,0,GRLIB_perm_tank],
	["LIB_leFH18_AT",2,250,0,GRLIB_perm_tank],
	["LIB_Pak40",0,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"LIB_Flakvierling_38",
	"LIB_leFH18_AT",
	"LIB_MG34_Lafette_Deployed",
	"LIB_GER_SearchLight"
];

support_vehicles_west = [
	["LIB_OpelBlitz_Ammo",5,250,10,GRLIB_perm_inf],
	["LIB_OpelBlitz_Parm",5,250,10,GRLIB_perm_inf],
	["LIB_OpelBlitz_Fuel",5,250,15,GRLIB_perm_inf]
];

buildings_west = [
	["Land_WW2_BET_Sandsack",0,0,0,0],
	["WireFence",0,0,0,GRLIB_perm_inf],
	["FenceWood",0,0,0,GRLIB_perm_inf],
	["Concrete_Wall_EP1",0,0,0,GRLIB_perm_inf],
	["Land_Budova3",0,0,0,GRLIB_perm_inf],
	["Fortress1",0,0,0,GRLIB_perm_inf],
	["Fortress2",0,0,0,GRLIB_perm_inf],
	["Land_WW2_French_Wall_Small_Long_01",0,0,0,GRLIB_perm_inf],
	["Land_WW2_French_Wall_Small_Short_01",0,0,0,GRLIB_perm_inf],
	["Land_WW2_French_Wall_Tall_Short_01",0,0,0,GRLIB_perm_inf],
	["Land_WW2_French_Wall_Tall_Door_01",0,0,0,GRLIB_perm_inf],
	["Land_WW2_French_Gate_03",0,0,0,GRLIB_perm_inf],
	["LIB_FlagCarrier_GER",0,0,0,0]
];

blufor_squad_inf_light = [
	"LIB_GER_scout_lieutenant",
	"LIB_GER_rifleman",
	"LIB_GER_soldier_camo4_base",
	"LNRD_Luftwaffe_stggunner",
	"LNRD_Luftwaffe_medic"
];

blufor_squad_inf = [
	"LIB_GER_scout_lieutenant",
	"LIB_GER_soldier_camo4_base",
	"LNRD_Luftwaffe_stggunner",
	"LNRD_Luftwaffe_medic",
	"LNRD_Luftwaffe_mgunner2",
	"LIB_GER_scout_ober_grenadier",
	"LIB_GER_sapper"
];

blufor_squad_at = [
	"LIB_GER_scout_lieutenant",
	"LIB_GER_soldier_camo4_base",
	"LNRD_Luftwaffe_stggunner",
	"LNRD_Luftwaffe_medic",
	"LNRD_Luftwaffe_LAT_rifleman",
	"LNRD_Luftwaffe_AT_soldier",
	"LNRD_Luftwaffe_AT_grenadier"
];

blufor_squad_aa = [
	"LIB_GER_scout_lieutenant",
	"LIB_GER_soldier_camo4_base",
	"LNRD_Luftwaffe_stggunner",
	"LNRD_Luftwaffe_medic",
	"LNRD_Luftwaffe_mgunner",
	"LIB_GER_scout_mgunner",
	"LIB_GER_scout_ober_grenadier"
];

blufor_squad_mix = [
	"LIB_GER_scout_lieutenant",
	"LIB_GER_soldier_camo4_base",
	"LNRD_Luftwaffe_stggunner",
	"LNRD_Luftwaffe_medic",
	"LIB_GER_scout_mgunner",
	"LIB_GER_scout_ober_grenadier",
	"LNRD_Luftwaffe_LAT_rifleman",
	"LNRD_Luftwaffe_AT_grenadier"
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
	"LIB_OpelBlitz_Ammo",
	"LIB_OpelBlitz_Parm"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"LIB_OpelBlitz_Ambulance"
];

vehicle_rearm_sources_west = [
	"LIB_OpelBlitz_Ammo"
];

vehicle_big_units_west = [
];

GRLIB_vehicle_whitelist_west = [
];

GRLIB_vehicle_blacklist_west = [
];

GRLIB_AirDrop_1 = [			// Unarmed Offroader 50
	"LIB_Kfz1_Hood_camo"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"LIB_Kfz1_MG42"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"LIB_SdKfz_7"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"LIB_OpelBlitz_Tent_Y_Camo"
];

GRLIB_AirDrop_5 = [			// APC 750
	"LIB_SdKfz251"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"B_Boat_Transport_01_F"
];
