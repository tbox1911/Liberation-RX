// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
	[ "cwr3_b_m939", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "cwr3_b_m939_empty", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "cwr3_b_m939_open", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "cwr3_b_hmmwv_transport", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "cwr3_b_ch47", -6.5, [0,0.5,1.5], [0,-0.9,1.5], [0,-2.4,1.5], [0,-3.8,1.5] ],
	[ "cwr3_b_c130_cargo", -7.5, [0,2,-1.8], [0,0.6,-1.8], [0,-1.2,-1.8], [0,-2.6,-1.8] ]	
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
