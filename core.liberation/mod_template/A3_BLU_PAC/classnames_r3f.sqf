//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"C_Plane_Civil_01_F",
	"B_T_VTOL_01_armed_F",
	"B_T_VTOL_01_vehicle_F",
	"B_T_VTOL_01_infantry_F",
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_F"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
	"B_Heli_Light_01_dynamicLoadout_F",
	"B_Heli_Attack_01_dynamicLoadout_F",
	"B_Heli_Transport_03_F",
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Light_01_F",
	"B_Heli_Transport_01_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"B_T_UAV_03_dynamicLoadout_F",
	"B_UAV_06_F",
	"B_UAV_06_medical_F",
	"B_UAV_01_F"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	//Heli:
	["B_Heli_Light_01_dynamicLoadout_F", 20],
	["B_Heli_Attack_01_dynamicLoadout_F", 25],
	["B_Heli_Transport_03_F", 150],
	["B_Heli_Transport_03_unarmed_F", 200],
	["B_Heli_Light_01_F", 20],
	["B_Heli_Transport_01_F", 100],
	//Planes:
	["C_Plane_Civil_01_F", 100],
	["B_T_VTOL_01_armed_F", 50],
	["B_T_VTOL_01_vehicle_F", 100],
	["B_T_VTOL_01_infantry_F", 100],
	["B_Plane_CAS_01_dynamicLoadout_F", 10],
	["B_Plane_Fighter_01_F", 10],
	//Drohnes
	["B_T_UAV_03_dynamicLoadout_F", 20],
	["B_UAV_06_F", 10],
	["B_UAV_06_medical_F", 10],
	["B_UAV_01_F", 10],
	["B_UAV_02_dynamicLoadout_F", 25],
	["B_UAV_05_F", 25]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_UAV_01_F", 3],
	["B_UAV_06_F", 3],
	["B_UAV_02_dynamicLoadout_F", 30],
	["B_T_UAV_03_dynamicLoadout_F", 50]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"B_T_UAV_03_dynamicLoadout_F",
	"B_T_UGV_01_olive_F",
	"B_T_UGV_01_rcws_olive_F",
	"B_UAV_06_F",
	"B_UAV_06_medical_F",
	"B_UAV_01_F",
	"B_UAV_02_dynamicLoadout_F",
	"B_UAV_05_F"
];

//--------------- Ground ---------------

R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
	//Car:
	"B_G_Offroad_01_repair_F",
	"B_G_Offroad_01_AT_F",
	"B_G_Van_01_fuel_F",
	"B_T_Quadbike_01_F",
	"SUV_01_base_black_F",
	"B_G_Offroad_01_F",
	"B_G_Offroad_01_armed_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F",
	"B_T_MRAP_01_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F",
	// Trucks:
	"B_T_Truck_01_mover_F",
	"B_T_Truck_01_cargo_F",
	"B_T_Truck_01_flatbed_F",
	"B_T_Truck_01_Repair_F",
	"B_T_Truck_01_ammo_F",
	"B_T_Truck_01_medical_F",
	"B_T_Truck_01_box_F",
	"B_T_Truck_01_transport_F",
	"B_T_Truck_01_covered_F",
	"B_T_Truck_01_fuel_F",
	// Anti Air:
	"B_T_APC_Tracked_01_AA_F",
	// Troup Transporter:
	"B_T_APC_Wheeled_01_cannon_F",
	"B_T_APC_Tracked_01_CRV_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_T_AFV_Wheeled_01_cannon_F",
	"B_T_AFV_Wheeled_01_up_cannon_F",
	//Tanks:
	"B_T_MBT_01_cannon_F",
	"B_T_MBT_01_TUSK_F",
	// Ari
	"B_T_MBT_01_arty_F",
	"B_T_MBT_01_mlrs_F",
	// Drones
	"B_T_UGV_01_olive_F",
	"B_T_UGV_01_rcws_olive_F"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	//Car:
	"B_G_Offroad_01_repair_F",
	"B_G_Offroad_01_AT_F",
	"B_G_Van_01_fuel_F",
	"B_T_Quadbike_01_F",
	"SUV_01_base_black_F",
	"B_G_Offroad_01_F",
	"B_G_Offroad_01_armed_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F",
	"B_T_MRAP_01_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F",
	// Trucks:
	"B_T_Truck_01_mover_F",
	"B_T_Truck_01_cargo_F",
	"B_T_Truck_01_flatbed_F",
	"B_T_Truck_01_Repair_F",
	"B_T_Truck_01_ammo_F",
	"B_T_Truck_01_medical_F",
	"B_T_Truck_01_box_F",
	"B_T_Truck_01_transport_F",
	"B_T_Truck_01_covered_F",
	"B_T_Truck_01_fuel_F",
	// Anti Air:
	"B_T_APC_Tracked_01_AA_F",
	// Troup Transporter:
	"B_T_APC_Wheeled_01_cannon_F",
	"B_T_APC_Tracked_01_CRV_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_T_AFV_Wheeled_01_cannon_F",
	"B_T_AFV_Wheeled_01_up_cannon_F",
	//Tanks:
	"B_T_MBT_01_cannon_F",
	"B_T_MBT_01_TUSK_F",
	// Ari
	"B_T_MBT_01_arty_F",
	"B_T_MBT_01_mlrs_F",
	// Drones
	"B_T_UGV_01_olive_F",
	"B_T_UGV_01_rcws_olive_F"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	//Car:
	"B_G_Offroad_01_repair_F",
	"B_G_Offroad_01_AT_F",
	"B_G_Van_01_fuel_F",
	"B_T_Quadbike_01_F",
	"SUV_01_base_black_F",
	"B_G_Offroad_01_F",
	"B_G_Offroad_01_armed_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"B_T_LSV_01_unarmed_F",
	"B_T_LSV_01_armed_F",
	"B_T_LSV_01_AT_F",
	"B_T_MRAP_01_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F",
	// Trucks:
	"B_T_Truck_01_mover_F",
	"B_T_Truck_01_cargo_F",
	"B_T_Truck_01_flatbed_F",
	"B_T_Truck_01_Repair_F",
	"B_T_Truck_01_ammo_F",
	"B_T_Truck_01_medical_F",
	"B_T_Truck_01_box_F",
	"B_T_Truck_01_transport_F",
	"B_T_Truck_01_covered_F",
	"B_T_Truck_01_fuel_F",
	// Anti Air:
	"B_T_APC_Tracked_01_AA_F",
	// Troup Transporter:
	"B_T_APC_Wheeled_01_cannon_F",
	"B_T_APC_Tracked_01_CRV_F",
	"B_T_APC_Tracked_01_rcws_F",
	"B_T_AFV_Wheeled_01_cannon_F",
	"B_T_AFV_Wheeled_01_up_cannon_F",
	//Tanks:
	"B_T_MBT_01_cannon_F",
	"B_T_MBT_01_TUSK_F",
	// Ari
	"B_T_MBT_01_arty_F",
	"B_T_MBT_01_mlrs_F",
	// Drones
	"B_T_UGV_01_olive_F",
	"B_T_UGV_01_rcws_olive_F"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	//Car:
	["B_G_Offroad_01_repair_F", 25],
	["B_G_Van_01_fuel_F", 25],
	["B_T_Quadbike_01_F", 5],
	["SUV_01_base_black_F", 25],
	["B_G_Offroad_01_AT_F", 25],
	["B_G_Offroad_01_F", 25],
	["B_G_Offroad_01_armed_F", 25],
	["C_SUV_01_F", 25],
	["C_Van_01_transport_F", 50],
	["B_T_LSV_01_unarmed_F", 25],
	["B_T_LSV_01_armed_F", 25],
	["B_T_LSV_01_AT_F", 25],
	["B_T_MRAP_01_F", 25],
	["B_T_MRAP_01_hmg_F", 25],
	["B_T_MRAP_01_gmg_F", 25],
	// Trucks:
	["B_T_Truck_01_mover_F", 100],
	["B_T_Truck_01_cargo_F", 150],
	["B_T_Truck_01_flatbed_F", 150],
	["B_T_Truck_01_Repair_F", 100],
	["B_T_Truck_01_ammo_F", 100],
	["B_T_Truck_01_medical_F", 100],
	["B_T_Truck_01_box_F", 100],
	["B_T_Truck_01_transport_F", 200],
	["B_T_Truck_01_covered_F", 100],
	["B_T_Truck_01_fuel_F", 100],
	// Anti Air:
	["B_T_APC_Tracked_01_AA_F", 50],
	// Troup Transporter:
	["B_T_APC_Wheeled_01_cannon_F", 50],
	["B_T_APC_Tracked_01_CRV_F", 50],
	["B_T_APC_Tracked_01_rcws_F", 50],
	["B_T_AFV_Wheeled_01_cannon_F", 50],
	["B_T_AFV_Wheeled_01_up_cannon_F", 50],
	//Tanks:
	["B_T_MBT_01_cannon_F", 75],
	["B_T_MBT_01_TUSK_F", 75],
	// Ari
	["B_T_MBT_01_arty_F", 25],
	["B_T_MBT_01_mlrs_F", 25],
	// Drones
	["B_T_UGV_01_olive_F", 25],
	["B_T_UGV_01_rcws_olive_F", 25]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_T_Quadbike_01_F", 5],
	["B_T_UGV_01_olive_F", 15],
	["B_T_UGV_01_rcws_olive_F", 15]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

//--------------- Ship ---------------

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["B_T_Boat_Transport_01_F", 15],
	["B_T_Lifeboat", 15],
	["B_T_Boat_Armed_01_minigun_F", 75],
	["B_SDV_01_F", 15],
	["C_Scooter_Transport_01_F", 15]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_T_Boat_Transport_01_F", 5],
	["B_T_Lifeboat", 5],
	["B_SDV_01_F", 5],
	["C_Scooter_Transport_01_F", 5]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"B_T_Boat_Transport_01_F",
	"B_T_Lifeboat",
	"B_T_Boat_Armed_01_minigun_F",
	"B_SDV_01_F",
	"C_Scooter_Transport_01_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"B_T_Boat_Transport_01_F",
	"B_T_Lifeboat",
	"B_T_Boat_Armed_01_minigun_F",
	"B_SDV_01_F",
	"C_Scooter_Transport_01_F"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"B_T_Boat_Transport_01_F",
	"B_T_Lifeboat",
	"B_T_Boat_Armed_01_minigun_F",
	"B_SDV_01_F",
	"C_Scooter_Transport_01_F"
];

//--------------- Building ---------------
R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];
//--------------- Static ---------------

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_T_HMG_01_F", 5],
	["B_T_GMG_01_F", 5],
	["B_T_Mortar_01_F", 5],
	["B_T_Static_AA_F", 5],
	["B_T_Static_AT_F", 5]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"B_T_HMG_01_F",
	"B_T_GMG_01_F",
	"B_T_Mortar_01_F",
	"B_T_Static_AA_F",
	"B_T_Static_AT_F",
	"B_SAM_System_03_F",
	"B_SAM_System_01_F",
	"B_AAA_System_01_F",
	"B_SAM_System_02_F"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];
