// *** BADDIES ***
GRLIB_side_enemy = WEST;
GRLIB_east_modder = "pSiKO";

// All class MUST be defined !

opfor_sentry = "B_Soldier_lite_F";
opfor_rifleman = "B_Soldier_F";
opfor_grenadier = "B_Soldier_GL_F";
opfor_squad_leader = "B_Soldier_SL_F";
opfor_team_leader = "B_Soldier_TL_F";
opfor_marksman = "B_soldier_M_F";
opfor_machinegunner = "B_Soldier_AR_F";
opfor_heavygunner = "B_HeavyGunner_F";
opfor_medic = "B_medic_F";
opfor_rpg = "B_Soldier_LAT_F";
opfor_at = "B_Soldier_AT_F";
opfor_aa = "B_Soldier_AA_F";
opfor_officer = "B_officer_F";
opfor_sharpshooter = "B_Sharpshooter_F";
opfor_sniper = "B_sniper_F";
opfor_spotter = "B_spotter_F";
opfor_engineer = "B_engineer_F";
opfor_paratrooper = "B_soldier_PG_F";
opfor_mrap_hmg = "B_MRAP_01_hmg_F";
opfor_mrap_gmg = "B_MRAP_01_gmg_F";
opfor_transport_helo = "B_Heli_Transport_03_F";
opfor_transport_truck = "B_Truck_01_covered_F";
opfor_fuel_truck = "B_Truck_01_fuel_F";
opfor_ammo_truck = "B_Truck_01_ammo_F";
opfor_fuel_container = "B_Slingload_01_Fuel_F";
opfor_ammo_container = "B_Slingload_01_Ammo_F";
opfor_flag = "Flag_NATO_F";
opfor_house = "Land_Cargo_House_V1_F";
opfor_patrol = "Land_Cargo_Patrol_V1_F";
opfor_hq = "Land_Cargo_HQ_V1_F";

// used as first defenders of sector
militia_squad = [
	"B_G_Soldier_SL_F",
	"B_G_Soldier_A_F",
	"B_G_Soldier_AR_F",
	"B_G_Soldier_AR_F",
	"B_G_medic_F",
	"B_G_engineer_F",
	"B_G_Soldier_exp_F",
	"B_G_Soldier_GL_F",
	"B_G_Soldier_M_F",
	"B_G_Soldier_F",
	"B_G_Soldier_LAT_F",
	"B_G_Soldier_LAT_F",
	"B_G_Soldier_lite_F",
	"B_G_Sharpshooter_F",
	"B_G_Soldier_TL_F",
	"B_Soldier_AA_F",
	"B_Soldier_AT_F"
];

militia_loadout_overide = [
	"B_Soldier_AA_F",
	"B_Soldier_AT_F"
];

divers_squad = [
	"B_diver_TL_F",
	"B_diver_TL_F",
	"B_diver_exp_F",
	"B_diver_exp_F",
	"B_diver_exp_F",
	"B_diver_exp_F",
	"B_diver_F",
	"B_diver_F",
	"B_diver_F",
	"B_diver_F",
	"B_diver_F",
	"B_diver_F"
];

militia_vehicles = [
	"B_G_Offroad_01_armed_F",
	"B_G_Offroad_01_armed_F",
	"B_G_Offroad_01_AT_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F"
];

opfor_boats = [
	"B_Boat_Armed_01_minigun_F",
	"B_T_Boat_Armed_01_minigun_F"
];

// used when an Opfor sector is attacked
opfor_vehicles = [
	"B_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_cannon_F",
	"B_T_APC_Tracked_01_AA_F",
	"B_MRAP_01_gmg_F",
	"B_MRAP_01_hmg_F",
	"B_MRAP_01_gmg_F",
	"B_MRAP_01_hmg_F",
	"B_MBT_01_TUSK_F"
];

opfor_vehicles_low_intensity = [
	"B_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F",
	"B_MRAP_01_hmg_F",
	"B_MRAP_01_gmg_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F"
];

// used when battlegroup is called
opfor_battlegroup_vehicles = [
	"B_MRAP_01_hmg_F",
	"B_MRAP_01_gmg_F",
	"B_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_cannon_F",
	"B_T_APC_Tracked_01_AA_F",
	"B_Heli_Attack_01_F",
	"B_Heli_Transport_03_F",
	"B_Truck_01_covered_F",
	"B_MBT_01_TUSK_F",
	"B_MBT_01_TUSK_F"
];

opfor_battlegroup_vehicles_low_intensity = [
	"B_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F",
	"B_MRAP_01_hmg_F",
	"B_MRAP_01_gmg_F",
	"B_Heli_Transport_01_F",
	"B_CTRG_Heli_Transport_01_sand_F",
	"B_Truck_01_transport_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F"
];

// used by opfor_battlegroup as transport
opfor_troup_transports_truck = [
	"B_Truck_01_covered_F",
	"B_Truck_01_transport_F"
];

opfor_troup_transports_heli = [
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_03_F",
	"B_CTRG_Heli_Transport_01_sand_F"
];

// used by battlegroup air attack
opfor_air = [
	"B_Heli_Light_01_armed_F",
	"B_Heli_Attack_01_F",
	"B_T_VTOL_01_infantry_F",
	"B_Plane_CAS_01_F",
	"B_Plane_Fighter_01_F"
];

opfor_statics = [
	"B_HMG_01_high_F",
	"B_GMG_01_high_F",
	"B_static_AA_F",
	"B_static_AT_F",
	"B_Mortar_01_F"
];


opfor_recyclable = [
	["B_HMG_01_high_F",0,round (20 / GRLIB_recycling_percentage),0],
	["B_GMG_01_high_F",0,round (40 / GRLIB_recycling_percentage),0],
	["B_static_AA_F",0,round (80 / GRLIB_recycling_percentage),0],
	["B_static_AT_F",0,round (80 / GRLIB_recycling_percentage),0],
	["B_Mortar_01_F",0,round (300 / GRLIB_recycling_percentage),0],
	["B_T_LSV_01_armed_F",1,round (20 / GRLIB_recycling_percentage),2],
	["B_T_LSV_01_AT_F",1,round (40 / GRLIB_recycling_percentage),2],
	["B_G_Offroad_01_armed_F",1,round (30 / GRLIB_recycling_percentage),2],
	["B_G_Offroad_01_AT_F",1,round (40 / GRLIB_recycling_percentage),2],
	["B_Truck_01_transport_F",5,round (20 / GRLIB_recycling_percentage),5],
	["B_Truck_01_covered_F",5,round (20 / GRLIB_recycling_percentage),5],
	["B_MRAP_01_hmg_F",5,round (150 / GRLIB_recycling_percentage),3],
	["B_MRAP_01_gmg_F",5,round (150 / GRLIB_recycling_percentage),3],
	["B_T_Boat_Armed_01_minigun_F",2,round (100 / GRLIB_recycling_percentage),2],
	["B_APC_Tracked_01_rcws_F",10,round (350 / GRLIB_recycling_percentage),10],
	["B_APC_Wheeled_01_cannon_F",10,round (400 / GRLIB_recycling_percentage),10],
	["B_APC_Tracked_01_AA_F",10,round (500 / GRLIB_recycling_percentage),10],
	["B_MBT_01_cannon_F",15,round (1400 / GRLIB_recycling_percentage),15],
	["B_MBT_01_TUSK_F",15,round (2500 / GRLIB_recycling_percentage),15],
	["B_AFV_Wheeled_01_cannon_F",15,round (3000 / GRLIB_recycling_percentage),15],
	["B_AFV_Wheeled_01_up_cannon_F",15,round (3500 / GRLIB_recycling_percentage),15],
	["B_MBT_01_arty_F",15,round (3500 / GRLIB_recycling_percentage),20],
	["B_Heli_Light_01_F",10,round (150 / GRLIB_recycling_percentage),18],
	["B_Heli_Light_01_armed_F",10,round (250 / GRLIB_recycling_percentage),20],
	["B_Heli_Transport_01_F",10,round (300 / GRLIB_recycling_percentage),20],
	["B_Heli_Transport_03_F",10,round (400 / GRLIB_recycling_percentage),20],
	["B_CTRG_Heli_Transport_01_sand_F",10,round (350 / GRLIB_recycling_percentage),20],
	["B_Heli_Attack_01_F",10,round (1300 / GRLIB_recycling_percentage),20],
	["B_T_VTOL_01_infantry_F",10,round (1500 / GRLIB_recycling_percentage),25],
	["B_T_VTOL_01_vehicle_F",10,round (1500 / GRLIB_recycling_percentage),25],
	["B_T_VTOL_01_armed_F",10,round (1500 / GRLIB_recycling_percentage),25],
	["B_Plane_CAS_01_dynamicLoadout_F",20,round (2000 / GRLIB_recycling_percentage),30],
	["B_Plane_CAS_01_F",20,round (2000 / GRLIB_recycling_percentage),30],
	["B_Plane_Fighter_01_F",20,round (2500 / GRLIB_recycling_percentage),30]
];
