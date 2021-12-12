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
	huron_typename,
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_01_camo_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"Slingload_01_Base_F",
	"Pod_Heli_Transport_04_base_F"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	[huron_typename, 200],
	["B_Heli_Transport_01_F", 50],
	["B_Heli_Transport_01_camo_F", 50],
	["Heli_Light_01_base_F", 10]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
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
	[FOB_box_typename, 0],
	[FOB_box_outpost, 0],
 	[FOB_truck_typename, 0],
	[ammo_truck_typename, 0],
	[fuel_truck_typename, 0],
	[repair_truck_typename, 0]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	[mobile_respawn, 2],
	[Arsenal_typename, 5],
	[FOB_box_typename, 50],
	[FOB_box_outpost, 25],
	[ammobox_b_typename, 15],
	[ammobox_o_typename, 15],
	[ammobox_i_typename, 15],
	[waterbarrel_typename, 10],
	[fuelbarrel_typename, 10],
	[foodbarrel_typename, 10],
	[medicalbox_typename, 2],
	[repair_sling_typename, 25],
	[fuel_sling_typename, 25],
	[ammo_sling_typename, 25],
	[medic_sling_typename, 25],
	[A3W_BoxWps, 7],
	[canisterFuel, 1],
	["Land_TentLamp_01_suspended_F", 1],
    ["Land_TentLamp_01_suspended_red_F", 1]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	mobile_respawn,
	Arsenal_typename,
	FOB_box_typename,
	FOB_box_outpost,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	medicalbox_typename,
	repair_sling_typename,
	fuel_sling_typename,
	ammo_sling_typename,
	medic_sling_typename,
	A3W_BoxWps,
	canisterFuel,
	"Land_RepairDepot_01_civ_F",
	"Land_TentLamp_01_suspended_F",
    "Land_TentLamp_01_suspended_red_F",
	"Land_Pod_Heli_Transport_04_bench_F",
	"Land_Pod_Heli_Transport_04_covered_F",
	"Land_PierLadder_F",
    "Box_NATO_WpsLaunch_F",
	"Land_CargoBox_V1_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_House_V2_F",
	"Land_Cargo_Patrol_V2_F",
	"Land_Cargo_House_V3_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	//"Land_BagBunker_Tower_F",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_BLUFOR_big_F",
	"Land_CncShelter_F"	
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	Arsenal_typename,
	FOB_box_typename,
	FOB_box_outpost
];
//--------------- Static ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"StaticMGWeapon",
	"StaticGrenadeLauncher",
	"StaticMortar",
	"Land_CzechHedgehog_01_new_F"
];
R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	//["StaticMGWeapon", 10],
	["Land_CzechHedgehog_01_new_F", 5],
	["B_HMG_01_F", 10],
	["B_HMG_01_high_F", 10],
	["I_HMG_01_F", 10],
	["I_HMG_01_high_F", 10],
	["O_HMG_01_F", 10],
	["O_HMG_01_high_F", 10],
	["O_static_AA_F", 10],
	["O_static_AT_F", 10],
	["O_Mortar_01_F", 10],
	["StaticGrenadeLauncher", 10],
	["StaticMortar", 10],
	["Land_CzechHedgehog_01_new_F", 10]
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
	"Land_Cargo_House_V2_F",
	"Land_Cargo_Patrol_V2_F",	
	"Land_Cargo_House_V3_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_PortableLight_double_F",
	"FlagCarrier",
	"Land_MapBoard_F",
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
	"Land_Metal_rack_Tall_F",
	"Land_PortableHelipadLight_01_F",
	"Land_DieselGroundPowerUnit_01_F",
	"Land_Pallet_MilBoxes_F",
	"Land_PaperBox_open_full_F"
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
	["Land_Cargo_House_V2_F", 5],
	["Land_Cargo_Patrol_V2_F", 5],	
	["Land_Cargo_House_V3_F", 5],
	["Land_Cargo_Patrol_V3_F", 5],
	["Land_PortableLight_double_F", 5],
	["FlagCarrier", 5],
	["Land_MapBoard_F", 5],
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
	["Land_Metal_rack_Tall_F", 5],
	["Land_PortableHelipadLight_01_F", 1],
	["Land_DieselGroundPowerUnit_01_F", 5],
	["Land_Pallet_MilBoxes_F", 5],
	["Land_PaperBox_open_full_F", 5]
];
