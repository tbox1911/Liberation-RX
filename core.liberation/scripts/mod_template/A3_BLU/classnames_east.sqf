// *** BADDIES ***

if ( isNil "opfor_sentry") then { opfor_sentry = "B_Soldier_lite_F" };
if ( isNil "opfor_rifleman") then { opfor_rifleman = "B_Soldier_F" };
if ( isNil "opfor_grenadier") then { opfor_grenadier = "B_Soldier_GL_F" };
if ( isNil "opfor_squad_leader") then { opfor_squad_leader = "B_Soldier_SL_F" };
if ( isNil "opfor_team_leader") then { opfor_team_leader = "B_Soldier_TL_F" };
if ( isNil "opfor_marksman") then { opfor_marksman = "B_soldier_M_F" };
if ( isNil "opfor_machinegunner") then { opfor_machinegunner = "B_Soldier_AR_F" };
if ( isNil "opfor_heavygunner") then { opfor_heavygunner = "B_HeavyGunner_F" };
if ( isNil "opfor_medic") then { opfor_medic = "B_medic_F" };
if ( isNil "opfor_rpg") then { opfor_rpg = "B_Soldier_LAT_F" };
if ( isNil "opfor_at") then { opfor_at = "B_Soldier_AT_F" };
if ( isNil "opfor_aa") then { opfor_aa = "B_Soldier_AA_F" };
if ( isNil "opfor_officer") then { opfor_officer = "B_officer_F" };
if ( isNil "opfor_sharpshooter") then { opfor_sharpshooter = "B_Sharpshooter_F" };
if ( isNil "opfor_sniper") then { opfor_sniper = "B_sniper_F" };
if ( isNil "opfor_spotter") then { opfor_spotter = "B_spotter_F" };
if ( isNil "opfor_engineer") then { opfor_engineer = "B_engineer_F" };
if ( isNil "opfor_paratrooper") then { opfor_paratrooper = "B_soldier_PG_F" };
if ( isNil "opfor_mrap") then { opfor_mrap = "B_MRAP_02_F" };
if ( isNil "opfor_mrap_hmg") then { opfor_mrap_hmg = "B_MRAP_01_hmg_F" };
if ( isNil "opfor_mrap_gmg") then { opfor_mrap_gmg = "B_MRAP_01_gmg_F" };
if ( isNil "opfor_transport_helo") then { opfor_transport_helo = "B_Heli_Transport_03_F" };
if ( isNil "opfor_transport_truck") then { opfor_transport_truck = "B_Truck_01_covered_F" };
if ( isNil "opfor_fuel_truck") then { opfor_fuel_truck = "B_Truck_01_fuel_F" };
if ( isNil "opfor_ammo_truck") then { opfor_ammo_truck = "B_Truck_01_ammo_F" };
if ( isNil "opfor_fuel_container") then { opfor_fuel_container = "B_Slingload_01_Fuel_F" };
if ( isNil "opfor_ammo_container") then { opfor_ammo_container = "B_Slingload_01_Ammo_F" };
if ( isNil "opfor_flag") then { opfor_flag = "Flag_NATO_F" };

militia_squad = [
	"B_G_Soldier_SL_F",
	"B_G_Soldier_A_F",
	"B_G_Soldier_AR_F",
	"B_G_medic_F",
	"B_G_engineer_F",
	"B_G_Soldier_exp_F",
	"B_G_Soldier_GL_F",
	"B_G_Soldier_M_F",
	"B_G_Soldier_F",
	"B_G_Soldier_LAT_F",
	"B_G_Soldier_lite_F",
	"B_G_Sharpshooter_F",
	"B_G_Soldier_TL_F",
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

opfor_boat = [
	"B_T_Boat_Armed_01_minigun_F"
];

opfor_vehicles = [
	"B_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_cannon_F",
	"B_T_APC_Tracked_01_AA_F",
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

opfor_battlegroup_vehicles = [
	"B_MRAP_01_hmg_F",
	"B_MRAP_01_gmg_F",
	"B_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_cannon_F",
	"B_T_APC_Tracked_01_AA_F",
	"B_Heli_Attack_01_F",
	"B_Heli_Transport_01_F",
	"B_Truck_01_transport_F",
	"B_MBT_01_TUSK_F",
	"B_MBT_01_TUSK_F",
	"B_AFV_Wheeled_01_cannon_F"
];

opfor_battlegroup_vehicles_low_intensity = [
	"B_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F",
	"B_MRAP_01_hmg_F",
	"B_MRAP_01_gmg_F",
	"B_Heli_Transport_01_F",
	"B_Truck_01_transport_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F"
];

opfor_troup_transports = [
	"B_Truck_01_covered_F",
	"B_Truck_01_transport_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_03_F",
	"B_Heli_Attack_02_dynamicLoadout_F"
];

opfor_choppers = [
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_03_F",
	"B_CTRG_Heli_Transport_01_sand_F",
	"B_Heli_Attack_02_dynamicLoadout_F"
];

opfor_air = [
	"B_Heli_Light_01_armed_F",
	"B_Heli_Attack_01_F",
	"B_Plane_CAS_01_F",
	"B_Plane_Fighter_01_F",
	"B_Heli_Attack_02_dynamicLoadout_F"
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
	["B_MRAP_01_hmg_F",5,round (50 / GRLIB_recycling_percentage),3],
	["B_MRAP_01_gmg_F",5,round (50 / GRLIB_recycling_percentage),3],
	["B_T_Boat_Armed_01_minigun_F",2,round (100 / GRLIB_recycling_percentage),2],
	["B_APC_Tracked_01_rcws_F",10,round (150 / GRLIB_recycling_percentage),10],
	["B_APC_Wheeled_01_cannon_F",10,round (200 / GRLIB_recycling_percentage),10],
	["B_APC_Tracked_01_AA_F",10,round (300 / GRLIB_recycling_percentage),10],
	["B_MBT_01_cannon_F",15,round (400 / GRLIB_recycling_percentage),15],
	["B_MBT_01_TUSK_F",15,round (500 / GRLIB_recycling_percentage),15],
	["B_AFV_Wheeled_01_cannon_F",15,round (1500 / GRLIB_recycling_percentage),15],
	["B_AFV_Wheeled_01_up_cannon_F",15,round (1500 / GRLIB_recycling_percentage),15],
	["B_MBT_01_arty_F",15,round (2500 / GRLIB_recycling_percentage),15],
	["B_Heli_Light_01_F",10,round (50 / GRLIB_recycling_percentage),10],
	["B_Heli_Light_01_armed_F",10,round (150 / GRLIB_recycling_percentage),10],
	["B_Heli_Transport_01_F",10,round (100 / GRLIB_recycling_percentage),10],
	["B_Heli_Transport_03_F",10,round (200 / GRLIB_recycling_percentage),10],
	["B_CTRG_Heli_Transport_01_sand_F",10,round (200 / GRLIB_recycling_percentage),10],
	["B_Heli_Attack_01_F",10,round (600 / GRLIB_recycling_percentage),10],
	["B_T_VTOL_01_infantry_F",10,round (1500 / GRLIB_recycling_percentage),10],
	["B_T_VTOL_01_vehicle_F",10,round (1500 / GRLIB_recycling_percentage),10],
	["B_T_VTOL_01_armed_F",10,round (1500 / GRLIB_recycling_percentage),10],
	["B_Heli_Attack_02_dynamicLoadout_F",10,round (500 / GRLIB_recycling_percentage),10],
	["B_Plane_CAS_01_dynamicLoadout_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["B_Plane_CAS_01_F",20,round (1500 / GRLIB_recycling_percentage),30],
	["B_Plane_Fighter_01_F",20,round (2000 / GRLIB_recycling_percentage),30]
];