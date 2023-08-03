// *** BADDIES ***
GRLIB_side_enemy = INDEPENDENT;
GRLIB_east_modder = "Z@Warrior";

// All class MUST be defined !

opfor_sentry = "LIB_US_Rifleman";
opfor_rifleman = "LIB_US_FC_Rifleman";
opfor_grenadier = "LIB_US_Grenadier";
opfor_squad_leader = "LIB_US_Corporal";
opfor_team_leader = "LIB_US_First_Lieutenant";
opfor_marksman = "LIB_US_Sniper";
opfor_machinegunner = "LIB_US_MGunner";
opfor_heavygunner = "LIB_US_SMGunner";
opfor_medic = "LIB_US_Medic";
opfor_rpg = "LIB_US_AT_Soldier";
opfor_at = "LIB_US_AT_Soldier";
opfor_aa = "LIB_US_MGunner";
opfor_officer = "LIB_US_Captain";
opfor_sharpshooter = "LIB_US_Sniper";
opfor_sniper = "LIB_US_Sniper";
opfor_spotter = "LIB_US_FC_Rifleman";
opfor_engineer = "LIB_US_Engineer";
opfor_paratrooper = "LIB_US_SMGunner";
opfor_mrap = "LIB_US_Willys_MB_Hood";
opfor_mrap_hmg = "LIB_US_Willys_MB_M1919";
opfor_mrap_gmg = "LIB_US_Scout_M3";
opfor_transport_helo = "LIB_C47_Skytrain";	// ???
opfor_transport_truck = "LIB_US_GMC_Tent";
opfor_fuel_truck = "LIB_US_GMC_Fuel";
opfor_ammo_truck = "LIB_US_GMC_Ammo";
opfor_fuel_container = "B_Slingload_01_Fuel_F";
opfor_ammo_container = "B_Slingload_01_Ammo_F";
opfor_flag = "LIB_FlagCarrier_USA";

militia_squad = [
	"LIB_US_First_Lieutenant",
	"LIB_US_Engineer",
	"LIB_US_Medic",
	"LIB_US_Rifleman",
	"LIB_US_Sniper",
	"LIB_US_SMGunner",
	"LIB_US_MGunner",
	"LIB_US_AT_Soldier",
	"LIB_US_Corporal",
	"LIB_US_FC_Rifleman",
	"LIB_US_Second_Lieutenant"
];

militia_loadout_overide = [
];

divers_squad = [
	"B_T_Diver_F",
	"B_T_Diver_F",
	"B_T_Diver_F",
	"B_T_Diver_F"
];

militia_vehicles = [
	"LIB_US_Willys_MB_M1919",
	"LIB_M8_Greyhound",
	"LIB_US_Scout_M3",
	"LIB_US_M3_Halftrack",
	"LIB_M4A3_75",
	"LIB_P47"
];

boats_east = [
	"B_G_Boat_Transport_01_F"
];

opfor_vehicles = [
	"LIB_US_Willys_MB",
	"LIB_US_Willys_MB_M1919",
	"LIB_M8_Greyhound",
	"LIB_US_Scout_M3",
	"LIB_US_M3_Halftrack",
	"LIB_M4A3_75",
	"LIB_M3A3_Stuart",
	"LIB_M4A3_76",
	"LIB_M5A1_Stuart"
];

opfor_vehicles_low_intensity = [
	"LIB_US_Willys_MB",
	"LIB_US_Willys_MB_M1919",
	"LIB_M8_Greyhound",
	"LIB_US_Scout_M3",
	"LIB_US_M3_Halftrack"
];

opfor_battlegroup_vehicles = [
	"LIB_US_Willys_MB",
	"LIB_US_Willys_MB_M1919",
	"LIB_M8_Greyhound",
	"LIB_US_Scout_M3",
	"LIB_US_M3_Halftrack",
	"LIB_M4A3_75",
	"LIB_M3A3_Stuart",
	"LIB_M4A3_76",
	"LIB_M5A1_Stuart",
	"LIB_P47",
	"LIB_US_P39_2",
	"LIB_US_P39"
];

opfor_battlegroup_vehicles_low_intensity = [
	"LIB_US_Willys_MB",
	"LIB_US_Willys_MB_M1919",
	"LIB_M8_Greyhound",
	"LIB_US_Scout_M3",
	"LIB_US_M3_Halftrack",
	"LIB_US_P39"
];

opfor_troup_transports_truck = [
	"LIB_US_GMC_Tent",
	"LIB_US_GMC_Open",
	"LIB_US_M3_Halftrack"
];

opfor_troup_transports_heli = [		// ?? no helis
	"LIB_C47_Skytrain"
];

opfor_air = [
	"LIB_US_P39",
	"LIB_US_P39_2",
	"LIB_P47"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	opfor_air pushBack ["sab_fl_f4u", "sab_fl_p51d", "sab_fl_sbd"];
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
	opfor_air pushBack ["sab_sw_p38", "sab_sw_p40", "sab_sw_a26", "sab_sw_tbf","sab_sw_b17"];
};

opfor_statics = [
	"LIB_M1919_M2",
	"LIB_M2_60"
];

opfor_recyclable = [
	// Boat
	["B_G_Boat_Transport_01_F",2,round (30 / GRLIB_recycling_percentage),2],
	// Static
	["LIB_M1919_M2",0,round (20 / GRLIB_recycling_percentage),0],
	["LIB_M2_60",0,round (20 / GRLIB_recycling_percentage),0],
	// Vehicles
	["LIB_US_Willys_MB",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_US_Willys_MB_Hood",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_US_Willys_MB_M1919",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_M8_Greyhound",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_US_Scout_M3",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_US_M3_Halftrack",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_M4A3_75",2,round (40 / GRLIB_recycling_percentage),5],
	["LIB_M3A3_Stuart",2,round (40 / GRLIB_recycling_percentage),5],
	["LIB_M4A3_76",2,round (40 / GRLIB_recycling_percentage),5],
	["LIB_M5A1_Stuart",2,round (40 / GRLIB_recycling_percentage),5],
	["LIB_US_GMC_Tent",1,round (40 / GRLIB_recycling_percentage),5],
	["LIB_US_GMC_Open",1,round (40 / GRLIB_recycling_percentage),5],
	["LIB_US_GMC_Fuel",1,round (50 / GRLIB_recycling_percentage),5],
	["LIB_US_GMC_Ammo",1,round (50 / GRLIB_recycling_percentage),5],
	// Airplanes
	["LIB_C47_Skytrain",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_P47",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_US_P39_2",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_US_P39",10,round (200 / GRLIB_recycling_percentage),15]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
    opfor_recyclable pushBack ["sab_fl_f4u",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_fl_p51d",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_fl_sbd",10,round (200 / GRLIB_recycling_percentage),15];
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
    opfor_recyclable pushBack ["sab_sw_p38",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_sw_p40",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_sw_a26",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_sw_tbf",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_sw_b17",10,round (200 / GRLIB_recycling_percentage),15];
};
