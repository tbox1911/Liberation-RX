// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
	[ "uns_nvatruck", -5.5, [0,-0.2,0.3], [0,-1.8,0.3] ],	
	[ "uns_nvatruck_camo", -5.5, [0,-0.2,0.3], [0,-1.8,0.3] ],
	[ "uns_nvatruck_mg", -5.5, [0,-0.2,0.3], [0,-1.8,0.3] ],
	[ "uns_nvatruck_open", -5.5, [0,-0.2,0.3], [0,-1.8,0.3] ],
	[ "uns_Mi8T_VPAF", -9, [0,2.5,-1.9], [0,0.7,-1.9], [0,-1.1,-1.9], [0,-2.9,-1.9] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
