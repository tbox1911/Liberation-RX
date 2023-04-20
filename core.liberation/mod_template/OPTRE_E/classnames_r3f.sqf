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
	"I_Heli_light_03_unarmed_F",
	"O_Heli_Light_02_unarmed_F",
	"B_Heli_Transport_03_F",
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_01_camo_F",
	"I_Heli_light_03_F",
	"B_Heli_Attack_01_F",
	"OPTRE_UNSC_hornet_ins",
	"OPTRE_Pelican_armed_ins",
	"OPTRE_UNSC_hornet_CAP",
	"OPTRE_UNSC_hornet_CAS",
	"OPTRE_UNSC_falcon",
	"OPTRE_AV22_Sparrowhawk",
	"OPTRE_AV22A_Sparrowhawk",
	"OPTRE_AV22B_Sparrowhawk",
	"OPTRE_AV22C_Sparrowhawk"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["B_Heli_Light_01_F", 10],
	["B_Heli_Light_01_armed_F", 10],
	["O_Heli_Light_02_unarmed_F", 50],
	["B_Heli_Attack_01_F", 25],
	["I_Heli_light_03_unarmed_F", 50],
	["B_Heli_Transport_01_F", 100],
	["B_Heli_Transport_01_camo_F", 100],
	["B_Heli_Transport_03_F", 150],
	["B_Heli_Transport_03_unarmed_F", 200],
	["I_Heli_light_03_F",100],
	["B_T_VTOL_01_infantry_F", 100],
	["B_T_VTOL_01_vehicle_F", 100],
	["B_UAV_01_F", 0],
	["B_UAV_02_F", 0],
	["B_UAV_06_F", 3],
	["B_UGV_02_Demining_F", 0],
	["B_T_UAV_03_F", 15],
	["OPTRE_UNSC_hornet_ins", 50],
	["OPTRE_Pelican_armed_ins", 200],
	["OPTRE_Pelican_unarmed", 200],
	["OPTRE_UNSC_hornet_CAP", 50],
	["OPTRE_UNSC_hornet_CAS", 50],
	["OPTRE_UNSC_falcon", 50],
	["OPTRE_AV22_Sparrowhawk", 50],
	["OPTRE_AV22A_Sparrowhawk", 50],
	["OPTRE_AV22B_Sparrowhawk", 50],
	["OPTRE_AV22C_Sparrowhawk", 50]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_UAV_01_F", 3],
	["B_UAV_06_F", 3],
	["B_UGV_02_Demining_F", 5],
	["B_UAV_02_F", 30]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"B_UAV_01_F",
	"B_UAV_02_F",
	"B_UAV_06_F",
	"B_UGV_02_Demining_F"
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
	"Van_01_base_F",
	"OPTRE_M12_FAV",
	"OPTRE_M12_FAV_ins",
	"OPTRE_M12_FAV_APC",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12A1_LRV_ins",
	"OPTRE_M12R_AA_ins",
	"OPTRE_M274_ATV_Ins",
	"OPTRE_M914_RV_ins",
	"OPTRE_M813_TT",
	"OPTRE_M914_RV",
	"OPTRE_M12_LRV",
	"OPTRE_M12G1_LRV",
	"OPTRE_M12R_AA"
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
	"Van_01_base_F",
	"OPTRE_M12_FAV",
	"OPTRE_M12_FAV_ins",
	"OPTRE_M12_FAV_APC",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12A1_LRV_ins",
	"OPTRE_M12R_AA_ins",
	"OPTRE_M274_ATV_Ins",
	"OPTRE_M914_RV_ins",
	"OPTRE_M813_TT",
	"OPTRE_M914_RV",
	"OPTRE_M12_LRV",
	"OPTRE_M12G1_LRV",
	"OPTRE_M12R_AA"
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
	"Van_01_base_F",
	"OPTRE_M12_FAV",
	"OPTRE_M12_FAV_ins",
	"OPTRE_M12_FAV_APC",
	"OPTRE_M12_LRV_ins",
	"OPTRE_M12A1_LRV_ins",
	"OPTRE_M12R_AA_ins",
	"OPTRE_M274_ATV_Ins",
	"OPTRE_M914_RV_ins",
	"OPTRE_M813_TT",
	"OPTRE_M914_RV",
	"OPTRE_M12_LRV",
	"OPTRE_M12G1_LRV",
	"OPTRE_M12R_AA"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["Quadbike_01_base_F", 3],
	["Tank_F", 50],
	["Truck_F", 100],
	["C_Offroad_01_repair_F", 25],
	["Hatchback_01_base_F", 5],
	["SUV_01_base_F", 5],
	["Offroad_01_base_F", 7],
	["Offroad_02_base_F", 7],
	["MRAP_01_base_F", 15],
	["MRAP_02_base_F", 15],
	["MRAP_03_base_F", 15],
	["LSV_01_base_F", 7],
	["LSV_02_base_F", 7],
	["Wheeled_APC_F", 30],
	["Van_01_base_F", 25],
	["Van_01_box_base_F", 50],
	["OPTRE_M12_FAV", 50],
	["OPTRE_M12_FAV_ins", 50],
	["OPTRE_M12_FAV_APC", 50],
	["OPTRE_M12_LRV_ins", 50],
	["OPTRE_M12A1_LRV_ins", 50],
	["OPTRE_M12R_AA_ins", 50],
	["OPTRE_M274_ATV_Ins", 50],
	["OPTRE_M914_RV_ins", 50],
	["OPTRE_M813_TT", 50],
	["OPTRE_M914_RV", 50],
	["OPTRE_M12_LRV", 50],
	["OPTRE_M12G1_LRV", 50],
	["OPTRE_M12R_AA", 50]
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
	[FOB_box_typename, 0],
  	[FOB_truck_typename, 0],
	["B_Truck_01_ammo_F", 0],
	["B_Truck_01_Repair_F", 0],
	["B_Truck_01_fuel_F", 0]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	[mobile_respawn, 2],
	[Arsenal_typename, 5],
	[FOB_box_typename, 50],
	[ammobox_b_typename, 15],
	[ammobox_o_typename, 15],
	[ammobox_i_typename, 15],
	[A3W_BoxWps, 7],
	["Land_PierLadder_F", 2],
	["Box_NATO_Ammo_F",3],
    ["Box_NATO_WpsLaunch_F",3],
	["Land_CargoBox_V1_F", 20],
	["Land_CanisterFuel_Red_F", 1],
	["Box_B_UAV_06_medical_F", 2],
	["B_Slingload_01_Cargo_F", 50],
	["B_Slingload_01_Repair_F", 25],
	["B_Slingload_01_Fuel_F", 25],
	["B_Slingload_01_Ammo_F", 25],
	["B_Slingload_01_Medevac_F", 25]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	mobile_respawn,
	Arsenal_typename,
	FOB_box_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	A3W_BoxWps,
	"Land_PierLadder_F",
	"Land_CanisterFuel_Red_F",
	"Box_B_UAV_06_medical_F",
	"Box_NATO_Ammo_F",
    "Box_NATO_WpsLaunch_F",
	"Land_CargoBox_V1_F",
	"B_Slingload_01_Cargo_F",
	"B_Slingload_01_Repair_F",
	"B_Slingload_01_Fuel_F",
	"B_Slingload_01_Ammo_F",
	"B_Slingload_01_Medevac_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Tower_F",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_BLUFOR_big_F",
	"Land_CncShelter_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];
//--------------- Static ---------------

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_Static_Designator_01_F",5],
	["B_HMG_01_F",5],
	["B_HMG_01_high_F",5],
	["B_GMG_01_F",5],
	["B_GMG_01_high_F",5],
	["B_static_AA_F",10],
	["B_static_AT_F",10],
	["B_Mortar_01_F",10]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"B_Static_Designator_01_F",
	"B_HMG_01_F",
	"B_HMG_01_high_F",
	"B_GMG_01_F",
	"B_GMG_01_high_F",
	"B_static_AA_F",
	"B_static_AT_F",
	"B_Mortar_01_F",
	"B_AAA_System_01_F",
	"B_Ship_Gun_01_F"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];
