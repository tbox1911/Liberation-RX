// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
	[ "gm_ge_civ_u1300l", -4.5, [0, -0.5, 0], [0, -2.1, 0] ],
    [ "gm_ge_army_u1300l_container", -4.5, [0, -0.5, -0.4], [0, -2.1, -0.4] ],
    [ "gm_ge_army_kat1_451_container", -5.5, [0, 0.21, -0.01], [0, -1.34, -0.01], [0, -2.9, -0.01]]	
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
