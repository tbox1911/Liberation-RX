// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
    [ "R3F_KAMAZ_CE_trans", -6.5, [0, 0.3, 0.1], [0, -1.3, 0.1], [0, -2.9, 0.1] ],
    [ "R3F_KAMAZ_CE_medevac", -6.5, [0, 0.3, 0.1], [0, -1.3, 0.1], [0, -2.9, 0.1] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
