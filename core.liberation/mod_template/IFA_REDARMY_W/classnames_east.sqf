// *** BADDIES ***
GRLIB_side_enemy = EAST;
GRLIB_east_modder = "Z@Warrior";


// All class MUST be defined !

opfor_sentry = "LIB_SOV_Scout_rifleman_w";
opfor_rifleman = "LIB_SOV_Scout_smgunner_w";
opfor_grenadier = "LIB_SOV_grenadier_w";
opfor_squad_leader = "LIB_SOV_scout_p_officer_w";
opfor_team_leader = "LIB_SOV_scout_lieutenant_w";
opfor_marksman = "LIB_SOV_scout_rifleman_w";
opfor_machinegunner = "LIB_SOV_scout_mgunner_w";
opfor_heavygunner = "LIB_SOV_assault_mgunner_w";
opfor_medic = "LIB_SOV_medic_w";
opfor_rpg = "LIB_SOV_AT_M1A1_soldier_w";
opfor_at = "LIB_SOV_AT_soldier_w";
opfor_aa = "LIB_SOV_scout_mgunner_w";
opfor_officer = "LIB_SOV_captain_w";
opfor_sharpshooter = "LIB_SOV_scout_rifleman_w";
opfor_sniper = "LIB_SOV_scout_sniper_w";
opfor_spotter = "LIB_SOV_scout_sniper_w";
opfor_engineer = "LIB_SOV_Sapper_w";
opfor_paratrooper = "LIB_SOV_Staff_sergeant_w";

opfor_mrap = "LIB_Scout_M3_w";
opfor_mrap_hmg = "LIB_SOV_M3_Halftrack_w";
opfor_mrap_gmg = "LIB_SdKfz251_captured_FFV_w";
opfor_transport_helo = "LIB_Li2";
opfor_transport_truck = "LIB_Zis5v_w";
opfor_fuel_truck = "LIB_Zis5v_fuel_w";
opfor_ammo_truck = "LIB_US6_Ammo";
opfor_fuel_container = "B_Slingload_01_Fuel_F";
opfor_ammo_container = "B_Slingload_01_Ammo_F";
opfor_flag = "LIB_FlagCarrier_SU";

militia_squad = [
	"LIB_SOV_scout_p_officer_w",
	"LIB_SOV_scout_lieutenant_w",
	"LIB_SOV_scout_mgunner_w",
	"LIB_SOV_scout_sergeant_w",
	"LIB_SOV_AT_M1A1_soldier_w",
	"LIB_SOV_scout_atrifle_assistant_w",
	"LIB_SOV_medic_w",
	"LIB_SOV_assault_smgunner_w"
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
	"LIB_Scout_M3_w",
	"LIB_Willys_MB_w",
	"LIB_SdKfz251_captured_w",
	"LIB_Scout_M3_FFV_w",
	"LIB_SdKfz251_captured_FFV_w",
	"LIB_T34_76_w",
	"LIB_SOV_M3_Halftrack_w"
];

boats_east = [
	"B_G_Boat_Transport_01_F"
];

opfor_vehicles = [
	"LIB_GazM1_SOV",
	"LIB_Scout_m3_w",
	"LIB_Scout_M3_FFV_w",
	"LIB_Willys_MB_w",
	"LIB_SOV_M3_Halftrack_w",
	"LIB_SdKfz251_captured_w",
	"LIB_SdKfz251_captured_FFV_w",
	"LIB_T34_76_w",
	"LIB_SU85_w",
	"LIB_M4A2_SOV_w",
	"LIB_T34_85_w"
];

opfor_vehicles_low_intensity = [
	"LIB_Scout_m3_w",
	"LIB_Scout_M3_FFV_w",
	"LIB_Willys_MB_w",
	"LIB_SOV_M3_Halftrack_w",
	"LIB_SdKfz251_captured_w",
	"LIB_SdKfz251_captured_FFV_w",
	"LIB_T34_76_w",
	"LIB_SU85_w"
];

opfor_battlegroup_vehicles = [
	"LIB_SOV_M3_Halftrack_w",
	"LIB_SdKfz251_captured_w",
	"LIB_SdKfz251_captured_FFV_w",
	"LIB_T34_76_w",
	"LIB_SU85_w",
	"LIB_M4A2_SOV_w",
	"LIB_T34_85_w",
	"LIB_P39_w",
	"LIB_Pe2_2_w",
	"LIB_Pe2_w",
	"LIB_RA_P39_3"
];

opfor_battlegroup_vehicles_low_intensity = [
	"LIB_SOV_M3_Halftrack_w",
	"LIB_SdKfz251_captured_w",
	"LIB_SdKfz251_captured_FFV_w",
	"LIB_T34_76_w",
	"LIB_SU85_w",
	"LIB_M4A2_SOV_w",
	"LIB_T34_85_w",
	"LIB_P39_w",
	"LIB_Pe2_2_w"
];

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
	"LIB_P39_w",
	"LIB_Pe2_2_w",
	"LIB_Pe2_w",
	"LIB_RA_P39_3",
	"LIB_Li2"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  opfor_air pushBack "sab_fl_yak3";
};

opfor_statics = [
	"LIB_Maxim_M30_base",
	"LIB_BM37",
	"LIB_61k",
	"LIB_Zis3_w"
];

opfor_recyclable = [
	// Boat
	["B_G_Boat_Transport_01_F",2,round (30 / GRLIB_recycling_percentage),2],
	// Static
	["LIB_Maxim_M30_base",0,round (20 / GRLIB_recycling_percentage),0],
	["LIB_BM37",0,round (20 / GRLIB_recycling_percentage),0],
	["LIB_61k",0,round (20 / GRLIB_recycling_percentage),0],
	["LIB_Zis3_w",0,round (30 / GRLIB_recycling_percentage),0],
	// Vehicles
	["LIB_Zis5v_w",1,round (25 / GRLIB_recycling_percentage),2],
	["LIB_Zis5v_fuel_w",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_US6_Ammo",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_GazM1_SOV",1,round (25 / GRLIB_recycling_percentage),2],
	["LIB_Scout_m3_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_Scout_M3_FFV_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_Willys_MB_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_SOV_M3_Halftrack_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_SdKfz251_captured_w",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_SdKfz251_captured_FFV_w",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_T34_76_w",2,round (60 / GRLIB_recycling_percentage),2],
	["LIB_SU85_w",2,round (80 / GRLIB_recycling_percentage),2],
	["LIB_M4A2_SOV_w",2,round (80 / GRLIB_recycling_percentage),2],
	["LIB_M4A2_SOV_w",2,round (100 / GRLIB_recycling_percentage),5],
	["LIB_T34_85_w",2,round (100 / GRLIB_recycling_percentage),5],
	// Airplanes
	["LIB_P39_w",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_Pe2_2_w",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_Pe2_w",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_RA_P39_3",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_Pe2",10,round (200 / GRLIB_recycling_percentage),15]
];


// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  opfor_recyclable pushBack ["sab_fl_yak3",10,round (200 / GRLIB_recycling_percentage),15];
};
