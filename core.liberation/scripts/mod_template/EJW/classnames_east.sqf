// *** BADDIES ***

if ( isNil "opfor_sentry") then { opfor_sentry = "O_Soldier_lite_F" };
if ( isNil "opfor_rifleman") then { opfor_rifleman = "O_Soldier_F" };
if ( isNil "opfor_grenadier") then { opfor_grenadier = "O_Soldier_GL_F" };
if ( isNil "opfor_squad_leader") then { opfor_squad_leader = "O_Soldier_SL_F" };
if ( isNil "opfor_team_leader") then { opfor_team_leader = "O_Soldier_TL_F" };
if ( isNil "opfor_marksman") then { opfor_marksman = "O_soldier_M_F" };
if ( isNil "opfor_machinegunner") then { opfor_machinegunner = "O_Soldier_AR_F" };
if ( isNil "opfor_heavygunner") then { opfor_heavygunner = "O_HeavyGunner_F" };
if ( isNil "opfor_medic") then { opfor_medic = "O_medic_F" };
if ( isNil "opfor_rpg") then { opfor_rpg = "O_Soldier_LAT_F" };
if ( isNil "opfor_at") then { opfor_at = "O_Soldier_AT_F" };
if ( isNil "opfor_aa") then { opfor_aa = "O_Soldier_AA_F" };
if ( isNil "opfor_officer") then { opfor_officer = "O_officer_F" };
if ( isNil "opfor_sharpshooter") then { opfor_sharpshooter = "O_Sharpshooter_F" };
if ( isNil "opfor_sniper") then { opfor_sniper = "O_sniper_F" };
if ( isNil "opfor_engineer") then { opfor_engineer = "O_engineer_F" };
if ( isNil "opfor_paratrooper") then { opfor_paratrooper = "O_soldier_PG_F" };
if ( isNil "opfor_mrap") then { opfor_mrap = "O_MRAP_02_F" };
if ( isNil "opfor_mrap_hmg") then { opfor_mrap_hmg = "O_MRAP_02_hmg_F" };
if ( isNil "opfor_mrap_gmg") then { opfor_mrap_gmg = "O_MRAP_02_gmg_F" };
if ( isNil "opfor_transport_helo") then { opfor_transport_helo = "O_Heli_Transport_04_bench_F" };
if ( isNil "opfor_transport_truck") then { opfor_transport_truck = "O_Truck_03_covered_F" };
if ( isNil "opfor_fuel_truck") then { opfor_fuel_truck = "O_Truck_03_fuel_F" };
if ( isNil "opfor_ammo_truck") then { opfor_ammo_truck = "O_Truck_03_ammo_F" };
if ( isNil "opfor_fuel_container") then { opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F" };
if ( isNil "opfor_ammo_container") then { opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F" };
if ( isNil "opfor_flag") then { opfor_flag = "Flag_CSAT_F" };

militia_squad = [
	"O_G_Soldier_SL_F",
	"O_G_Soldier_A_F",
	"O_G_Soldier_AR_F",
	"O_G_medic_F",
	"O_G_engineer_F",
	"O_G_Soldier_exp_F",
	"O_G_Soldier_GL_F",
	"O_G_Soldier_M_F",
	"O_G_Soldier_F",
	"O_G_Soldier_LAT_F",
	"O_G_Soldier_lite_F",
	"O_G_Sharpshooter_F",
	"O_G_Soldier_TL_F",
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
	"O_G_Offroad_01_armed_F",
	"O_G_Offroad_01_armed_F",
	"O_G_Offroad_01_AT_F",
	"I_C_Offroad_02_LMG_F",
	"O_LSV_02_armed_F",
	"O_LSV_02_AT_F"
];

opfor_boat = [
	"O_Boat_Armed_01_hmg_F",
	"O_T_Boat_Armed_01_hmg_F",
	"O_Boat_Armed_01_hmg_F",
	"O_T_Boat_Armed_01_hmg_F"
];

opfor_vehicles = [
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MBT_02_cannon_F",
	"O_MBT_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"O_MRAP_02_gmg_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_hmg_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F"
];

opfor_vehicles_low_intensity = [
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_LSV_02_armed_F",
	"O_LSV_02_AT_F"
];

opfor_battlegroup_vehicles = [
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_Truck_03_covered_F",
	"O_MBT_02_cannon_F",
	"O_MBT_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Light_02_F",
	"O_Heli_Transport_04_bench_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F"
];

opfor_battlegroup_vehicles_low_intensity = [
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_Truck_02_transport_F",
	"O_Heli_Transport_04_bench_F",
	"O_LSV_02_armed_F",
	"O_LSV_02_AT_F"
];

opfor_troup_transports = [
	"O_Truck_03_transport_F",
	"O_Truck_03_covered_F",
	"O_Truck_02_covered_F",
	"O_Truck_02_transport_F",
	"O_Heli_Transport_04_bench_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Light_02_F",
	"O_T_VTOL_02_infantry_F"
];

opfor_choppers = [
	"O_Heli_Light_02_F",
	"O_Heli_Light_02_v2_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F",
	"O_Heli_Transport_04_bench_F",
	"O_T_VTOL_02_infantry_F"
];

opfor_air = [
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F",
	"O_T_VTOL_02_infantry_F",
	"O_Plane_CAS_02_F",
	"O_Plane_Fighter_02_F"
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
	["O_T_Boat_Armed_01_hmg_F",2,round (100 / GRLIB_recycling_percentage),2],
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
	["O_Heli_Transport_04_bench_F",10,round (500 / GRLIB_recycling_percentage),10],
	["O_Plane_CAS_02_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["O_Plane_Fighter_02_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["O_Plane_Fighter_02_Stealth_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["O_T_VTOL_02_vehicle_F",20,round (1000 / GRLIB_recycling_percentage),20],
	["O_T_VTOL_02_infantry_F",20,round (1000 / GRLIB_recycling_percentage),20]
];
