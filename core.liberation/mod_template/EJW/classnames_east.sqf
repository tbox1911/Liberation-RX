// *** BADDIES ***
GRLIB_side_enemy = EAST;
GRLIB_color_enemy = "ColorBrown";
GRLIB_color_enemy_bright = "ColorRED";

// All class MUST be defined !

opfor_sentry = "PIF_O_Adviser";
opfor_rifleman = "PIF_Soldier";
opfor_grenadier = "PIF_Grenadier";
opfor_squad_leader = "PIF_Marksman";
opfor_team_leader = "PIF_O_Adviser";
opfor_marksman = "PIF_Marksman";
opfor_machinegunner = "PIF_MG";
opfor_heavygunner = "PIF_HeavyGunner";
opfor_medic = "PIF_Medic";
opfor_rpg = "PIF_RPG";
opfor_at = "PIF_RPG";
opfor_aa = "O_Soldier_AA_F";
opfor_officer = "Haji_Matin";
opfor_sharpshooter = "PIF_Soldier";
opfor_sniper = "PIF_Marksman";
opfor_spotter = "PIF_O_Adviser";
opfor_engineer = "PIF_Saboteur";
opfor_paratrooper = "PIF_Soldier";
opfor_mrap = "O_MRAP_02_F";
opfor_mrap_hmg = "PIF_G_Offroad_01_F";
opfor_mrap_gmg = "PIF_G_Offroad_01_F";
opfor_transport_helo = "O_Heli_Transport_04_covered_F";
opfor_transport_truck = "O_Truck_03_covered_F";
opfor_fuel_truck = "O_Truck_03_fuel_F";
opfor_ammo_truck = "O_Truck_03_ammo_F";
opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F";
opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F";
opfor_flag = "Flag_Viper_F";

militia_squad = [
	"Haji_Matin",
	"TBan_Sniper",
	"TBan_Warlord",
	"TBan_Fighter1",
	"TBan_Fighter1NH",
	"TBan_Fighter2",
	"TBan_Fighter2NH",
	"TBan_Fighter3",
	"TBan_Fighter3NH",
	"TBan_Fighter4",
	"TBan_Fighter5",
	"TBan_Fighter6",
	"TBan_Fighter6NH",
	"TBan_Recruit",
	"TBan_Recruit1NH",
	"TBan_Recruit2",
	"TBan_Recruit2NH",
	"TBan_Recruit3",
	"TBan_Recruit3NH",
	"TBan_Recruit4",
	"TBan_Recruit5",
	"TBan_Recruit6",
	"TBan_Recruit6NH",
	"PIF_Militia_Medic",
	"PIF_Militia1",
	"PIF_Militia2",
	"PIF_Militia3",
	"PIF_Militia4",
	"PIF_Militia5",
	"PIF_Militia6",
	"PIF_Militia7",
	"PIF_Militia8",
	"O_Soldier_AA_F"
];

militia_loadout_overide = [
    "O_Soldier_AA_F",
    "O_Soldier_AT_F"
];

divers_squad = [
	"O_diver_TL_F",
	"O_diver_TL_F",
	"O_diver_exp_F",
	"O_diver_exp_F",
	"O_diver_exp_F",
	"O_diver_exp_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F"
];

militia_vehicles = [
	"Tban_O_Offroad_01_F",
	"Tban_O_Offroad_01_F",
	"O_G_Offroad_01_armed_F",
	"O_G_Offroad_01_AT_F",
	"I_C_Offroad_02_LMG_F"
];

boats_east = [
	"O_Boat_Armed_01_hmg_F"
];

opfor_vehicles = [
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_MRAP_02_hmg_F",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MBT_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"PIF_G_Offroad_01_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F"
];

opfor_vehicles_low_intensity = [
	"PIF_G_Offroad_01_F",
	"O_APC_Wheeled_02_rcws_F",
	"PIF_G_Offroad_01_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_LSV_02_armed_F",
	"O_LSV_02_AT_F"
];

opfor_battlegroup_vehicles = [
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",	
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_Truck_03_covered_F",
	"O_MBT_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Light_02_F",
	"O_Heli_Transport_04_covered_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F"
];

opfor_battlegroup_vehicles_low_intensity = [
	"PIF_G_Offroad_01_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_Truck_02_transport_F",
	"O_Heli_Transport_04_covered_F",
	"O_LSV_02_armed_F",
	"O_LSV_02_AT_F"
];

opfor_troup_transports = [
	"O_Truck_03_transport_F",
	"O_Truck_03_covered_F",
	"O_Truck_02_covered_F",
	"O_Truck_02_transport_F",
	"O_Heli_Transport_04_covered_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Light_02_F",
	"O_T_VTOL_02_infantry_F"
];

opfor_choppers = [
	"O_Heli_Light_02_F",
	"O_Heli_Light_02_v2_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F",
	"O_Heli_Transport_04_covered_F",
	"O_T_VTOL_02_infantry_F"
];

opfor_air = [
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F",
	"O_T_VTOL_02_infantry_F"
];

opfor_statics = [
	"O_HMG_01_high_F",
	"O_GMG_01_high_F",
	"O_static_AA_F",
	"O_static_AT_F",
	"O_Mortar_01_F"
];

opfor_recyclable = [
	["O_HMG_01_high_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_GMG_01_high_F",0,round (40 / GRLIB_recycling_percentage),0],
	["O_static_AA_F",0,round (80 / GRLIB_recycling_percentage),0],
	["O_static_AT_F",0,round (80 / GRLIB_recycling_percentage),0],
	["O_Mortar_01_F",0,round (300 / GRLIB_recycling_percentage),0],
	["O_LSV_02_armed_F",1,round (20 / GRLIB_recycling_percentage),2],
	["O_LSV_02_AT_F",1,round (40 / GRLIB_recycling_percentage),2],
	["O_G_Offroad_01_armed_F",1,round (30 / GRLIB_recycling_percentage),2],
	["O_G_Offroad_01_AT_F",1,round (40 / GRLIB_recycling_percentage),2],
	["I_C_Offroad_02_LMG_F",1,round (30 / GRLIB_recycling_percentage),2],
	["O_Truck_02_covered_F",5,round (20 / GRLIB_recycling_percentage),5],
	["O_Truck_02_transport_F",5,round (20 / GRLIB_recycling_percentage),5],
	["O_Truck_03_covered_F",5,round (50 / GRLIB_recycling_percentage),5],
	["O_Truck_03_transport_F",5,round (50 / GRLIB_recycling_percentage),5],
	["O_MRAP_02_hmg_F",5,round (50 / GRLIB_recycling_percentage),3],
	["O_MRAP_02_gmg_F",5,round (50 / GRLIB_recycling_percentage),3],
	["O_Boat_Armed_01_hmg_F",2,round (100 / GRLIB_recycling_percentage),2],
	["O_APC_Wheeled_02_rcws_F",10,round (150 / GRLIB_recycling_percentage),10],
	["O_APC_Tracked_02_cannon_F",10,round (200 / GRLIB_recycling_percentage),10],
	["O_APC_Tracked_02_AA_F",10,round (300 / GRLIB_recycling_percentage),10],
	["O_MBT_02_cannon_F",15,round (400 / GRLIB_recycling_percentage),15],
	["O_MBT_04_cannon_F",15,round (500 / GRLIB_recycling_percentage),15],
	["O_MBT_04_command_F",15,round (500 / GRLIB_recycling_percentage),15],
	["O_Heli_Attack_02_F",10,round (700 / GRLIB_recycling_percentage),15],
	["O_Heli_Attack_02_dynamicLoadout_F",10,round (700 / GRLIB_recycling_percentage),15],
	["O_Heli_Attack_02_black_F",10,round (700 / GRLIB_recycling_percentage),15],
	["O_Heli_Light_02_F",10,round (600 / GRLIB_recycling_percentage),10],
	["O_Heli_Light_02_dynamicLoadout_F",10,round (600 / GRLIB_recycling_percentage),10],
	["O_Heli_Light_02_v2_F",10,round (600 / GRLIB_recycling_percentage),10],
	["O_Heli_Transport_04_covered_F",10,round (400 / GRLIB_recycling_percentage),10],
	["O_Plane_CAS_02_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["O_Plane_Fighter_02_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["O_Plane_Fighter_02_Stealth_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["O_T_VTOL_02_vehicle_F",20,round (1000 / GRLIB_recycling_percentage),20],
	["O_T_VTOL_02_infantry_F",20,round (1000 / GRLIB_recycling_percentage),20]
];
