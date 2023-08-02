// *** FRIENDLIES ***
GRLIB_side_friendly = EAST;
GRLIB_west_modder = "Z@Warrior";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf
// Requires: IFA3 AIO; optional additionally: WW2 Tanks, Flying Legends, Secret Weapons Reloaded

huron_typename = "";
FOB_typename = "Land_WW2_Kladovka2";
Respawn_truck_typename = "LIB_Zis5v_Med";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "LIB_US6_Ammo";
ammo_truck_typename = "LIB_US6_Ammo";
fuel_truck_typename = "LIB_Zis5v_Fuel";
repair_truck_typename = "LIB_Zis6_Parm";
repair_offroad = "LIB_DAK_OpelBlitz_Parm";
SHOP_Man = "LIB_CIV_Citizen_2";
SELL_Man = "LIB_CIV_Villager_1";
Radio_tower = "Land_Vysilac_FM2";
GRLIB_sar_wreck = "Land_Wreck_C130J_EP1_ruins";
pilot_classname = "LIB_SOV_pilot";
crewman_classname = "LIB_SOV_LC_rifleman";
A3W_BoxWps = "LIB_BasicWeaponsBox_SU";
WRHS_Man = "LIB_CIV_SchoolTeacher";			// Man in Warehouse
commander_classname = "LIB_CIV_Assistant";		// Sell-Man in FOB


chimera_vehicle_overide = [
  ["B_Heli_Light_01_F", "LIB_Willys_MB"],
  ["B_Heli_Transport_01_F", "LIB_US6_Tent_Cargo"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["LIB_SOV_LC_rifleman",1,0,0,0],
	["LIB_SOV_medic",1,0,0,0],
	["LIB_SOV_sapper",1,0,0,0],
	["LIB_SOV_grenadier",1,0,0,GRLIB_perm_inf],
	["LIB_SOV_AT_M1A1_soldier",1,0,0,GRLIB_perm_inf],
	["LIB_SOV_AT_soldier",1,0,0,GRLIB_perm_inf],
	["LIB_SOV_scout_mgunner",1,0,0,GRLIB_perm_log],
	["LIB_SOV_scout_sniper",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

// *** RESISTANCE
resistance_squad = [
	"LIB_SOV_scout_p_officer",
	"LIB_SOV_scout_smgunner",
	"LIB_SOV_grenadier",
	"LIB_SOV_scout_lieutenant",
	"LIB_SOV_scout_mgunner",
	"LIB_SOV_scout_sergeant",
	"LIB_SOV_AT_M1A1_soldier"
];

resistance_squad_static = "LIB_61k";

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
	["O_Boat_Transport_01_F",1,25,1,0],
	["LIB_GazM1_SOV",1,25,1,0],
	["LIB_Willys_MB",1,25,3,GRLIB_perm_inf],
	["LIB_Scout_M3",1,50,3,GRLIB_perm_inf],
	["LIB_SOV_M3_Halftrack",1,50,5,GRLIB_perm_inf],
	["LIB_SdKfz251_captured",1,75,7,GRLIB_perm_tank],
	["LIB_SdKfz251_captured_FFV",1,100,7,GRLIB_perm_tank]
];

heavy_vehicles = [
	["LIB_Zis5v_61K",10,200,10,GRLIB_perm_log],
	["LIB_US6_BM13",10,250,10,GRLIB_perm_log],
	["LIB_T34_76",10,250,10,GRLIB_perm_log],
	["LIB_T34_85",15,300,10,GRLIB_perm_log],
	["LIB_SU85",15,350,15,GRLIB_perm_log],
	["LIB_JS2_43",15,400,15,GRLIB_perm_tank],
	["LIB_M4A2_SOV",20,450,15,GRLIB_perm_tank]
];

// Additional Tanks from Mod WW2 Tanks
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  heavy_vehicles pushBack ["FA_KV1",15,500,15,GRLIB_perm_tank];
  heavy_vehicles pushBack ["FA_T26",10,400,10,GRLIB_perm_max];
};

air_vehicles = [
	["LIB_P39",10,500,15,GRLIB_perm_air],
	["LIB_RA_P39_2",10,600,15,GRLIB_perm_air],
	["LIB_Pe2",10,700,15,GRLIB_perm_max]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  air_vehicles pushBack ["sab_fl_yak3",15,800,15,GRLIB_perm_max];
};

// Additional Airplanes from Mod Secret Weapons (requ. Mod Flying Legends):
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  air_vehicles pushBack ["sab_sw_i16",15,800,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_sw_il2",15,900,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_sw_il2_2",15,1000,20,GRLIB_perm_max];
};

blufor_air = [
	"LIB_RA_P39_2",
	"LIB_Pe2",
	"LIB_P39"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  blufor_air pushBack ["sab_fl_yak3"];
};

static_vehicles = [
	["LIB_SU_SearchLight",1,50,0,GRLIB_perm_log],
	["LIB_Maxim_M30_base",1,75,0,GRLIB_perm_log],
	["LIB_BM37",0,100,0,GRLIB_perm_log],
	["LIB_61k",1,125,0,GRLIB_perm_log],
	["LIB_Zis3",1,200,0,GRLIB_perm_tank]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"LIB_61k",
	"LIB_SU_SearchLight",
	"LIB_Maxim_M30_base",
	"LIB_Zis3"
];

support_vehicles_west = [
	["LIB_US6_Ammo",5,250,10,GRLIB_perm_inf],
	["LIB_Zis6_Parm",5,250,10,GRLIB_perm_inf],
	["LIB_Zis5v_Fuel",5,250,15,GRLIB_perm_inf]
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
	"LIB_SOV_scout_lieutenant",
	"LIB_SOV_scout_rifleman",
	"LIB_SOV_scout_rifleman",
	"LIB_SOV_sapper",
	"LIB_SOV_grenadier",
	"LIB_SOV_medic"
];

blufor_squad_inf = [
	"LIB_SOV_scout_lieutenant",
	"LIB_SOV_scout_rifleman",
	"LIB_SOV_sapper",
	"LIB_SOV_grenadier",
	"LIB_SOV_medic",
	"LIB_SOV_scout_sniper",
	"LIB_SOV_scout_mgunner"
];

blufor_squad_at = [
	"LIB_SOV_scout_lieutenant",
	"LIB_SOV_scout_rifleman",
	"LIB_SOV_sapper",
	"LIB_SOV_grenadier",
	"LIB_SOV_medic",
	"LIB_SOV_AT_M1A1_soldier",
	"LIB_SOV_AT_soldier"
];

blufor_squad_aa = [
	"LIB_SOV_scout_lieutenant",
	"LIB_SOV_scout_rifleman",
	"LIB_SOV_sapper",
	"LIB_SOV_grenadier",
	"LIB_SOV_medic",
	"LIB_SOV_scout_mgunner",
	"LIB_SOV_scout_mgunner"
];

blufor_squad_mix = [
	"LIB_SOV_scout_lieutenant",
	"LIB_SOV_scout_rifleman",
	"LIB_SOV_sapper",
	"LIB_SOV_grenadier",
	"LIB_SOV_medic",
	"LIB_SOV_scout_mgunner",
	"LIB_SOV_smgunner_summer",
	"LIB_SOV_scout_atrifle_gunner",
	"LIB_SOV_AT_soldier"
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
  	"LIB_Zis6_Parm"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"LIB_Zis5v_Med"
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
	"LIB_Willys_MB_Hood"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"LIB_Scout_M3_FFV"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"LIB_SOV_M3_Halftrack"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"LIB_US6_Tent"
];

GRLIB_AirDrop_5 = [			// APC 750
	"LIB_SdKfz251_captured_FFV"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"B_Boat_Transport_01_F"
];
