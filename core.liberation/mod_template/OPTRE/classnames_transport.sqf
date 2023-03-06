// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
	[ "OPTRE_m1015_mule_ins", -6.5, [0, -0.8, 0.4], [0, -2.4, 0.4], [0, -4.0, 0.4] ],
	[ "OPTRE_m1015_mule_cover_ins", -6.5, [0, -0.8, 0.4], [0, -2.4, 0.4], [0, -4.0, 0.4] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
