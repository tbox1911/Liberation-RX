// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
	[ "b_afougf_Ural_Base", -6.5, [0,-1.1,0.4], [0,-2.8,0.4], [0,-4.5,0.4] ],
	[ "b_afougf_kraz255ba_cargo_open", -6.5, [0,-1.1,0.4], [0,-2.8,0.4], [0,-4.5,0.4] ],
	[ "b_afougf_Mi8MTV3_UPK23", -7.5, [0, 3.0, -1.5], [0, 0.8, -1.5] ],
	[ "b_afougf_Mi8MTV3_Cargo", -7.5, [0, 3.4, -1.5], [0, 1.8, -1.5], [0, 0.2, -1.5] ],
	[ "b_afougf_Mi8MTV3_Cargo", -7.5, [0, 3.7, -0.1], [0, 2.1, -0.1], [0, 0.5, -0.1], [0, -1.1, 0.0] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
