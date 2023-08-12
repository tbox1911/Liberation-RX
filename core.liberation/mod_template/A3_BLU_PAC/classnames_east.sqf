// *** BADDIES ***
GRLIB_side_enemy = WEST;
GRLIB_east_modder = "pSiKO";

// All class MUST be defined !

opfor_sentry = "B_T_Support_AMort_F";
opfor_rifleman = "B_T_Soldier_F";
opfor_grenadier = "B_T_Soldier_GL_F";
opfor_squad_leader = "B_T_Soldier_SL_F";
opfor_team_leader = "B_T_Soldier_TL_F";
opfor_marksman = "B_T_soldier_M_F";
opfor_machinegunner = "B_T_Soldier_AR_F";
opfor_heavygunner = "B_T_Support_GMG_F";
opfor_medic = "B_T_Medic_F";
opfor_rpg = "B_T_Soldier_LAT2_F";
opfor_at = "B_T_Soldier_LAT_F";
opfor_aa = "B_T_Soldier_AA_F";
opfor_officer = "B_T_Officer_F";
opfor_sharpshooter = "B_T_soldier_M_F";
opfor_sniper = "B_T_Recon_M_F";
opfor_spotter = "B_T_Spotter_F";
opfor_engineer = "B_T_Engineer_F";
opfor_paratrooper = "B_T_Recon_JTAC_F";
opfor_mrap_hmg = "B_T_MRAP_01_hmg_F";
opfor_mrap_gmg = "B_T_MRAP_01_gmg_F";
opfor_transport_helo = "B_Heli_Transport_03_F";
opfor_transport_truck = "B_T_Truck_01_covered_F";
opfor_fuel_truck = "B_T_Truck_01_fuel_F";
opfor_ammo_truck = "B_T_Truck_01_ammo_F";
opfor_fuel_container = "B_Slingload_01_Fuel_F";
opfor_ammo_container = "B_Slingload_01_Ammo_F";
opfor_flag = "Flag_NATO_F";
opfor_house = "Land_Cargo_House_V1_F";
opfor_patrol = "Land_Cargo_Patrol_V1_F";
opfor_hq = "Land_Cargo_HQ_V1_F";

// used as first defenders of sector - FIA Blu
militia_squad = [
	"B_G_Soldier_AR_F",
	"B_G_Soldier_GL_F",
	"B_G_engineer_F",
	"B_G_Soldier_A_F",
	"B_G_officer_F",
	"B_G_medic_F",
	"B_G_Soldier_F",
	"B_G_Soldier_LAT2_F",
	"B_G_Soldier_LAT_F",
	"B_G_Soldier_M_F",
	"B_G_Soldier_TL_F",
	"B_G_Soldier_exp_F"
];

militia_loadout_overide = [];

divers_squad = [
	"B_T_Diver_F",
	"B_T_Diver_F",
	"B_T_Diver_F",
	"B_T_Diver_F",
	"B_T_Diver_F"
];

militia_vehicles = [
	"B_G_Offroad_01_armed_F",
	"B_G_Offroad_01_AT_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F",
	"B_G_Offroad_01_armed_F",
	"B_T_MRAP_01_hmg_F"
];

opfor_boats = [
	"B_T_Boat_Transport_01_F",
	"B_T_Boat_Armed_01_minigun_F",
	"B_T_Boat_Armed_01_minigun_F"
];

// used when an Opfor sector is attacked
opfor_vehicles = [
	"B_G_Offroad_01_AT_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F",
	"B_G_Offroad_01_armed_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F",
	"B_T_APC_Wheeled_01_cannon_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_T_Boat_Armed_01_minigun_F",
	"B_Heli_Light_01_dynamicLoadout_F"
];

opfor_vehicles_low_intensity = [
	"B_G_Offroad_01_AT_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F",
	"B_G_Offroad_01_armed_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F",
	"B_T_APC_Wheeled_01_cannon_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_Heli_Light_01_dynamicLoadout_F"
];

// used when battlegroup is called
opfor_battlegroup_vehicles = [
	"B_T_LSV_01_AT_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F",
	"B_T_APC_Wheeled_01_cannon_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_T_Boat_Armed_01_minigun_F",
	"B_Heli_Light_01_dynamicLoadout_F",
	"B_Heli_Attack_01_dynamicLoadout_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_T_AFV_Wheeled_01_cannon_F",
	"B_T_MBT_01_cannon_F",
	"B_T_MBT_01_TUSK_F",
	"B_T_APC_Tracked_01_AA_F",
	"B_T_MBT_01_arty_F"
];

opfor_battlegroup_vehicles_low_intensity = [
	"B_T_LSV_01_AT_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F",
	"B_T_APC_Wheeled_01_cannon_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_T_Boat_Armed_01_minigun_F",
	"B_Heli_Light_01_dynamicLoadout_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_T_AFV_Wheeled_01_cannon_F",
	"B_T_MBT_01_cannon_F",
	"B_T_MBT_01_TUSK_F"
];

// used by opfor_battlegroup as transport
opfor_troup_transports_truck = [
	"B_T_Truck_01_transport_F",
	"B_T_Truck_01_covered_F"
];

opfor_troup_transports_heli = [
	"B_Heli_Transport_03_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_03_F",
	"B_Heli_Light_01_F"
];

// used by battlegroup air attack
opfor_air = [
	"B_Heli_Transport_01_F",
	"B_Heli_Light_01_dynamicLoadout_F",
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_UAV_02_dynamicLoadout_F"];

opfor_statics = [
	"B_T_HMG_01_F",
	"B_T_GMG_01_F",
	"B_T_Mortar_01_F",
	"B_T_Static_AA_F",
	"B_T_Static_AT_F"
];

opfor_recyclable = [
	//Boat
	["B_T_Boat_Transport_01_F",1,round (30 / GRLIB_recycling_percentage),1],
	["B_T_Lifeboat",1,round (30 / GRLIB_recycling_percentage),1],
	["B_T_Boat_Armed_01_minigun_F",1,round (80 / GRLIB_recycling_percentage),2],
	["C_Scooter_Transport_01_F",1,round (30 / GRLIB_recycling_percentage),1],
	["B_SDV_01_F",1,round (50 / GRLIB_recycling_percentage),1],
	//Car:
	["B_T_Quadbike_01_F",1,round (30 / GRLIB_recycling_percentage),2],
	["SUV_01_base_black_F",1,round (30 / GRLIB_recycling_percentage),2],
	["B_G_Offroad_01_F",1,round (30 / GRLIB_recycling_percentage),2],
	["B_G_Offroad_01_armed_F",1,round (30 / GRLIB_recycling_percentage),2],
	["B_G_Offroad_01_AT_F",1,round (30 / GRLIB_recycling_percentage),2],
	["C_SUV_01_F",1,round (30 / GRLIB_recycling_percentage),2],
	["C_Van_01_transport_F",1,round (30 / GRLIB_recycling_percentage),2],
	["B_T_LSV_01_unarmed_F",1,round (50 / GRLIB_recycling_percentage),2],
	["B_T_LSV_01_armed_F",1,round (50 / GRLIB_recycling_percentage),2],
	["B_T_LSV_01_AT_F",1,round (50 / GRLIB_recycling_percentage),2],
	["B_T_MRAP_01_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_MRAP_01_hmg_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_MRAP_01_gmg_F",1,round (75 / GRLIB_recycling_percentage),2],
	// Trucks:
	["B_T_Truck_01_mover_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_cargo_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_flatbed_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_Repair_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_ammo_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_medical_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_box_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_transport_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_covered_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_T_Truck_01_fuel_F",1,round (75 / GRLIB_recycling_percentage),2],
	// Anti Air:
	["B_T_APC_Tracked_01_AA_F",5,round (250 / GRLIB_recycling_percentage),10],
	// Troup Transporter:
	["B_T_APC_Wheeled_01_cannon_F",5,round (350 / GRLIB_recycling_percentage),10],
	["B_T_APC_Tracked_01_CRV_F",5,round (450 / GRLIB_recycling_percentage),10],
	["B_T_APC_Tracked_01_rcws_F",5,round (550 / GRLIB_recycling_percentage),10],
	["B_T_AFV_Wheeled_01_cannon_F",5,round (650 / GRLIB_recycling_percentage),10],
	["B_T_AFV_Wheeled_01_up_cannon_F",5,round (750 / GRLIB_recycling_percentage),10],
	//Tanks:
	["B_T_MBT_01_cannon_F",15,round (1000 / GRLIB_recycling_percentage),15],
	["B_T_MBT_01_TUSK_F",15,round (1200 / GRLIB_recycling_percentage),15],
	// Ari
	["B_T_MBT_01_arty_F",15,round (1500 / GRLIB_recycling_percentage),15],
	["B_T_MBT_01_mlrs_F",15,round (1800 / GRLIB_recycling_percentage),15],
	//Heli:
	["B_Heli_Light_01_dynamicLoadout_F",10,round (150 / GRLIB_recycling_percentage),18],
	["B_Heli_Attack_01_dynamicLoadout_F",10,round (250 / GRLIB_recycling_percentage),20],
	["B_Heli_Transport_03_F",10,round (50 / GRLIB_recycling_percentage),18],
	["B_Heli_Transport_03_unarmed_F",10,round (50 / GRLIB_recycling_percentage),18],
	["B_Heli_Light_01_F",10,round (50 / GRLIB_recycling_percentage),15],
	["B_Heli_Transport_01_F",10,round (50 / GRLIB_recycling_percentage),15],
	//Planes:
	["C_Plane_Civil_01_F",5,round (100 / GRLIB_recycling_percentage),12],
	["B_T_VTOL_01_armed_F",10,round (1250 / GRLIB_recycling_percentage),20],
	["B_T_VTOL_01_vehicle_F",10,round (1250 / GRLIB_recycling_percentage),20],
	["B_T_VTOL_01_infantry_F",10,round (1250 / GRLIB_recycling_percentage),20],
	["B_Plane_CAS_01_dynamicLoadout_F",12,round (1650 / GRLIB_recycling_percentage),25],
	["B_Plane_Fighter_01_F",12,round (1800 / GRLIB_recycling_percentage),25],
	// Drohnes
	["B_T_UAV_03_dynamicLoadout_F",1,round (375 / GRLIB_recycling_percentage),2],
	["B_T_UGV_01_olive_F",1,round (100 / GRLIB_recycling_percentage),2],
	["B_T_UGV_01_rcws_olive_F",1,round (100 / GRLIB_recycling_percentage),2],
	["B_UAV_06_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_UAV_06_medical_F",1,round (75 / GRLIB_recycling_percentage),2],
	["B_UAV_01_F",1,round (50 / GRLIB_recycling_percentage),2],
	["B_UAV_02_dynamicLoadout_F",1,round (175 / GRLIB_recycling_percentage),1],
	["B_UAV_05_F",1,round (50 / GRLIB_recycling_percentage),1],
	//Static:
	["B_T_HMG_01_F",0,round (20 / GRLIB_recycling_percentage),0],
	["B_T_GMG_01_F",0,round (20 / GRLIB_recycling_percentage),0],
	["B_T_Mortar_01_F",0,round (20 / GRLIB_recycling_percentage),0],
	["B_T_Static_AA_F",0,round (80 / GRLIB_recycling_percentage),0],
	["B_T_Static_AT_F",0,round (80 / GRLIB_recycling_percentage),0],
	["B_SAM_System_03_F",0,round (150 / GRLIB_recycling_percentage),0],
	["B_SAM_System_01_F",0,round (150 / GRLIB_recycling_percentage),0],
	["B_AAA_System_01_F",0,round (150 / GRLIB_recycling_percentage),0],
	["B_SAM_System_02_F",0,round (150 / GRLIB_recycling_percentage),0]
];
