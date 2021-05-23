// *** BADDIES ***

if ( isNil "opfor_sentry") then { opfor_sentry = "I_Soldier_lite_F" };
if ( isNil "opfor_rifleman") then { opfor_rifleman = "I_Soldier_F" };
if ( isNil "opfor_grenadier") then { opfor_grenadier = "I_Soldier_GL_F" };
if ( isNil "opfor_squad_leader") then { opfor_squad_leader = "I_Soldier_SL_F" };
if ( isNil "opfor_team_leader") then { opfor_team_leader = "I_Soldier_TL_F" };
if ( isNil "opfor_marksman") then { opfor_marksman = "I_soldier_M_F" };
if ( isNil "opfor_machinegunner") then { opfor_machinegunner = "I_Soldier_AR_F" };
if ( isNil "opfor_heavygunner") then { opfor_heavygunner = "I_Soldier_AR_F" };
if ( isNil "opfor_medic") then { opfor_medic = "I_medic_F" };
if ( isNil "opfor_rpg") then { opfor_rpg = "I_Soldier_LAT_F" };
if ( isNil "opfor_at") then { opfor_at = "I_Soldier_AT_F" };
if ( isNil "opfor_aa") then { opfor_aa = "I_Soldier_AA_F" };
if ( isNil "opfor_officer") then { opfor_officer = "I_officer_F" };
if ( isNil "opfor_sharpshooter") then { opfor_sharpshooter = "I_Soldier_M_F" };
if ( isNil "opfor_sniper") then { opfor_sniper = "I_sniper_F" };
if ( isNil "opfor_spotter") then { opfor_spotter = "I_spotter_F" };
if ( isNil "opfor_engineer") then { opfor_engineer = "I_engineer_F" };
if ( isNil "opfor_pilot" ) then { opfor_pilot = "I_Pilot_F" };
if ( isNil "opfor_crew" ) then { opfor_crew = "I_crew_F" };
if ( isNil "opfor_paratrooper") then { opfor_paratrooper = "I_soldier_F" };
if ( isNil "opfor_mrap") then { opfor_mrap = "I_MRAP_02_F" };
if ( isNil "opfor_mrap_hmg") then { opfor_mrap_hmg = "I_MRAP_02_hmg_F" };
if ( isNil "opfor_mrap_gmg") then { opfor_mrap_gmg = "I_MRAP_02_gmg_F" };
if ( isNil "opfor_transport_helo") then { opfor_transport_helo = "I_Heli_Transport_04_bench_F" };
if ( isNil "opfor_transport_truck") then { opfor_transport_truck = "I_Truck_03_covered_F" };
if ( isNil "opfor_fuel_truck") then { opfor_fuel_truck = "I_Truck_03_fuel_F" };
if ( isNil "opfor_ammo_truck") then { opfor_ammo_truck = "I_Truck_03_ammo_F" };
if ( isNil "opfor_fuel_container") then { opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F" };
if ( isNil "opfor_ammo_container") then { opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F" };
if ( isNil "opfor_flag") then { opfor_flag = "Flag_FIA_F" };

militia_squad = [
	"I_G_Soldier_SL_F",
	"I_G_Soldier_A_F",
	"I_G_Soldier_AR_F",
	"I_G_medic_F",
	"I_G_engineer_F",
	"I_G_Soldier_exp_F",
	"I_G_Soldier_GL_F",
	"I_G_Soldier_M_F",
	"I_G_Soldier_F",
	"I_G_Soldier_LAT_F",
	"I_G_Soldier_lite_F",
	"I_G_Sharpshooter_F",
	"I_G_Soldier_TL_F",
	"I_Soldier_AA_F",
	"I_Soldier_AT_F"
];

divers_squad = [
	"I_diver_TL_F",
	"I_diver_TL_F",
	"I_diver_exp_F",
	"I_diver_exp_F",
	"I_diver_exp_F",
	"I_diver_exp_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F"
];

militia_vehicles = [
	"I_G_Offroad_01_armed_F",
	"I_G_Offroad_01_armed_F",
	"I_G_Offroad_01_AT_F",
	"I_C_Offroad_02_LMG_F"
];

opfor_boat = [
	"I_Boat_Armed_01_minigun_F"
];

opfor_vehicles = [
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"I_LT_01_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_APC_tracked_03_cannon_F",
	"I_MBT_03_cannon_F",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F"
];

opfor_vehicles_low_intensity = [
	"I_C_Offroad_02_LMG_F",
	"I_C_Offroad_02_AT_F",
	"I_G_Offroad_01_AT_F",
	"I_G_Offroad_01_armed_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F"
];

opfor_battlegroup_vehicles = [
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"I_LT_01_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_APC_tracked_03_cannon_F",
	"I_MBT_03_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F",
	"I_Heli_Transport_02_F",
	"I_Truck_02_covered_F",
	"I_MBT_03_cannon_F"
];

opfor_battlegroup_vehicles_low_intensity = [
	"I_LT_01_AT_F",
	"I_LT_01_AA_F",
	"I_LT_01_cannon_F",
	"I_C_Offroad_02_LMG_F",
	"I_C_Offroad_02_AT_F",
	"I_G_Offroad_01_AT_F",
	"I_G_Offroad_01_armed_F",
	"I_APC_Wheeled_03_cannon_F",
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_gmg_F",
	"I_Heli_Transport_02_F",
	"I_Truck_02_covered_F"
];

opfor_troup_transports = [
	"I_Heli_Transport_02_F",
	"I_Truck_02_covered_F",
	"I_Truck_02_transport_F"
];

opfor_choppers = [
	"I_Heli_Transport_02_F",
	"I_Heli_light_03_unarmed_F"
];

opfor_air = [
	"I_Plane_Fighter_03_CAS_F",
	"I_Plane_Fighter_04_F",
	"I_Heli_light_03_F",
	"I_Heli_light_03_F"			
];

opfor_statics = [
	"I_HMG_01_high_F",
	"I_GMG_01_high_F",
	"I_static_AA_F",
	"I_static_AT_F",
	"I_Mortar_01_F"
];

opfor_recyclable = [
	["I_MRAP_03_F",0,round (20 / GRLIB_recycling_percentage),0],
	["I_MRAP_03_hmg_F",0,round (50 / GRLIB_recycling_percentage),0],
	["I_MRAP_03_gmg_F",0,round (70 / GRLIB_recycling_percentage),0],
	["I_HMG_01_high_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_GMG_01_high_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_static_AA_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_static_AT_F",0,round (80 / GRLIB_recycling_percentage),0],
	["I_Mortar_01_F",0,round (300 / GRLIB_recycling_percentage),0],
	["I_LT_01_AT_F",1,round (20 / GRLIB_recycling_percentage),2],
	["I_LT_01_AA_F",1,round (40 / GRLIB_recycling_percentage),2],
	["I_LT_01_cannon_F",1,round (30 / GRLIB_recycling_percentage),2],
	["I_C_Offroad_02_LMG_F",1,round (40 / GRLIB_recycling_percentage),2],
	["I_C_Offroad_02_AT_F",1,round (30 / GRLIB_recycling_percentage),2],
	["I_G_Offroad_01_AT_F",1,round (30 / GRLIB_recycling_percentage),2],
	["I_G_Offroad_01_armed_F",1,round (30 / GRLIB_recycling_percentage),2],
	["I_Truck_02_covered_F",5,round (20 / GRLIB_recycling_percentage),5],
	["I_Truck_02_transport_F",5,round (20 / GRLIB_recycling_percentage),5],
	["I_Boat_Armed_01_minigun_F",2,round (100 / GRLIB_recycling_percentage),2],
	["I_APC_Wheeled_03_cannon_F",15,round (400 / GRLIB_recycling_percentage),15],
	["I_APC_tracked_03_cannon_F",15,round (500 / GRLIB_recycling_percentage),15],
	["I_MBT_03_cannon_F",15,round (800 / GRLIB_recycling_percentage),15],
	["I_Heli_light_03_F",10,round (700 / GRLIB_recycling_percentage),15],
	["I_Heli_Transport_02_F",10,round (500 / GRLIB_recycling_percentage),10],
	["I_Plane_Fighter_03_CAS_F",20,round (1000 / GRLIB_recycling_percentage),30],
	["I_Plane_Fighter_04_F",20,round (1000 / GRLIB_recycling_percentage),30]
];
