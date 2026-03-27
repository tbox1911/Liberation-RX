// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
	["O_G_Offroad_01_F", -5, [0, -1.55, 0.2]],
	["O_G_Van_01_transport_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2]],
    ["O_G_Van_02_vehicle_F", -5, [0,0.5,0], [0,-1.75,0]],
	["O_G_Van_02_transport_F", -5, [0,-1.75,0]],
	["O_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0]],
	["O_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0]],
	["O_Truck_03_covered_F", -7, [0, -0.8, 0.4], [0, -2.4, 0.4], [0, -4.0, 0.4]],
	["O_Truck_03_medical_F", -7, [0, -0.8, 0.4], [0, -2.4, 0.4], [0, -4.0, 0.4]],
	["O_Heli_Transport_04_F", -7.5, [0, 0.8, -1.45], [0, -0.9, -1.45], [0, -2.6, -1.45], [0, -4.3, -1.45]]
//	["O_T_VTOL_02_vehicle_dynamicLoadout_F", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1]],
//	["O_T_VTOL_02_infantry_dynamicLoadout_F", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1]],
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];

// Additional offset per big object
box_transport_big_offset = box_transport_big_offset + [
	["B_AAA_System_01_F", [0, 1, 1.7]],
	["O_LSV_02_unarmed_F", [0, 1.5, 1.8]],
	["O_LSV_02_armed_F", [0, 1.5, 1.8]],
	["O_MRAP_02_F", [0, 1.5, 1.8]],
	["O_MRAP_02_hmg_F", [0, 1.5, 1.8]],
	["O_MRAP_02_gmg_F", [0, 1.5, 1.8]],
	["O_APC_Tracked_02_cannon_F",[0, 0.5, 2]],
	["O_APC_Tracked_02_AA_F", [0, 0.5, 2]],
	["O_UAV_02_dynamicLoadout_F", [0, 0.1, 0.8]]
];
