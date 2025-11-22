// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
	[ "I_G_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "I_E_Offroad_01_F", -5, [0, -1.55, 0.2] ],
    [ "I_G_Van_02_vehicle_F", -5, [0,0.5,0], [0,-1.75,0]],
    [ "I_C_Van_02_vehicle_F", -5, [0,0.5,0], [0,-1.75,0]],
    [ "I_E_Van_02_vehicle_F", -5, [0,0.5,0], [0,-1.75,0]],
	[ "I_C_Van_01_transport_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ],
	[ "I_G_Van_01_transport_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ],
	[ "I_G_Van_02_transport_F", -5, [0,-1.75,0]],
	[ "I_C_Van_02_transport_F", -5, [0,-1.75,0]],
	[ "I_E_Van_02_transport_F", -5, [0,-1.75,0]],
	[ "I_E_Van_02_transport_MP_F", -5, [0,-1.75,0]],
	[ "I_Heli_Transport_02_F", -6.5, [0, 4.2, -1.45], [0, 2.5, -1.45], [0, 0.8, -1.45], [0, -0.9, -1.45] ],
	[ "I_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_Truck_02_medical_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_E_Truck_02_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_E_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_E_Truck_02_medical_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
