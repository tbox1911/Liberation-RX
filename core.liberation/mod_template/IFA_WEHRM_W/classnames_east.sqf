// *** BADDIES ***
GRLIB_side_enemy = WEST;
GRLIB_east_modder = "Z@Warrior";

// All class MUST be defined !

opfor_sentry = "LIB_GER_Soldier_camo_MP40_w";
opfor_rifleman = "LIB_GER_Rifleman3_w";
opfor_grenadier = "LIB_GER_Scout_ober_grenadier_w";
opfor_squad_leader = "LIB_GER_Unterofficer_w";
opfor_team_leader = "LIB_GER_Hauptmann_w";
opfor_marksman = "LIB_GER_Scout_ober_rifleman_w";
opfor_machinegunner = "LIB_GER_Mgunner_w";
opfor_heavygunner = "LIB_GER_Stggunner_w";
opfor_medic = "LIB_GER_Medic_w";
opfor_rpg = "LIB_GER_LAT_Rifleman_w";
opfor_at = "LIB_GER_AT_soldier_w";
opfor_aa = "LIB_GER_Scout_mgunner_w";
opfor_officer = "LIB_GER_Oberst_w";
opfor_sharpshooter = "LIB_GER_Scout_sniper_w";
opfor_sniper = "LIB_GER_Scout_sniper_2_w";
opfor_spotter = "LIB_GER_Rifleman_w";
opfor_engineer = "LIB_GER_Sapper_gefr_w";
opfor_paratrooper = "LIB_GER_Scout_ober_grenadier_w";
opfor_mrap = "LIB_SdKfz_7_w";
opfor_mrap_hmg = "LIB_Sdkfz251_w";
opfor_mrap_gmg = "LIB_SdKfz251_FFV_w";
opfor_transport_helo = "LIB_FW190F8";
opfor_transport_truck = "LIB_OpelBlitz_Open_G_Camo_w";
opfor_fuel_truck = "LIB_OpelBlitz_Fuel_w";
opfor_ammo_truck = "LIB_OpelBlitz_Ammo_w";
opfor_fuel_container = "B_Slingload_01_Fuel_F";
opfor_ammo_container = "B_Slingload_01_Ammo_F";
opfor_flag = "LIB_FlagCarrier_GER";

militia_squad = [
	"LIB_GER_smgunner",
	"LIB_GER_gun_crew",
	"LIB_GER_gun_unterofficer",
	"LIB_GER_ober_grenadier",
	"LIB_GER_mgunner",
	"LIB_GER_LAT_Rifleman",
	"LIB_GER_AT_grenadier",
	"LIB_GER_sapper",
	"LIB_GER_rifleman",
	"LIB_GER_Soldier2",
	"LIB_GER_Soldier3",
	"LIB_GER_stggunner",
	"LIB_GER_unterofficer"
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
	"LIB_Kfz1_w",
	"LIB_Sdkfz251_w",
	"LIB_SdKfz251_FFV_w",
	"LIB_SdKfz_7_AA_w",
	"LIB_StuG_III_G_WS_w"
];

boats_east = [
	"B_G_Boat_Transport_01_F"
];

opfor_vehicles = [
	"LIB_OpelBlitz_Open_Y_Camo_w",
	"LIB_SdKfz251_FFV_w",
	"LIB_FlakPanzerIV_Wirbelwind_w",
	"LIB_StuG_III_G_w",
	"LIB_PzKpfwIV_H_w",
	"LIB_PzKpfwV_w",
	"LIB_PzKpfwVI_B_w",
	"LIB_PzKpfwVI_E_w"
];

opfor_vehicles_low_intensity = [
	"LIB_OpelBlitz_Open_Y_Camo_w",
	"LIB_SdKfz251_FFV_w",
	"LIB_FlakPanzerIV_Wirbelwind_w"
];

opfor_battlegroup_vehicles = [
	"LIB_SdKfz251_FFV_w",
	"LIB_StuG_III_G_w",
	"LIB_PzKpfwIV_H_w",
	"LIB_PzKpfwV_w",
	"LIB_PzKpfwVI_B_w",
	"LIB_PzKpfwVI_E_w",
	"LIB_FW190F8_2_w",
	"LIB_Ju87_w"
];

opfor_battlegroup_vehicles_low_intensity = [
	"LIB_SdKfz251_FFV_w",
	"LIB_FlakPanzerIV_Wirbelwind_w",
	"LIB_SdKfz_7_AA_w",
	"LIB_StuG_III_G_w",
	"LIB_FW190F8_3_w"
];

opfor_troup_transports_truck = [
	"LIB_SdKfz_7_w",
	"LIB_OpelBlitz_Open_Y_Camo_w",
	"LIB_OpelBlitz_Open_G_Camo_w"
];

opfor_troup_transports_heli = [		// ?? no helis
	"LIB_FW190F8"
];

opfor_air = [
	"LIB_FW190F8_2_w",
	"LIB_FW190F8_3_w",
	"LIB_Ju87_w"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  opfor_air pushBack "sab_fl_bf109e";
  opfor_air pushBack "sab_fl_fw190a";
  opfor_air pushBack "sab_fl_he162";
  opfor_air pushBack "sab_fl_ju88a";
};

opfor_statics = [
	"LIB_FlaK_30_w",
	"LIB_FlaK_38_w",
	"LIB_Flakvierling_38_w",
	"LIB_Pak40_w",
	"LIB_FlaK_36_w",
	"LIB_FlaK_36_AA_w",
	"LIB_FlaK_36_ARTY_w"
];

opfor_recyclable = [
	// Boat
	["B_G_Boat_Transport_01_F",1,round (20 / GRLIB_recycling_percentage),2],
	// Static
	["LIB_FlaK_30_w",1,round (30 / GRLIB_recycling_percentage),0],
	["LIB_FlaK_38_w",1,round (30 / GRLIB_recycling_percentage),0],
	["LIB_Flakvierling_38_w",1,round (40 / GRLIB_recycling_percentage),0],
	["LIB_Pak40_w",1,round (50 / GRLIB_recycling_percentage),0],
	["LIB_FlaK_36_w",1,round (40 / GRLIB_recycling_percentage),0],
	["LIB_FlaK_36_AA_w",1,round (40 / GRLIB_recycling_percentage),0],
	["LIB_FlaK_36_ARTY_w",1,round (40 / GRLIB_recycling_percentage),0],

	// Vehicles
	["LIB_OpelBlitz_Open_G_Camo_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_OpelBlitz_Open_Y_Camo_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_OpelBlitz_Fuel_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_OpelBlitz_Ammo_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_SdKfz_7_w",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_Kfz1_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_Sdkfz251_w",1,round (30 / GRLIB_recycling_percentage),2],
	["LIB_SdKfz251_FFV_w",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_SdKfz_7_AA_w",1,round (40 / GRLIB_recycling_percentage),2],
	["LIB_StuG_III_G_WS_w",2,round (50 / GRLIB_recycling_percentage),2],
	["LIB_FlakPanzerIV_Wirbelwind_w",2,round (80 / GRLIB_recycling_percentage),2],
	["LIB_StuG_III_G_w",2,round (80 / GRLIB_recycling_percentage),2],
	["LIB_PzKpfwIV_H_w",2,round (100 / GRLIB_recycling_percentage),5],
	["LIB_PzKpfwV_w",2,round (100 / GRLIB_recycling_percentage),5],
	["LIB_PzKpfwVI_B_w",2,round (100 / GRLIB_recycling_percentage),5],
	["LIB_PzKpfwVI_E_w",2,round (100 / GRLIB_recycling_percentage),5],
	// Airplanes
	["LIB_FW190F8_2_w",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_FW190F8_3_w",10,round (200 / GRLIB_recycling_percentage),15],
	["LIB_Ju87_w",10,round (200 / GRLIB_recycling_percentage),15]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
    opfor_recyclable pushBack ["sab_fl_bf109e",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_fl_fw190a",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_fl_he162",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_fl_ju88a",10,round (200 / GRLIB_recycling_percentage),15];
};
