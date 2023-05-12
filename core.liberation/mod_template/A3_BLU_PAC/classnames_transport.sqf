// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
	[ "B_G_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "B_GEN_Offroad_01_gen_F", -5, [0, -1.55, 0.2] ],
	[ "B_G_Van_01_transport_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ],
	[ "B_GEN_Van_02_vehicle_F", -5, [0,0.5,0], [0,-1.75,0] ],
	[ "B_G_Van_02_vehicle_F", -5, [0,0.5,0], [0,-1.75,0] ],
	[ "B_GEN_Van_02_transport_F", -5, [0,-1.75,0] ],
	[ "B_G_Van_02_transport_F", -5, [0,-1.75,0] ],
	[ "B_T_Truck_01_transport_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
	[ "B_T_Truck_01_covered_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
	[ "B_T_Truck_01_medical_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
	[ "B_Heli_Transport_03_F", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1] ],
	[ "B_Heli_Transport_03_unarmed_F", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1] ],
	[ "B_T_VTOL_01_infantry_F", -7.5,[0,4.7,-4.88], [0,3,-4.88], [0,1.3,-4.88], [0,-0.4,-4.88], [0,-2.1,-4.88] ],
	[ "B_T_VTOL_01_vehicle_F", -7.5,[0,4.7,-4.88], [0,3,-4.88], [0,1.3,-4.88], [0,-0.4,-4.88], [0,-2.1,-4.88] ],
	[ "I_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];