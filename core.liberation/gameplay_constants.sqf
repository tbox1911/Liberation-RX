GRLIB_save_key = "GREUH_LIBERATION_Leskovets_saveGame_PSK";
// change this value if you want different saveGames on different map
GRLIB_side_resistance = resistance;
GRLIB_side_civilian = civilian;
GRLIB_respawn_marker = "respawn_west";
GRLIB_sector_size = 600;
GRLIB_capture_size = 400;
GRLIB_radiotower_size = 2500;
GRLIB_spawn_min = 2000;
GRLIB_spawn_max = 4000;
GRLIB_recycling_percentage = 1.00;
GRLIB_endgame = 0;
GRLIB_vulnerability_timer = 1200;
GRLIB_defended_buildingPos_part = 0.5;
GRLIB_sector_military_value = 3;
GRLIB_secondary_objective_impact = 0.4;
GRLIB_blufor_cap = 10 * GRLIB_unitcap;
GRLIB_sector_cap = 150 * GRLIB_unitcap;
GRLIB_battlegroup_cap = 75 * GRLIB_unitcap;
GRLIB_patrol_cap = 75 * GRLIB_unitcap;
GRLIB_battlegroup_size = 7 * (sqrt GRLIB_unitcap) * (sqrt GRLIB_csat_aggressivity);
GRLIB_civilians_amount = 2 * GRLIB_civilian_activity;
GRLIB_fob_range = 450;
GRLIB_surrender_chance = 75;
GRLIB_secondary_missions_costs = [ 50,5 ];
GRLIB_halo_altitude = 2000;
GRLIB_civ_killing_penalty = 0;
GRLIB_squad_size_bonus = 0;
GRLIB_perm_ban = -1000000;
GRLIB_perm_inf = -45;
GRLIB_perm_log = 400;
GRLIB_perm_tank = 800;
GRLIB_perm_air = 1200;
GRLIB_perm_max = 1600;
GRLIB_date_year = 2022;
GRLIB_date_month = 6;
GRLIB_date_day = 30;
GRLIB_nights_start = 21;
GRLIB_nights_stop = 4;
GREUH_start_ammo = 400;

GRLIB_blufor_cap = 64;
// defines if everyone gets ammo from sector liberations
Sector_ammo_for_all = false;

// don't forget that the human commander manages those, not the server
GRLIB_offload_diag = false;

// NRE_Key = 199;
MGR_Key = 19;

// TFAR channel
tfar_channel = "╠-● Ingame [TFAR]";

// gain and punishment
respawn_ammo = 100; // +/- is conditional
opfor_kill_score = 1;
opfor_kill_ammo = 5;
kamikaze_kill_score = 5;
kamikaze_kill_ammo = 25;
civkill_score = -25;
civkill_ammo = -100;
tkill_score = -4;
tkill_ammo = -40;

// Only use by 2 dividable numbers
box_recycle_value = 40;
// Increases the ammo for logistics and decreasese the ammo for everyone
logistics_ammo_increase = true;

prisoner_intel = 15;
prisoner_score = 10;
prisoner_ammo = 35;
ai_value = 35;

// Building Penalty
building_penalty_isActive = false;

// Global arsenal
global_arsenal = true;

// true to activate factions selection
FAC_MSU_ACTIVE = false;

//Differenced Ammo income 
fallback_income = 50;
income_sectors_bigtown = 50;
income_sectors_capture = 50;
income_sectors_military = 50;
income_sectors_factory = 50;
income_sectors_tower = 50;

// AI Leaders have automaticly radios
AI_leader_radio = true;

skill_scan = true;
skill_parachuters = 1;
skill_air_vehicles_planes = 1;
skill_air_vehicles_helicopters = 1;
skill_ground_vehicles = 1;

limit_hc_gr = true;
// Readiness Increase from towns
readiness_calc_bg_town = true;
readiness_calc_sm_town = true;

//Datalink Options
force_datalink = true;
force_sensorTarget_opfor = false;

// Prices for blufor vehicle tiers
light_vehicle_price_hmg = 220;
light_vehicle_price_gmg = 250;
heavy_vehicle_price_tank = 500;
heavy_vehicle_price_tank_light = 1000;
heavy_vehicle_price_tank_heavy = 1500;
logistic_air_vehicle_price = 250;
logistic_ground_vehicle_price = 200;




light_vehicle_price_tier_1 = 50;
light_vehicle_price_tier_2 = 75;
light_vehicle_price_tier_3 = 100;
light_vehicle_price_tier_4 = 125;
light_vehicle_price_tier_5 = 150;
light_vehicle_price_tier_6 = 175;
light_vehicle_price_tier_7 = 200;
light_vehicle_price_tier_8 = 225;
light_vehicle_price_tier_9 = 250;
light_vehicle_price_tier_10 = 275;
light_vehicle_price_tier_11 = 300;
light_vehicle_price_tier_12 = 350;
strong_light_vehicle_price_tier_1 = 100;
strong_light_vehicle_price_tier_2 = 125;
strong_light_vehicle_price_tier_3 = 150;
strong_light_vehicle_price_tier_4 = 175;
strong_light_vehicle_price_tier_5 = 200;
strong_light_vehicle_price_tier_6 = 225;
strong_light_vehicle_price_tier_7 = 250;
strong_light_vehicle_price_tier_8 = 275;
strong_light_vehicle_price_tier_9 = 300;
strong_light_vehicle_price_tier_10 = 325;
strong_light_vehicle_price_tier_11 = 350;
strong_light_vehicle_price_tier_12 = 375;
strong_light_vehicle_price_tier_13 = 400;
strong_light_vehicle_price_tier_14 = 425;
strong_light_vehicle_price_tier_15 = 450;
heavy_vehicle_price_tier_1 = 250;
heavy_vehicle_price_tier_2 = 275;
heavy_vehicle_price_tier_3 = 300;
heavy_vehicle_price_tier_4 = 325;
heavy_vehicle_price_tier_5 = 350;
heavy_vehicle_price_tier_6 = 375;
heavy_vehicle_price_tier_7 = 400;
heavy_vehicle_price_tier_8 = 450;
heavy_vehicle_price_tier_9 = 500;
heavy_vehicle_price_tier_10 = 550;
heavy_vehicle_price_tier_11 = 600;
heavy_vehicle_price_tier_12 = 700;
heavy_vehicle_price_tier_13 = 800;
heavy_vehicle_price_tier_14 = 1000;
heavy_vehicle_price_tier_15 = 1250;
heavy_vehicle_price_tier_16 = 1500;
heavy_vehicle_price_tier_17 = 1750;
strong_heavy_vehicle_price_tier_1 = 1000;
strong_heavy_vehicle_price_tier_2 = 1250;
strong_heavy_vehicle_price_tier_3 = 1500;
strong_heavy_vehicle_price_tier_4 = 1750;
strong_heavy_vehicle_price_tier_5 = 2000;
strong_heavy_vehicle_price_tier_6 = 5000;
strong_heavy_vehicle_price_tier_7 = 7500;
air_vehicle_price_tier_1 = 250;
air_vehicle_price_tier_2 = 275;
air_vehicle_price_tier_3 = 300;
air_vehicle_price_tier_4 = 350;
air_vehicle_price_tier_5 = 400;
air_vehicle_price_tier_6 = 500;
air_vehicle_price_tier_7 = 550;
air_vehicle_price_tier_8 = 800;
air_vehicle_price_tier_9 = 900;
air_vehicle_price_tier_10 = 1000;
air_vehicle_price_tier_11 = 1300;
air_vehicle_price_tier_12 = 1500;
air_vehicle_price_tier_13 = 1800;
air_vehicle_price_tier_14 = 2000;
air_vehicle_price_tier_15 = 4000;
fast_air_vehicle_price_tier_1 = 350;
fast_air_vehicle_price_tier_2 = 1000;
fast_air_vehicle_price_tier_3 = 1250;
fast_air_vehicle_price_tier_4 = 1500;
fast_air_vehicle_price_tier_5 = 1750;
fast_air_vehicle_price_tier_6 = 2000;
fast_air_vehicle_price_tier_7 = 2250;
fast_air_vehicle_price_tier_8 = 2500;
fast_air_vehicle_price_tier_9 = 2750;
fast_air_vehicle_price_tier_10 = 3000;
logistic_ground_vehicle_price_tier_1 = 250;
logistic_ground_vehicle_price_tier_2 = 300;
logistic_ground_vehicle_price_tier_3 = 400;

items_allFac = [
    "U_B_FullGhillie_lsh",
    "U_B_FullGhillie_sard",
    "U_B_GhillieSuit",
    "U_B_T_FullGhillie_tna_F",
    "U_B_T_Sniper_F",
    "U_B_Wetsuit",
    "U_B_pilotCoveralls",
    "H_pilotHelmetFighter_B",
    "H_pilotHelmetHeli_B",
    "V_RebreatherB"
];

item_blacklist =
[
    "B_UavTerminal",
    "O_UavTerminal",
    "I_UavTerminal",
    "C_UavTerminal",
    "I_UAV_06_backpack_F",
    "O_UAV_06_backpack_F",
    "B_UAV_06_backpack_F",
    "I_UAV_06_medical_backpack_F",
    "O_UAV_06_medical_backpack_F",
    "C_IDAP_UAV_06_medical_backpack_F",
    "B_UAV_06_medical_backpack_F",
    "I_UAV_01_backpack_F",
    "O_UAV_01_backpack_F",
    "B_UAV_01_backpack_F",
    "C_IDAP_UAV_06_antimine_backpack_F",
    "C_UAV_06_backpack_F",
    "C_IDAP_UAV_06_backpack_F",
    "C_UAV_06_medical_backpack_F",
    "C_IDAP_UAV_01_backpack_F",
    "I_E_UAV_06_backpack_F",
    "I_E_UAV_06_medical_backpack_F",
    "I_E_UAV_01_backpack_F",
    "launch_I_Titan_eaf_F",
    "launch_B_Titan_olive_F",
    "launch_B_Titan_tna_F",
    "launch_B_Titan_short_tna_F",
    "launch_O_Titan_ghex_F",
    "launch_O_Titan_short_ghex_F",
    "launch_B_Titan_F",
    "launch_I_Titan_F",
    "launch_O_Titan_F",
    "launch_Titan_F",
    "launch_B_Titan_short_F",
    "launch_I_Titan_short_F",
    "launch_O_Titan_short_F",
    "launch_Titan_short_F",
    "B_Static_Designator_01_weapon_F",
    "B_W_Static_Designator_01_weapon_F",
    "O_Static_Designator_02_weapon_F",
    "B_UGV_02_Science_backpack_F",
    "O_UGV_02_Science_backpack_F",
    "I_UGV_02_Science_backpack_F",
    "B_UGV_02_Demining_backpack_F",
    "O_UGV_02_Demining_backpack_F",
    "I_UGV_02_Demining_backpack_F",
    "land_Tentdome_F",
    "B_Respawn_sleeping_bag_blue_F",
    "B_Respawn_sleeping_bag_brown_F",
    "B_Respawn_Tentdome_F",
    "B_Respawn_sleeping_bag_F",
    "B_Respawn_TentA_F",
    "B_Patrol_Respawn_bag_F",
    "B_Patrol_Respawn_tent_F",
    "B_HMG_01_support_F",
    "O_HMG_01_support_F",
    "I_HMG_01_support_F",
    "B_HMG_01_support_high_F",
    "O_HMG_01_support_high_F",
    "I_HMG_01_support_high_F",
    "I_HMG_01_A_weapon_F",
    "B_HMG_01_A_weapon_F",
    "O_HMG_01_A_weapon_F",
    "O_HMG_01_weapon_F",
    "B_HMG_01_weapon_F",
    "I_HMG_01_weapon_F",
    "I_HMG_01_high_weapon_F",
    "O_HMG_01_high_weapon_F",
    "B_HMG_01_high_weapon_F",
    "B_HMG_01_support_grn_F",
    "B_HMG_01_Weapon_grn_F",
    "B_HMG_02_high_weapon_F",
    "B_G_HMG_02_high_weapon_F",
    "I_HMG_02_high_weapon_F",
    "O_HMG_02_high_weapon_F",
    "B_HMG_02_support_F",
    "B_G_HMG_02_support_F",
    "I_HMG_02_support_F",
    "O_HMG_02_support_F",
    "B_HMG_02_support_high_F",
    "B_G_HMG_02_support_high_F",
    "I_HMG_02_support_high_F",
    "O_HMG_02_support_high_F",
    "B_HMG_02_weapon_F",
    "B_G_HMG_02_weapon_F",
    "I_HMG_02_weapon_F",
    "O_HMG_02_weapon_F",
    "I_GMG_01_A_weapon_F",
    "O_GMG_01_A_weapon_F",
    "B_GMG_01_A_weapon_F",
    "O_GMG_01_weapon_F",
    "I_GMG_01_weapon_F",
    "B_GMG_01_weapon_F",
    "B_GMG_01_high_weapon_F",
    "I_GMG_01_high_weapon_F",
    "O_GMG_01_high_weapon_F",
    "I_Mortar_01_support_F",
    "B_Mortar_01_support_F",
    "O_Mortar_01_support_F",
    "B_Mortar_01_weapon_F",
    "O_Mortar_01_weapon_F",
    "I_Mortar_01_weapon_F",
    "B_AA_01_weapon_F",
    "O_AA_01_weapon_F",
    "I_AA_01_weapon_F",
    "B_AT_01_weapon_F",
    "O_AT_01_weapon_F",
    "I_AT_01_weapon_F",
    "I_UAV_01_backpack_F",
    "B_UAV_01_backpack_F",
    "O_UAV_01_backpack_F",
    "B_Mortar_01_support_grn_F",
    "B_GMG_01_Weapon_grn_F",
    "B_Mortar_01_Weapon_grn_F",
    "B_Protagonist_VR_F",
    "U_B_Protagonist_VR",
    "O_Protagonist_VR_F",
    "U_O_Protagonist_VR",
    "I_Protagonist_VR_F",
    "U_I_Protagonist_VR",
    "C_Protagonist_VR_F",
    "TFAR_rf7800str",
    "C_UavTerminal",
    "I_E_UavTerminal",
    "O_UavTerminal",
    "TFAR_pnr1000a",
    "TFAR_pnr1000a",
    "TFAR_fadak",
    "I_UavTerminal",
    "TFAR_anprc154",
    "TFAR_anprc148jem",
    "U_C_Protagonist_VR",
    "optic_Nightstalker",
    "optic_tws",
    "optic_tws_mg",
    "optic_NVS",
    "NVgoggles_tna_F",
    "NVgogglesB_blk_F",
    "NVgogglesB_grn_F",
    "NVgogglesB_gry_F",
    "H_Helmeto_ViperSP_hex_F",
    "H_Helmeto_ViperSP_ghex_F",
    "U_O_V_Soldier_Viper_hex_F",
    "U_O_V_Soldier_Viper_F",
    "O_V_Soldier_Viper_F",
    "CUP_U_C_Priest_01",
    "CUP_launch_Javelin",
    "CUP_Javelin_M",
    "arifle_ARX_blk_F",
    "arifle_ARX_hex_F",
    "arifle_ARX_ghex_F",
    "CUP_arifle_type_56_2_Early",
    "CUP_arifle_type_56_2",
    "CUP_arifle_type_56_2_top_rail",
    "CUP_lmg_UK59",
    "CUP_sgun_slamfire",
    "CUP_arifle_Sa58_Carbine_RIS_AFG",
    "CUP_arfile_Sa58_Carbine_RIS_AFG_desert",
    "CUP_arfile_Sa58_Carbine_RIS_AFG_woodland",
    "CUP_arifle_Sa58_Carbine_RIS_VFG",
    "CUP_arifle_Sa58_Carbine_RIS_VFG_desert",
    "CUP_arifle_Sa58_Carbine_RIS_VFG_woodland",
    "CUP_arifle_Sa58_sporter_compact",
    "CUP_arifle_Sa58_sporter_compact_rearris",
    "CUP_arifle_Sa58P",
    "CUP_arifle_Sa58P_des",
    "CUP_arifle_Sa58P_rearris",
    "CUP_arifle_Sa58P_frontris",
    "CUP_arifle_Sa58P_frontris_desert",
    "CUP_arifle_Sa58P_frontris_woodland",
    "CUP_arifle_Sa58P_RIS1",
    "CUP_arifle_Sa58P_wood",
    "CUP_arifle_Sa58P_woodland",
    "CUP_arifle_Sa58pi",
    "CUP_arifle_Sa58s",
    "CUP_arifle_Sa58s_rearris",
    "CUP_arifle_Sa58V",
    "CUP_arifle_Sa58V_camo",
    "CUP_arifle_Sa58V_rearris",
    "CUP_arifle_Sa58V_frontris",
    "CUP_arifle_Sa58RIS1",
    "CUP_arifle_Sa58RIS1_des",
    "CUP_arifle_Sa58RIS1_woodland",
    "CUP_arifle_Sa58V_wood",
    "CUP_arifle_Sa58V_woodland",
    "CUP_arifle_Sa58RIS2",
    "CUP_arifle_Sa58RIS2_camo",
    "CUP_arifle_Sa58RIS2_woodland",
    "CUP_arifle_Sa58RIS2_gl",
    "CUP_arifle_Sa58RIS2_gl_desert",
    "CUP_arifle_Sa58RIS2_gl_woodland",
    "CUP_smg_SA61",
    "CUP_smg_SA61_RIS",
    "CUP_arifle_Sa58_Klec",
    "CUP_arifle_Sa58_Klec_rearris",
    "CUP_arifle_Sa58_Klec_frontris",
    "CUP_arifle_Sa58_Klec_ris",
    "O_V_Soldier_Viper_hex_F",
    "ffaa_spike_tripode_Bag",
    "Redd_Tank_M120_Tampella_Tripod",
    "Redd_Tank_M120_Tampella_Barrel",
    "rnt_mg3_static_barell_ai",
    "rnt_mg3_static_tripod_ai",
    "H_HelmetO_ViperSP_ghex_F",
    "H_HelmetO_ViperSP_hex_F"
];

moderators = [
    "76561197997804176", // slotzi
    "76561198019854511", // Voltaren
    "76561198094301584",  // Devin
    "76561198132964589"   // Sound_wave
];
