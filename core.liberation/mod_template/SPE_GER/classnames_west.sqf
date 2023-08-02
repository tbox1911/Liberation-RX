// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_west_modder = "Z@Warrior";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

// [SPE] Wehrmacht
huron_typename = "Land_HelipadEmpty_F";
FOB_typename = "Land_SPE_House_Thatch_03";
//FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
//FOB_truck_typename = "";
FOB_outpost = "Land_SPE_Barn_Thatch_02";
//FOB_box_outpost = "";
mobile_respawn = "Land_TentDome_F";
mobile_respawn_bag = "B_Kitbag_Base";
Respawn_truck_typename = "SPE_OpelBlitz_Ambulance";
ammo_truck_typename = "SPE_OpelBlitz_Ammo";
fuel_truck_typename = "SPE_OpelBlitz_Fuel";
repair_truck_typename = "SPE_OpelBlitz_Repair";
repair_sling_typename = "B_Slingload_01_repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "SPE_GER_pilot";
crewman_classname = "SPE_GER_rifleman_lite";
Arsenal_typename = "SPE_BasicAmmunitionBox_GER";
PAR_Medikit = "SPE_GER_Medkit";
PAR_AidKit = "SPE_GER_FirstAidKit";
GRLIB_sar_wreck = "SPE_FW190F8_MRWreck";
Box_Weapon_typename = "SPE_BasicWeaponsBox_GER";
Box_Ammo_typename = "SPE_BasicAmmunitionBox_GER";
Box_Support_typename = "SPE_Mine_Ammo_Box_Ger";
Box_Launcher_typename = "SPE_AmmoCrate_Mortar_GER";
Box_Special_typename = "SPE_Ammocrate_Grenades_Frag_GER";
SHOP_Man = "SPE_CIV_pak2_zwart_tie_alt";
SELL_Man = "SPE_CIV_Worker_Coverall_1";
WRHS_Man = "SPE_CIV_Worker_3";						// Man in Warehouse
commander_classname = "SPE_US_Pilot_Unequipped";			// Sell-Man in FOB
repair_offroad = "SPE_FFI_OpelBlitz_Repair";
//waterbarrel_typename = "Land_WaterBottle_01_stack_F";
fuelbarrel_typename = "Land_SPE_Jerrycan";
canister_fuel_typename = "Land_SPE_Jerrycan";
foodbarrel_typename = "Land_SPE_Fuel_Barrel_US";
basic_weapon_typename = "SPE_BasicWeaponsBox_US";
resistance_squad_static = "SPE_ST_MG34_Lafette_Deployed";

chimera_vehicle_overide = [
	["B_Heli_Light_01_F",  "SPE_OpelBlitz_Open"],
	["B_Heli_Transport_01_F", "Land_HelipadEmpty_F"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["SPE_GER_rifleman_2",1,0,0,0],
	["SPE_GER_medic",1,0,0,0],
	["SPE_GER_sapper",1,0,0,0],
	["SPE_GER_ober_grenadier",1,0,0,GRLIB_perm_inf],
	["SPE_GER_Flamethrower_Operator",1,0,0,GRLIB_perm_inf],
	["SPE_GER_stggunner",1,0,0,GRLIB_perm_inf],
	["SPE_GER_mgunner",1,0,0,GRLIB_perm_log],
	["SPE_GER_AT_grenadier",1,0,0,GRLIB_perm_log],
	["SPE_GER_LAT_Rifleman",1,0,0,GRLIB_perm_tank],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

// *** RESISTANCE - Sturmtruppen ***
resistance_squad = [
	"SPE_sturmtrooper_SquadLead",
	"SPE_sturmtrooper_stggunner",
	"SPE_sturmtrooper_sniper",
	"SPE_sturmtrooper_sapper",
	"SPE_sturmtrooper_medic",
	"SPE_sturmtrooper_ober_grenadier",
	"SPE_sturmtrooper_Flamethrower_Operator",
	"SPE_sturmtrooper_hmgunner2",
	"SPE_sturmtrooper_LAT_30m_Rifleman",
	"SPE_sturmtrooper_rifleman_lite"
];

units_loadout_overide = [
	"SPE_GER_sapper"
];

//LOADOUT_fixed_price = [];
//LOADOUT_expensive_items = [];
//LOADOUT_free_items = [];

light_vehicles = [
	// Boat
	// Land
	["SPE_OpelBlitz",1,50,1,0],
	["SPE_OpelBlitz_Flak38",1,100,2,GRLIB_perm_inf],
	["SPE_SdKfz250_1",1,150,2,GRLIB_perm_inf]
];

heavy_vehicles = [
	["SPE_PzKpfwIII_J",5,400,5,GRLIB_perm_tank],
	["SPE_PzKpfwIII_L",10,500,10,GRLIB_perm_tank],
	["SPE_PzKpfwIII_N",10,600,10,GRLIB_perm_tank],
	["SPE_PzKpfwVI_H1",10,700,10,GRLIB_perm_max],
	["SPE_Nashorn",10,750,10,GRLIB_perm_max]
];

air_vehicles = [
	["SPE_FW190F8",15,900,15,GRLIB_perm_max]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	air_vehicles pushBack ["sab_fl_bf109e",15,1000,15,GRLIB_perm_air];
	air_vehicles pushBack ["sab_fl_fw190a",15,1100,15,GRLIB_perm_air];
	air_vehicles pushBack ["sab_fl_he162",15,1200,20,GRLIB_perm_max];
	air_vehicles pushBack ["sab_fl_ju88a",15,1300,20,GRLIB_perm_max];
};

// Additional Airplanes from Mod Secret Weapons (requ. Mod Flying Legends):
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then 
{
	air_vehicles pushBack ["sab_sw_do335",15,900,15,GRLIB_perm_air];
	air_vehicles pushBack ["sab_sw_bf110",15,1000,15,GRLIB_perm_air];
	air_vehicles pushBack ["sab_sw_he177",15,1200,20,GRLIB_perm_max];
	air_vehicles pushBack ["sab_sw_ar234",15,1400,20,GRLIB_perm_max];
};

blufor_air = [
	"SPE_FW190F8"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	blufor_air pushBack ["sab_fl_ju88a"];
};

boats_west = [
];

static_vehicles = [
	["SPE_GER_SearchLight",1,50,0,GRLIB_perm_inf],
	["SPE_MG34_Lafette_Deployed",1,80,0,GRLIB_perm_inf],
	["SPE_MG34_Lafette_low_Deployed",1,80,0,GRLIB_perm_inf],
	["SPE_MG42_Lafette_Deployed",1,120,0,GRLIB_perm_log],
	["SPE_MG42_Lafette_low_Deployed",1,120,0,GRLIB_perm_log],
	["SPE_FlaK_30",2,180,0,GRLIB_perm_log],
	["SPE_FlaK_38",2,200,0,GRLIB_perm_tank],
	["SPE_FlaK_36",2,2500,0,GRLIB_perm_tank],
	["SPE_FlaK_36_AA",2,2750,0,GRLIB_perm_max],
	["SPE_GrW278_1",0,175,0,GRLIB_perm_log],
	["SPE_Pak40",0,225,0,GRLIB_perm_log],
	["SPE_leFH18_AT",0,250,0,GRLIB_perm_max],
	["SPE_leFH18",0,275,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"SPE_GER_SearchLight",
	"SPE_MG34_Lafette_Deployed",
	"SPE_MG34_Lafette_low_Deployed",
	"SPE_MG42_Lafette_Deployed",
	"SPE_MG42_Lafette_low_Deployed",
	"SPE_FlaK_30",
	"SPE_FlaK_38",
	"SPE_FlaK_36",
	"SPE_FlaK_36_AA"
];

support_vehicles_west = [
	["SPE_OpelBlitz_Repair",5,250,10,GRLIB_perm_inf],
	["SPE_OpelBlitz_Fuel",5,150,20,GRLIB_perm_inf],
	["SPE_OpelBlitz_Ammo",5,300,10,GRLIB_perm_tank]
];

buildings_west_overide = true;
buildings_west = [
	["Land_SPE_Guardbox",0,0,0,0],
	["Land_SPE_Tent_03",0,0,0,0],
	["Land_SPE_StreetLamp",0,0,0,0],
	["Land_SPE_Netting_01",0,0,0,GRLIB_perm_inf],
	["Land_SPE_Sandbag_Short",0,0,0,GRLIB_perm_inf],
	["Land_SPE_Sandbag_Short_Low",0,0,0,GRLIB_perm_inf],
	["Land_SPE_Sandbag_Long",0,0,0,GRLIB_perm_inf],
	["Land_SPE_Sandbag_Long_Thick",0,0,0,GRLIB_perm_inf],
	["Land_SPE_Sandbag_Gun_Hole",0,0,0,GRLIB_perm_inf],
	["Land_SPE_Sandbag_Long_Line",0,0,0,GRLIB_perm_inf],
	["Land_SPE_Sandbag_Nest",0,0,0,GRLIB_perm_inf],
	["Land_SPE_BarbedWire_01",0,0,0,GRLIB_perm_inf],
	["Land_SPE_BarbedWire_03",0,0,0,GRLIB_perm_inf],
	["Land_SPE_BarbedWire_04",0,0,0,GRLIB_perm_inf],
	["SPE_FlagCarrier_GER",0,0,0,0]
];

blufor_squad_inf_light = [
	"SPE_GER_SquadLead",
	"SPE_GER_rifleman_2",
	"SPE_GER_Assist_SquadLead",
	"SPE_GER_ober_grenadier",
	"SPE_GER_medic"
];

blufor_squad_inf = [
	"SPE_GER_SquadLead",
	"SPE_GER_rifleman_2",
	"SPE_GER_Assist_SquadLead",
	"SPE_GER_ober_grenadier",
	"SPE_GER_medic",
	"SPE_GER_mgunner2",
	"SPE_GER_Flamethrower_Operator"
];

blufor_squad_at = [
	"SPE_GER_SquadLead",
	"SPE_GER_rifleman_2",
	"SPE_GER_ober_grenadier",
	"SPE_GER_medic",
	"SPE_GER_LAT_30m_Rifleman",
	"SPE_GER_LAT_Rifleman"
];

blufor_squad_aa = [
	"SPE_GER_SquadLead",
	"SPE_GER_rifleman_2",
	"SPE_GER_ober_grenadier",
	"SPE_GER_medic",
	"SPE_GER_mgunner",
	"SPE_GER_mgunner"
];

blufor_squad_mix = [
	"SPE_GER_SquadLead",
	"SPE_GER_rifleman_2",
	"SPE_GER_ober_grenadier",
	"SPE_GER_medic",
	"SPE_GER_mgunner",
	"SPE_GER_LAT_Rifleman",
	"SPE_GER_sapper",
	"SPE_GER_Flamethrower_Operator"
];

squads = [
	[blufor_squad_inf_light,15,400,0,GRLIB_perm_max],
	[blufor_squad_inf,25,550,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
	"SPE_OpelBlitz_Ammo"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"SPE_OpelBlitz_Ambulance"
];

vehicle_rearm_sources_west = [
	"SPE_OpelBlitz_Ammo"
];

vehicle_big_units_west = [
];

GRLIB_vehicle_whitelist_west = [
];

GRLIB_vehicle_blacklist_west = [
];

GRLIB_AirDrop_1 = [
	"SPE_OpelBlitz_Open"
];

GRLIB_AirDrop_2 = [
	"SPE_OpelBlitz_Open"
];

GRLIB_AirDrop_3 = [
	"SPE_OpelBlitz_Open"
];

GRLIB_AirDrop_4 = [
	"SPE_OpelBlitz_Open"
];

GRLIB_AirDrop_5 = [
	"SPE_OpelBlitz_Open"
];

GRLIB_AirDrop_6 = [
	"SPE_OpelBlitz_Open"
];
