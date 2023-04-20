// *** BADDIES ***

if ( isNil "opfor_sentry") then { opfor_sentry = "OPTRE_Ins_BJ_Soldier_Corpsman" };
if ( isNil "opfor_rifleman") then { opfor_rifleman = "OPTRE_Ins_BJ_Soldier_Rifleman_AR" };
if ( isNil "opfor_grenadier") then { opfor_grenadier = "OPTRE_Ins_URF_Breacher" };
if ( isNil "opfor_squad_leader") then { opfor_squad_leader = "OPTRE_Ins_URF_SquadLead" };
if ( isNil "opfor_team_leader") then { opfor_team_leader = "OPTRE_Ins_BJ_Soldier_TeamLeader" };
if ( isNil "opfor_marksman") then { opfor_marksman = "OPTRE_Ins_BJ_Soldier_Marksman" };
if ( isNil "opfor_machinegunner") then { opfor_machinegunner = "OPTRE_Ins_BJ_Soldier_Automatic_Rifleman" };
if ( isNil "opfor_heavygunner") then { opfor_heavygunner = "OPTRE_Ins_BJ_Soldier_Automatic_Rifleman" };
if ( isNil "opfor_medic") then { opfor_medic = "OPTRE_Ins_URF_Medic" };
if ( isNil "opfor_rpg") then { opfor_rpg = "OPTRE_Ins_BJ_Soldier_Rifleman_AT" };
if ( isNil "opfor_at") then { opfor_at = "OPTRE_Ins_URF_AT_Specialist" };
if ( isNil "opfor_aa") then { opfor_aa = "OPTRE_Ins_URF_AA_Specialist" };
if ( isNil "opfor_officer") then { opfor_officer = "OPTRE_Ins_BJ_Soldier_TeamLeader" };
if ( isNil "opfor_sharpshooter") then { opfor_sharpshooter = "OPTRE_Ins_BJ_Soldier_Scout" };
if ( isNil "opfor_sniper") then { opfor_sniper = "OPTRE_Ins_BJ_Soldier_Scout_Sniper" };
if ( isNil "opfor_engineer") then { opfor_engineer = "OPTRE_Ins_BJ_Soldier_Engineer" };
if ( isNil "opfor_paratrooper") then { opfor_paratrooper = "OPTRE_Ins_BJ_Soldier_Rifleman_BR" };
if ( isNil "opfor_mrap") then { opfor_mrap = "OPTRE_M12_FAV_ins" };
if ( isNil "opfor_mrap_armed") then { opfor_mrap_armed = "OPTRE_M12A1_LRV_ins" };
if ( isNil "opfor_transport_helo") then { opfor_transport_helo = "OPTRE_Pelican_armed_ins" };
if ( isNil "opfor_transport_truck") then { opfor_transport_truck = "O_Truck_03_covered_F" };
if ( isNil "opfor_fuel_truck") then { opfor_fuel_truck = "O_Truck_03_fuel_F" };
if ( isNil "opfor_ammo_truck") then { opfor_ammo_truck = "O_Truck_03_ammo_F" };
if ( isNil "opfor_fuel_container") then { opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F" };
if ( isNil "opfor_ammo_container") then { opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F" };
if ( isNil "opfor_flag") then { opfor_flag = "Flag_CSAT_F" };

militia_squad = [
	"OPTRE_Ins_URF_SquadLead",
	"OPTRE_Ins_BJ_Soldier_URB_TeamLeader",
	"OPTRE_Ins_BJ_Soldier_URB_Automatic_Rifleman",
	"OPTRE_Ins_URF_Medic",
	"OPTRE_Ins_BJ_Soldier_URB_Engineer",
	"OPTRE_Ins_BJ_Soldier_URB_Scout",
	"OPTRE_Ins_BJ_Soldier_URB_Corpsman",
	"OPTRE_Ins_BJ_Soldier_URB_Corpsman",
	"OPTRE_Ins_BJ_Soldier_URB_Rifleman_AT",
	"OPTRE_Ins_BJ_Soldier_URB_Rifleman_AR",
	"OPTRE_Ins_BJ_Soldier_URB_Rifleman_BR",
	"OPTRE_Ins_URF_Breacher",
	"OPTRE_Ins_BJ_Soldier_URB_Corpsman",
	"OPTRE_Ins_BJ_Soldier_URB_Marksman",
	"OPTRE_Ins_BJ_Soldier_URB_Scout_Sniper",
	"OPTRE_Ins_URF_AA_Specialist",
	"OPTRE_Ins_URF_AT_Specialist"
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
	"OPTRE_M12A1_LRV_ins",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12_LRV_ins",
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
	"OPTRE_M12R_AA_ins",
	"OPTRE_M12A1_LRV_ins",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12_LRV_ins",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F"
];

opfor_vehicles_low_intensity = [
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"OPTRE_M12_FAV_APC",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12A1_LRV_ins",
	"OPTRE_M12A1_LRV_ins",
	"O_LSV_02_armed_F",
	"O_LSV_02_AT_F"
];

opfor_battlegroup_vehicles = [
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12A1_LRV_ins",
	"OPTRE_M12R_AA_ins",
	"OPTRE_M12_FAV_APC",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_Truck_03_covered_F",
	"O_MBT_02_cannon_F",
	"O_MBT_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"O_Heli_Attack_02_F",
	"OPTRE_UNSC_hornet_ins",
	"OPTRE_UNSC_hornet_ins",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F"
];

opfor_battlegroup_vehicles_low_intensity = [
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12A1_LRV_ins",
	"OPTRE_UNSC_hornet_ins",
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
	"OPTRE_UNSC_hornet_ins",
	"OPTRE_Pelican_armed_ins",
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
	["OPTRE_M12_FAV_ins",0,round (100 / GRLIB_recycling_percentage),0],
	["OPTRE_M12_FAV_APC",0,round (150 / GRLIB_recycling_percentage),0],
	["OPTRE_M12_LRV_ins",0,round (150 / GRLIB_recycling_percentage),0],
	["OPTRE_M12A1_LRV_ins",0,round (150 / GRLIB_recycling_percentage),0],
	["OPTRE_M12R_AA_ins",0,round (250 / GRLIB_recycling_percentage),0],
	["OPTRE_M274_ATV_Ins",0,round (250 / GRLIB_recycling_percentage),0],
	["OPTRE_M914_RV_ins",0,round (250 / GRLIB_recycling_percentage),0],
	["OPTRE_UNSC_hornet_ins",0,round (450 / GRLIB_recycling_percentage),0],
	["OPTRE_Pelican_armed_ins",0,round (550 / GRLIB_recycling_percentage),0],
	["O_LSV_02_armed_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_LSV_02_AT_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_G_Offroad_01_armed_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_G_Offroad_01_AT_F",0,round (20 / GRLIB_recycling_percentage),0],
	["I_C_Offroad_02_LMG_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_Truck_03_covered_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_Truck_03_transport_F",0,round (20 / GRLIB_recycling_percentage),0],
	["OPTRE_M12_LRV_ins",0,round (50 / GRLIB_recycling_percentage),0],
	["OPTRE_M12A1_LRV_ins",0,round (50 / GRLIB_recycling_percentage),0],
	["O_Boat_Armed_01_hmg_F",0,round (100 / GRLIB_recycling_percentage),0],
	["O_T_Boat_Armed_01_hmg_F",0,round (100 / GRLIB_recycling_percentage),0],
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
