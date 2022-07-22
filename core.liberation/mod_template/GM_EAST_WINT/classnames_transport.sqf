// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
	[ "gm_ge_civ_u1300l", -4.5, [0, -0.5, -0.4], [0, -2.1, -0.4] ],
    [ "gm_gc_airforce_l410t", -8, [0, 2.7, -1.1], [0, 1.1, -1.1], [0, -0.5, -1.1] ],
	[ "gm_gc_army_ural4320_cargo", -5.5, [0, -0.7, 0.04], [0, -2.4, 0.04] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
