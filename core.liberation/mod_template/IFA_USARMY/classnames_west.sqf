// *** FRIENDLIES ***
GRLIB_side_friendly = INDEPENDENT;
GRLIB_west_modder = "Z@Warrior";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf
// Requires: IFA3 AIO; optional additionally: WW2 Tanks, Flying Legends, Secret Weapons Reloaded

huron_typename = "";
FOB_typename = "Land_WW2_Kladovka2";
Respawn_truck_typename = "LIB_US_GMC_Ambulance";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "LIB_US_GMC_Ammo";
ammo_truck_typename = "LIB_US_GMC_Ammo";
fuel_truck_typename = "LIB_US_GMC_Fuel";
repair_truck_typename = "LIB_US_GMC_Parm";
repair_offroad = "LIB_DAK_OpelBlitz_Parm";
Radio_tower = "Land_Vysilac_FM2";
GRLIB_sar_wreck = "Land_Wreck_C130J_EP1_ruins";
SHOP_Man = "LIB_CIV_Citizen_2";
SELL_Man = "LIB_CIV_Villager_1";
WRHS_Man = "LIB_CIV_SchoolTeacher";			// Man in Warehouse
commander_classname = "LIB_CIV_Assistant";		// Sell-Man in FOB
pilot_classname = "LIB_US_Pilot";
crewman_classname = "LIB_US_Driver";
A3W_BoxWps = "LIB_BasicWeaponsBox_US";

chimera_vehicle_overide = [
	["B_Heli_Light_01_F", "LIB_US_Willys_MB"],
	["B_Heli_Transport_01_F", "LIB_US_GMC_Tent"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["LIB_US_FC_Rifleman",1,0,0,0],
	["LIB_US_Medic",1,0,0,0],
	["LIB_US_Engineer",1,0,0,0],
	["LIB_US_Grenadier",1,0,0,GRLIB_perm_inf],
	["LIB_US_SMGunner",1,0,0,GRLIB_perm_inf],
	["LIB_US_AT_Soldier",1,0,0,GRLIB_perm_inf],
	["LIB_US_MGunner",1,0,0,GRLIB_perm_log],
	["LIB_US_Sniper",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

// *** RESISTANCE - FFI Indeps
resistance_squad = [
	"LIB_FFI_Soldier_5",
	"LIB_FFI_Soldier_6",
	"LIB_FFI_Soldier_1",
	"LIB_FFI_LAT_Soldier",
	"LIB_FFI_Soldier_2",
	"LIB_FFI_Soldier_4",
	"LIB_FFI_Soldier_3"
];

light_vehicles = [
	["LIB_US_Willys_MB",1,25,1,0],
	["I_G_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["LIB_US_Willys_MB_M1919",1,25,3,GRLIB_perm_inf],
	["LIB_US_GMC_Tent",1,50,3,GRLIB_perm_inf],
	["LIB_US_Scout_M3",1,50,5,GRLIB_perm_inf],
	["LIB_M8_Greyhound",1,75,7,GRLIB_perm_tank],
	["LIB_US_M3_Halftrack",1,100,7,GRLIB_perm_tank],
	["LIB_LCVP",2,300,12,GRLIB_perm_tank],
	["LIB_LCM3_Armed",2,400,12,GRLIB_perm_tank]
];

heavy_vehicles = [
	["LIB_M3A3_Stuart",10,200,10,GRLIB_perm_log],
	["LIB_M4A3_75",10,250,10,GRLIB_perm_log],
	["LIB_M4A3_76",10,300,10,GRLIB_perm_tank],
	["LIB_M5A1_Stuart",10,350,10,GRLIB_perm_tank],
	["LIB_LCI",10,800,20,GRLIB_perm_max]
];

air_vehicles = [
	["LIB_C47_Skytrain",10,500,15,GRLIB_perm_air],
	["LIB_CG4_WACO",10,600,0,GRLIB_perm_air],
	["LIB_US_P39",10,700,15,GRLIB_perm_max],
	["LIB_US_P39_2",10,700,15,GRLIB_perm_max],
	["LIB_P47",10,700,15,GRLIB_perm_max]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  // air_vehicles pushBack ["sab_fl_f4f",10,800,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_fl_f4u",10,800,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_fl_p51d",10,900,15,GRLIB_perm_max];
  air_vehicles pushBack ["sab_fl_sbd",10,1000,15,GRLIB_perm_max];
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  // air_vehicles pushBack ["sab_sw_p38",15,800,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_sw_p40",15,900,15,GRLIB_perm_air];
  air_vehicles pushBack ["sab_sw_a26",15,900,20,GRLIB_perm_air];
  air_vehicles pushBack ["sab_sw_tbf",15,1000,20,GRLIB_perm_max];
  air_vehicles pushBack ["sab_sw_b17",15,1200,20,GRLIB_perm_max];
};

blufor_air = [
	"LIB_US_P39",
	"LIB_US_P39_2",
	"LIB_P47"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	blufor_air pushBack ["sab_fl_f4u"];
	blufor_air pushBack ["sab_fl_p51d"];
	blufor_air pushBack ["sab_fl_sbd"];
};

static_vehicles = [
	["LIB_M1919_M2",1,75,0,GRLIB_perm_log],
	["LIB_M2_60",0,100,0,GRLIB_perm_log]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"LIB_M1919_M2"
];

support_vehicles_west = [
	["LIB_OpelBlitz_Ammo",5,15,10,GRLIB_perm_inf],
	["LIB_OpelBlitz_Parm",5,15,10,GRLIB_perm_inf],
	["LIB_OpelBlitz_Fuel",5,15,15,GRLIB_perm_inf]
];

buildings_west = [
	["WireFence",0,0,0,GRLIB_perm_inf],
	["FenceWood",0,0,0,GRLIB_perm_inf],
	["Concrete_Wall_EP1",0,0,0,GRLIB_perm_inf],
	["Land_Budova3",0,0,0,GRLIB_perm_inf],
	["Fortress1",0,0,0,GRLIB_perm_inf],
	["Fortress2",0,0,0,GRLIB_perm_inf],
	["LIB_FlagCarrier_USA",0,0,0,0]
];

blufor_squad_inf_light = [
	"LIB_US_First_Lieutenant",
	"LIB_US_Corporal",
	"LIB_US_Rifleman",
	"LIB_US_Grenadier",
	"LIB_US_Medic"
];


blufor_squad_inf = [
	"LIB_US_First_Lieutenant",
	"LIB_US_Corporal",
	"LIB_US_Rifleman",
	"LIB_US_Grenadier",
	"LIB_US_Medic",
	"LIB_US_SMGunner",
	"LIB_US_Engineer"
];

blufor_squad_at = [
	"LIB_US_First_Lieutenant",
	"LIB_US_Rifleman",
	"LIB_US_Grenadier",
	"LIB_US_Medic",
	"LIB_US_SMGunner",
	"LIB_US_AT_Soldier",
	"LIB_US_AT_Soldier"
];

blufor_squad_aa = [
	"LIB_US_First_Lieutenant",
	"LIB_US_Rifleman",
	"LIB_US_Medic",
	"LIB_US_SMGunner",
	"LIB_US_MGunner",
	"LIB_US_MGunner"
];

blufor_squad_mix = [
	"LIB_US_First_Lieutenant",
	"LIB_US_Rifleman",
	"LIB_US_Medic",
	"LIB_US_SMGunner",
	"LIB_US_MGunner",
	"LIB_US_Sniper",
	"LIB_US_AT_Soldier",
	"LIB_US_Engineer"
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
  "LIB_US_GMC_Ammo",
  "LIB_US_GMC_Parm"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"LIB_US_GMC_Ambulance"
];

vehicle_rearm_sources_west = [
	"LIB_US_GMC_Ammo"
];

vehicle_big_units_west = [
];

GRLIB_vehicle_whitelist_west = [
];

GRLIB_vehicle_blacklist_west = [
];

GRLIB_AirDrop_1 = [			// Unarmed Offroader 50
	"LIB_US_Willys_MB"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"LIB_US_Willys_MB_M1919"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"LIB_US_Scout_M3"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"LIB_US_GMC_Tent"
];

GRLIB_AirDrop_5 = [			// APC 750
	"LIB_M8_Greyhound"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"B_Boat_Transport_01_F"
];
