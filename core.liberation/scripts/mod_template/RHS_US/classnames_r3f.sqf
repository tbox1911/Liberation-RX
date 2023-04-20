//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"Air"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
	huron_typename_west,
	huron_typename_east,
	"B_Heli_Light_01_F",
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Transport_04_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Light_02_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_F",
	"B_Heli_Transport_03_F",
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_01_camo_F",
	"B_Heli_Attack_01_F",
	"I_Heli_light_03_unarmed_F",
	"I_Heli_light_03_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"Slingload_01_Base_F",
	"Pod_Heli_Transport_04_base_F"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	[huron_typename_west, 200],
	[huron_typename_east, 200],
	["RHS_Mi8mt_Cargo_vdv", 350],
	["RHS_Mi8T_vdv", 350],
	["RHS_Mi24P_vdv", 250],
	["RHS_Mi24V_vdv", 250],
	["RHS_Mi8MTV3_vdv", 250],
	["RHS_Mi8mtv3_Cargo_vdv", 350],
	["RHS_Mi8MTV3_heavy_vdv", 350],
	["RHS_Ka52_vvsc", 150],
	["rhs_mi28n_vvsc", 50],
	["RHS_UH1Y_UNARMED", 150],
	["RHS_UH1Y_FFAR", 150],
	["RHS_UH1Y", 150],
	["RHS_MELB_AH6M", 150],
	["RHS_UH60M", 250],
	["RHS_CH_47F_10_cargo", 500],
	["rhsusf_CH53e_USMC_cargo", 700],
	["rhsusf_CH53E_USMC_GAU21", 700],
	["RHS_C130J_Cargo", 1550],
	["RHS_C130J", 1550],
	["B_Heli_Light_01_F", 10],
	["B_Heli_Light_01_armed_F", 10],
	["O_Heli_Light_02_unarmed_F", 50],
	["B_Heli_Attack_01_F", 25],
	["I_Heli_light_03_unarmed_F", 50],
	["B_Heli_Transport_01_F", 100],
	["B_Heli_Transport_01_camo_F", 100],
	["B_Heli_Transport_03_F", 150],
	["O_Heli_Attack_02_F", 150],
	["O_Heli_Light_02_dynamicLoadout_F", 100],
	["O_Heli_Attack_02_dynamicLoadout_F", 100],
	["O_Heli_Transport_04_F", 150],
	["B_Heli_Transport_03_unarmed_F", 200],
	["I_Heli_light_03_F",100],
	["B_T_VTOL_01_infantry_F", 100],
	["B_T_VTOL_01_vehicle_F", 100],
	["B_T_VTOL_01_armed_F", 100],
	["O_T_VTOL_01_infantry_F", 100],
	["O_T_VTOL_01_vehicle_F", 100],
	["O_T_VTOL_01_armed_F", 100],
	["C_UAV_06_F", 7],
	["B_UAV_01_F", 0],
	["B_UAV_05_F", 0],
	["B_UAV_06_F", 7],
	["B_UAV_02_dynamicLoadout_F", 0],
	["B_T_UAV_03_dynamicLoadout_F", 0],
	["B_UGV_01_F", 10],
	["B_UGV_01_rcws_F", 10],
	["B_UGV_02_Demining_F", 0],
	["O_UAV_01_F", 0],
	["O_UAV_06_F", 7],
	["O_UAV_02_dynamicLoadout_F", 0],
	["O_T_UAV_04_CAS_F", 0],
	["O_UGV_01_F", 10],
	["O_UGV_01_rcws_F", 10],
	["O_UGV_02_Demining_F", 10]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["C_UAV_06_F", 3],
	["B_UAV_01_F", 3],
	["B_UAV_02_dynamicLoadout_F", 20],
	["B_UAV_05_F", 50],
	["B_UAV_06_F", 3],
	["B_T_UAV_03_dynamicLoadout_F", 50],
	["O_UAV_01_F", 3],
	["O_UAV_02_dynamicLoadout_F", 20],
	["O_T_UAV_04_CAS_F", 30],
	["O_UAV_06_F", 3]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"C_UAV_06_F",
	"B_UAV_01_F",
	"B_UAV_05_F",
	"B_UAV_06_F",
	"B_UAV_02_dynamicLoadout_F",
	"B_T_UAV_03_dynamicLoadout_F",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F",
	"O_UAV_01_F",
	"O_UAV_06_F",
	"O_UAV_02_dynamicLoadout_F",
	"O_T_UAV_04_CAS_F",
	"O_UGV_01_F",
	"O_UGV_01_rcws_F",
	"O_UGV_02_Demining_F"
];

//--------------- Ground ---------------

R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
	"Tank_F",
	"Truck_F",
	"Hatchback_01_base_F",
	"Offroad_01_base_F",
	"Offroad_02_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"LSV_01_base_F",
	"LSV_02_base_F",
	"Wheeled_APC_F",
	"Van_01_base_F"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"Quadbike_01_base_F",
	//"Tank_F",
		"MBT_01_base_F",
		"MBT_02_base_F",
		"MBT_03_base_F",
		"MBT_04_base_F",
		//"APC_Tracked_01_base_F",
			"B_APC_Tracked_01_rcws_F",
			//"B_APC_Tracked_01_CRV_F",
			"B_APC_Tracked_01_AA_F",
		"APC_Tracked_02_base_F",
		"APC_Tracked_03_base_F",
		"LT_01_base_F",
	"Truck_F",
	"Hatchback_01_base_F",
	"SUV_01_base_F",
	//"Offroad_01_base_F",
		"Offroad_01_unarmed_base_F",
		//"Offroad_01_repair_base_F",
	    "Offroad_01_military_base_F",
	"Offroad_02_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"LSV_01_base_F",
	"LSV_02_base_F",
	"Wheeled_APC_F",
	"UGV_01_base_F",
	"Van_01_base_F"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"Tank_F",
	"Truck_F",
	"Hatchback_01_base_F",
	"SUV_01_base_F",
	"Offroad_01_base_F",
	"Offroad_02_base_F",
	"MRAP_01_base_F",
	"MRAP_02_base_F",
	"MRAP_03_base_F",
	"LSV_01_base_F",
	"LSV_02_base_F",
	"Wheeled_APC_F",
	"UGV_01_base_F",
	"Van_01_base_F"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["Quadbike_01_base_F", 3],
	["rhs_tigr_msv", 50],
	["rhs_tigr_3camo_msv", 50],
	["rhs_tigr_sts_3camo_msv", 50],
	["rhs_tigr_sts_msv", 50],
	["rhs_gaz66_vv", 70],
	["rhs_kamaz5350_vv", 150],
	["rhs_kamaz5350_open_vv", 150],
	["RHS_Ural_VV_01", 250],
	["RHS_Ural_Open_VV_01", 250],
	["rhs_btr80_msv", 25],
	["rhs_btr80a_msv", 25],
	["RHS_Ural_Zu23_VV_01", 20],
	["rhs_bmp1p_msv", 150],
	["rhs_bmp2k_msv", 150],
	["rhs_brm1k_msv", 150],
	["rhs_bmp1_msv", 150],
	["rhs_Ob_681_2", 50],
	["rhs_prp3_msv", 50],
	["rhs_bmd2m", 50],
	["rhs_t72ba_tv", 50],
	["rhs_t72bb_tv", 50],
	["rhs_t72bc_tv", 50],
	["rhs_t80", 50],
	["rhs_t80a", 50],
	["rhs_t80b", 50],
	["rhs_t80bk", 50],
	["rhs_t80bv", 50],
	["rhs_t90sm_tv", 50],
	["rhs_t90am_tv", 50],
	["rhs_t90_tv", 50],
	["rhs_t90a_tv", 50],
	["rhs_t90saa_tv", 50],
	["rhs_zsu234_aa", 50],
	["rhs_t14_tv", 50],
	["rhs_9k79_K", 50],
	["RHS_BM21_MSV_01", 50],
	["rhs_t15_tv", 50],
	["rhs_gaz66_ammo_vv", 150],
	["rhs_kamaz5350_ammo_vv", 150],
	["RHS_Ural_Ammo_VV_01", 150],
	["rhs_gaz66_ap2_msv", 250],
	["rhsusf_m1025_w_m2", 150],
	["rhsusf_m1025_w_mk19", 150],
	["rhsusf_m1045_w", 150],
	["rhsusf_M1078A1R_SOV_M2_D_fmtv_socom", 150],
	["rhsusf_m1151_m2crows_usarmy_wd", 150],
	["rhsusf_m1151_mk19crows_usarmy_wd", 150],
	["rhsusf_m1151_m2_v1_usarmy_wd", 150],
	["rhsusf_m1151_m2_lras3_v1_usarmy_wd", 150],
	["rhsusf_m1151_m240_v1_usarmy_wd", 150],
	["rhsusf_m1151_mk19_v2_usarmy_wd", 150],
	["rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy", 150],
	["rhsusf_M1117_W", 150],
	["rhsusf_M1220_M153_M2_usarmy_wd", 150],
	["rhsusf_M1220_M2_usarmy_wd", 150],
	["rhsusf_M1220_MK19_usarmy_wd", 150],
	["rhsusf_M1230_M2_usarmy_wd", 150],
	["rhsusf_M1237_M2_usarmy_wd", 150],
	["rhsusf_m1240a1_m2_usarmy_wd", 150],
	["rhsusf_m1240a1_m240_usarmy_wd", 150],
	["rhsusf_m1240a1_mk19_usarmy_wd", 150],
	["rhsusf_m1240a1_m2_uik_usarmy_wd", 150],
	["rhsusf_m1165a1_gmv_mk19_m240_socom_d", 150],
	["rhsusf_m1165a1_gmv_m2_m240_socom_d", 150],
	["rhsusf_stryker_m1126_m2_wd", 250],
	["rhsusf_stryker_m1126_mk19_wd", 250],
	["rhsusf_stryker_m1134_wd", 250],
	["rhsusf_M1078A1P2_WD_fmtv_usarmy", 150],
	["rhsusf_M1078A1P2_B_WD_fmtv_usarmy", 150],
	["rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy", 150],
	["rhsusf_M1083A1P2_WD_fmtv_usarmy", 150],
	["rhsusf_M1083A1P2_B_WD_fmtv_usarmy", 150],
	["rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy", 150],
	["rhsusf_M1084A1P2_WD_fmtv_usarmy", 150],
	["rhsusf_M1084A1P2_B_WD_fmtv_usarmy", 150],
	["rhsusf_M1084A1P2_B_M2_WD_fmtv_usarmy", 150],
	["rhsusf_M977A4_usarmy_wd", 150],
	["rhsusf_M977A4_BKIT_usarmy_wd", 150],
	["rhsusf_M977A4_BKIT_M2_usarmy_wd", 150],
	["RHS_M2A2_wd", 150],
	["RHS_M2A2_BUSKI_WD", 150],
	["RHS_M2A3_wd", 150],
	["RHS_M2A3_BUSKI_wd", 150],
	["RHS_M2A3_BUSKIII_wd", 150],
	["RHS_M6_wd", 150],
	["rhsusf_m1a1aimwd_usarmy", 150],
	["rhsusf_m1a1aim_tuski_wd", 150],
	["rhsusf_m1a2sep1wd_usarmy", 150],
	["rhsusf_m1a2sep1tuskiwd_usarmy", 150],
	["rhsusf_m1a2sep1tuskiiwd_usarmy", 150],
	["rhsusf_m1a2sep2wd_usarmy", 150],
	["rhsusf_m1a1fep_wd", 150],
	["rhsusf_m1a1fep_od", 150],
	["rhsusf_m1a1hc_wd", 150],
	["rhsusf_M142_usmc_WD", 150],
	["rhsusf_m109_usarmy", 150],
	["Tank_F", 50],
	["Truck_F", 100],
	["Hatchback_01_base_F", 5],
	["SUV_01_base_F", 5],
	["Offroad_01_base_F", 10],
	["Offroad_02_base_F", 10],
	["Offroad_01_repair_base_F", 7],
	["MRAP_01_base_F", 15],
	["MRAP_02_base_F", 15],
	["MRAP_03_base_F", 15],
	["LSV_01_base_F", 7],
	["LSV_02_base_F", 7],
	["Wheeled_APC_F", 30],
	["Van_01_base_F", 30],
	["Van_01_box_base_F", 50]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["Quadbike_01_base_F", 10]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"Quadbike_01_base_F"
];

//--------------- Ship ---------------

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["Boat_Armed_01_base_F", 40],
	["Rubber_duck_base_F",10],
	["SDV_01_base_F", 10],
	["C_Boat_Transport_02_F",30],
  	["Boat_Civil_01_base_F",20]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_Boat_Transport_01_F", 5],
	["C_Scooter_Transport_01_F", 5],
	["B_SDV_01_F", 50]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"Ship_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"Ship_F"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"Ship_F"
];

//--------------- Building ---------------
R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	[FOB_box_typename_west, 0],
	[FOB_box_typename_east, 0],
  	[FOB_truck_typename_west, 0],
  	[FOB_truck_typename_east, 0],
	[ammo_truck_typename_west, 0],
	[ammo_truck_typename_east, 0],
	[fuel_truck_typename_west, 0],
	[fuel_truck_typename_east, 0],
	[repair_truck_typename_west, 0],
	[repair_truck_typename_east, 0]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	[mobile_respawn, 2],
	[Arsenal_typename, 5],
	[FOB_box_typename_west, 50],
	[FOB_box_typename_east, 50],
	[ammobox_b_typename, 15],
	[ammobox_o_typename, 15],
	[ammobox_i_typename, 15],
	[waterbarrel_typename, 10],
	[fuelbarrel_typename, 10],
	[foodbarrel_typename, 10],
	[medicalbox_typename, 2],
	[repair_sling_typename_west, 25],
	[fuel_sling_typename_west, 25],
	[ammo_sling_typename_west, 25],
	[medic_sling_typename_west, 25],
	[repair_sling_typename_east, 25],
	[fuel_sling_typename_east, 25],
	[ammo_sling_typename_east, 25],
	[medic_sling_typename_east, 25],
	[A3W_BoxWps, 7],
	[canisterFuel, 1],
	["Land_PierLadder_F", 2],
    ["Box_NATO_WpsLaunch_F",3],
	["Land_CargoBox_V1_F", 20]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	mobile_respawn,
	Arsenal_typename,
	FOB_box_typename_west,
	FOB_box_typename_east,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	medicalbox_typename,
	repair_sling_typename_west,
	fuel_sling_typename_west,
	ammo_sling_typename_west,
	medic_sling_typename_west,
	repair_sling_typename_east,
	fuel_sling_typename_east,
	ammo_sling_typename_east,
	medic_sling_typename_east,
	A3W_BoxWps,
	canisterFuel,
	"Land_Pod_Heli_Transport_04_bench_F",
	"Land_Pod_Heli_Transport_04_covered_F",
	"Land_PierLadder_F",
    "Box_NATO_WpsLaunch_F",
	"Land_CargoBox_V1_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_House_V3_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Tower_F",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_BLUFOR_big_F",
	"Land_CncShelter_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	Arsenal_typename
];
//--------------- Static ---------------

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_Static_Designator_01_F",3],
	["B_HMG_01_F",5],
	["B_HMG_01_high_F",5],
	["B_GMG_01_F",5],
	["B_GMG_01_high_F",5],
	["B_static_AA_F",10],
	["B_static_AT_F",10],
	["B_Mortar_01_F",10],
	["I_Static_Designator_01_F",3],
	["I_HMG_01_F",5],
	["I_HMG_01_high_F",5],
	["I_GMG_01_F",5],
	["I_GMG_01_high_F",5],
	["I_static_AA_F",10],
	["I_static_AT_F",10],
	["I_Mortar_01_F",10],
	["O_Static_Designator_01_F",3],
	["O_HMG_01_F",5],
	["O_HMG_01_high_F",5],
	["O_GMG_01_F",5],
	["O_GMG_01_high_F",5],
	["O_static_AA_F",10],
	["O_static_AT_F",10],
	["O_Mortar_01_F",10],
	["Land_CzechHedgehog_01_new_F", 5]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"StaticMGWeapon",
	"StaticGrenadeLauncher",
	"StaticMortar",
	"Land_CzechHedgehog_01_new_F"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"Land_Suitcase_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncWall1_F",
	"Land_BagFence_Round_F",
	"Land_BagFence_Long_F",
	"Land_BagFence_Short_F",
	"Land_BagFence_Corner_F",
	"Land_CncShelter_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_House_V3_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_PortableLight_double_F",
	"Flag_NATO_F",
	"Land_HelipadSquare_F",
	"Land_Razorwire_F",
	"Land_ToolTrolley_02_F",
	"Land_WeldingTrolley_01_F",
	"Land_GasTank_02_F",
	"Land_Workbench_01_F",
	"Land_WaterTank_F",
	"Land_WaterBarrel_F",
	"Land_BarGate_F",
	"Land_MetalCase_01_large_F",
	"CargoNet_01_box_F",
	"Land_CampingChair_V1_F",
	"Land_CampingChair_V2_F",
	"Land_CampingTable_F",
	"MapBoard_altis_F",
	"Land_Metal_rack_Tall_F",
	"PortableHelipadLight_01_blue_F",
	"Land_DieselGroundPowerUnit_01_F",
	"Land_Pallet_MilBoxes_F",
	"Land_PaperBox_open_full_F",
	"Land_ClutterCutter_large_F"
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["Land_Suitcase_F", 1],
	["Land_CncBarrierMedium4_F", 5],
	["Land_CncWall1_F", 5],
	["Land_BagFence_Round_F", 5],
	["Land_BagFence_Long_F", 5],
	["Land_BagFence_Short_F", 5],
	["Land_BagFence_Corner_F", 5],
	["Land_CncShelter_F", 5],
	["Land_Cargo_House_V1_F", 5],
	["Land_Cargo_Patrol_V1_F", 5],
	["Land_Cargo_House_V3_F", 5],
	["Land_Cargo_Patrol_V3_F", 5],
	["Land_PortableLight_double_F", 5],
	["Flag_NATO_F", 5],
	["Land_HelipadSquare_F", 5],
	["Land_Razorwire_F", 5],
	["Land_ToolTrolley_02_F", 5],
	["Land_WeldingTrolley_01_F", 5],
	["Land_GasTank_02_F", 5],
	["Land_Workbench_01_F", 5],
	["Land_WaterTank_F", 5],
	["Land_WaterBarrel_F", 5],
	["Land_BarGate_F", 5],
	["Land_MetalCase_01_large_F", 5],
	["CargoNet_01_box_F", 5],
	["Land_CampingChair_V1_F", 5],
	["Land_CampingChair_V2_F", 5],
	["Land_CampingTable_F", 5],
	["MapBoard_altis_F", 5],
	["Land_Metal_rack_Tall_F", 5],
	["PortableHelipadLight_01_blue_F", 5],
	["Land_DieselGroundPowerUnit_01_F", 5],
	["Land_Pallet_MilBoxes_F", 5],
	["Land_PaperBox_open_full_F", 5],
	["Land_ClutterCutter_large_F", 5]
];
