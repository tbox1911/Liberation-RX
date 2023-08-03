// *** BADDIES ***
GRLIB_side_enemy = EAST;
GRLIB_east_modder = "Z@Warrior";

// All class MUST be defined !

opfor_sentry = "LIB_SOV_scout_rifleman";
opfor_rifleman = "LIB_SOV_scout_smgunner";
opfor_grenadier = "LIB_SOV_grenadier";
opfor_squad_leader = "LIB_SOV_scout_p_officer";
opfor_team_leader = "LIB_SOV_scout_lieutenant";
opfor_marksman = "LIB_SOV_scout_rifleman";
opfor_machinegunner = "LIB_SOV_scout_mgunner";
opfor_heavygunner = "LIB_SOV_assault_mgunner";
opfor_medic = "LIB_SOV_medic";
opfor_rpg = "LIB_SOV_AT_M1A1_soldier";
opfor_at = "LIB_SOV_AT_soldier";
opfor_aa = "LIB_SOV_scout_mgunner";
opfor_officer = "LIB_SOV_captain_summer";
opfor_sharpshooter = "LNRD_Luftwaffe_sniper";
opfor_sniper = "LIB_SOV_scout_sniper";
opfor_spotter = "LIB_SOV_scout_sniper";
opfor_engineer = "LIB_SOV_assault_smgunner";
opfor_paratrooper = "LIB_SOV_scout_sergeant";

opfor_mrap = "LIB_Scout_M3";
opfor_mrap_hmg = "LIB_SOV_M3_Halftrack";
opfor_mrap_gmg = "LIB_SdKfz251_captured_FFV";
opfor_transport_helo = "LIB_Li2";	// ???
opfor_transport_truck = "LIB_US6_Tent";
opfor_fuel_truck = "LIB_Zis5v_Fuel";
opfor_ammo_truck = "LIB_US6_Ammo";
opfor_fuel_container = "B_Slingload_01_Fuel_F";
opfor_ammo_container = "B_Slingload_01_Ammo_F";
opfor_flag = "LIB_FlagCarrier_SU";

militia_squad = [
	"LIB_SOV_scout_p_officer",
	"LIB_SOV_scout_lieutenant",
	"LIB_SOV_scout_mgunner",
	"LIB_SOV_scout_sergeant",
	"LIB_SOV_AT_M1A1_soldier",
	"LIB_SOV_scout_atrifle_assistant",
	"LIB_SOV_medic",
	"LIB_SOV_assault_smgunner"
];

militia_loadout_overide = [

];

divers_squad = [
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F"
];

militia_vehicles = [
	"LIB_Scout_M3",
	"LIB_Willys_MB",
	"LIB_SdKfz251_captured",
	"LIB_Scout_M3_FFV",
	"LIB_SdKfz251_captured_FFV",
	"LIB_T34_76",
	"LIB_SOV_M3_Halftrack"
];

boats_east = [
	"B_G_Boat_Transport_01_F"
];

opfor_vehicles = [
	"LIB_GazM1_SOV",
	"LIB_US6_BM13",
	"LIB_Scout_M3",
	"LIB_Scout_M3_FFV",
	"LIB_US6_Open",
	"LIB_Willys_MB",
	"LIB_Zis5v_61K",
	"LIB_SOV_M3_Halftrack",
	"LIB_SdKfz251_captured",
	"LIB_SdKfz251_captured_FFV",
	"LIB_T34_76",
	"LIB_SU85",
	"LIB_JS2_43",
	"LIB_M4A2_SOV",
	"LIB_T34_85"
];

// Additional Tanks from Mod WW2 Tanks
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then
{
  opfor_vehicles pushBack "FA_KV1";
  opfor_vehicles pushBack "FA_T26";
};

opfor_vehicles_low_intensity = [
	"LIB_US6_BM13",
	"LIB_Scout_M3",
	"LIB_Scout_M3_FFV",
	"LIB_US6_Open",
	"LIB_Willys_MB",
	"LIB_Zis5v_61K",
	"LIB_SOV_M3_Halftrack",
	"LIB_SdKfz251_captured",
	"LIB_SdKfz251_captured_FFV"
];

// Additional Tanks from Mod WW2 Tanks
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then
{
  opfor_vehicles_low_intensity pushBack "FA_T26";
};

opfor_battlegroup_vehicles = [
	"LIB_US6_BM13",
	"LIB_Scout_M3",
	"LIB_Scout_M3_FFV",
	"LIB_US6_Open",
	"LIB_Willys_MB",
	"LIB_Zis5v_61K",
	"LIB_SOV_M3_Halftrack",
	"LIB_SdKfz251_captured",
	"LIB_SdKfz251_captured_FFV",
	"LIB_T34_76",
	"LIB_SU85",
	"LIB_JS2_43",
	"LIB_M4A2_SOV",
	"LIB_T34_85"
];

// Additional Tanks from Mod WW2 Tanks
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  opfor_battlegroup_vehicles pushBack "FA_KV1";
  opfor_battlegroup_vehicles pushBack "FA_T26";
};


opfor_battlegroup_vehicles_low_intensity = [
	"LIB_US6_BM13",
	"LIB_Scout_M3",
	"LIB_Scout_M3_FFV",
	"LIB_US6_Open",
	"LIB_Willys_MB",
	"LIB_Zis5v_61K",
	"LIB_SOV_M3_Halftrack",
	"LIB_SdKfz251_captured",
	"LIB_SdKfz251_captured_FFV"
];

// Additional Tanks from Mod WW2 Tanks
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  opfor_battlegroup_vehicles_low_intensity pushBack "FA_T26";
};


opfor_troup_transports_truck = [
	"LIB_US6_Tent",
	"LIB_US6_Open",
	"LIB_SOV_M3_Halftrack",
	"LIB_SdKfz251_captured"
];

opfor_troup_transports_heli = [		// ?? no helis
	"LIB_Li2"
];

opfor_air = [
	"LIB_P39",
	"LIB_RA_P39_3",
	"LIB_RA_P39_2",
	"LIB_Pe2"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  opfor_air pushBack "sab_fl_yak3";
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  opfor_air pushBack "sab_sw_i16";
  opfor_air pushBack "sab_sw_il2";
  opfor_air pushBack "sab_sw_il2_2";
};

opfor_statics = [
	"LIB_Maxim_M30_base",
	"LIB_BM37",
	"LIB_61k",
	"LIB_Zis3"
];

opfor_recyclable = [
	// Boat
	["B_G_Boat_Transport_01_F",2,round (30 / GRLIB_recycling_percentage),2],
	// Static
	["LIB_Maxim_M30_base",0,round (20 / GRLIB_recycling_percentage),0],
	["LIB_BM37",0,round (20 / GRLIB_recycling_percentage),0],
	["LIB_61k",0,round (20 / GRLIB_recycling_percentage),0],
	["LIB_Zis3",0,round (30 / GRLIB_recycling_percentage),0],
	// Vehicles
	["LIB_GazM1_SOV",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_US6_BM13",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_Scout_M3",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_Scout_M3_FFV",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_US6_Open",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_Willys_MB",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_Willys_MB_Hood",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_Zis5v_61K",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_SOV_M3_Halftrack",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_SdKfz251_captured",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_SdKfz251_captured_FFV",2,round (40 / GRLIB_recycling_percentage),2],
	["LIB_T34_76",2,round (80 / GRLIB_recycling_percentage),2],
	["LIB_SU85",2,round (80 / GRLIB_recycling_percentage),2],
	["LIB_JS2_43",2,round (100 / GRLIB_recycling_percentage),5],
	["LIB_M4A2_SOV",2,round (100 / GRLIB_recycling_percentage),5],
	["LIB_T34_85",2,round (100 / GRLIB_recycling_percentage),5],
	["LIB_Zis5v_Fuel",2,round (40 / GRLIB_recycling_percentage),2],
	["LIB_US6_Ammo",2,round (40 / GRLIB_recycling_percentage),2],
	["LIB_Zis5v_Med",2,round (40 / GRLIB_recycling_percentage),2],
	// Airplanes
	["LIB_Li2",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_P39",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_RA_P39_3",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_RA_P39_2",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_Pe2",10,round (200 / GRLIB_recycling_percentage),15]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  opfor_recyclable pushBack ["sab_fl_yak3",10,round (200 / GRLIB_recycling_percentage),15];
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  opfor_recyclable pushBack ["sab_sw_i16",10,round (200 / GRLIB_recycling_percentage),15];
  opfor_recyclable pushBack ["sab_sw_il2",10,round (200 / GRLIB_recycling_percentage),15];
  opfor_recyclable pushBack ["sab_sw_il2_2",10,round (200 / GRLIB_recycling_percentage),15];
};

// Additional Tanks from Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  opfor_recyclable pushBack ["FA_KV1",2,round (100 / GRLIB_recycling_percentage),2];
  opfor_recyclable pushBack ["FA_T26",2,round (80 / GRLIB_recycling_percentage),2];
};
