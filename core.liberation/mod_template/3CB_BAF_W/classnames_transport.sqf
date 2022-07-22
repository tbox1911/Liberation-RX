// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
	[ "UK3CB_BAF_MAN_HX58_Transport_Green_DPMW", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "UK3CB_BAF_MAN_HX60_Cargo_Green_A_DPMW", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "UK3CB_BAF_MAN_HX60_Transport_Green_DPMW", -6.5, [0,0.5,1.5], [0,-0.9,1.5], [0,-2.4,1.5], [0,-3.8,1.5] ],
	[ "UK3CB_BAF_Merlin_HC3_Cargo_DPMW", -7.5, [0,2,-1.8], [0,0.6,-1.8], [0,-1.2,-1.8], [0,-2.6,-1.8] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
