// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
    [ "R3F_KAMAZ_DA_medevac", -6.5, [0, 0.3, 0.1], [0, -1.3, 0.1], [0, -2.9, 0.1] ],
	[ "AMF_GBC180_PERS_01", -6.5, [0.75, 0.4, 2.4], [0.75, -1.2, 2.4],[0.75, -2.8, 2.4], [-0.75, 0.4, 2.4], [-0.75, -1.2, 2.4] ],
	[ "AMF_GBC180_PERS_02", -6.5, [0.75, 0.4, 2.4], [0.75, -1.2, 2.4],[0.75, -2.8, 2.4], [-0.75, 0.4, 2.4], [-0.75, -1.2, 2.4] ],
    [ "AMF_GBC180_PLATEAU_02", -6.5, [0.75, 0.4, 2.4], [0.75, -1.2, 2.4],[0.75, -2.8, 2.4], [-0.75, 0.4, 2.4], [-0.75, -1.2, 2.4],[-0.75, -2.8, 2.4] ],
    [ "ffaa_famet_cougar", -12, [0.15, 2.45, -1.05] ],
    [ "B_AMF_Heli_Transport_4RHFS_01_F", -20, [0, -1.6, 2.1], [0, -3.2, 2.1] ],
    [ "ffaa_nh90_tth_cargo", -12, [0.1, 2, -1.15], [0.1, 0.4, -1.15] ],
	[ "ffaa_nh90_tth_transport", -12, [0.1, 0.35, -1.15] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
