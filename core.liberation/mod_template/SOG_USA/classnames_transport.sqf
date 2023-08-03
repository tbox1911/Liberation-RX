// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
    [ "vn_b_wheeled_m54_02_sog", -6.5, [0, -0.8, 0.2], [0, -2.5, 0.2] ],
    [ "vn_b_wheeled_m54_01", -6.5, [0, -0.9, 0.3], [0, -2.6, 0.3] ],
    [ "vn_b_wheeled_m54_02", -6.5, [0, -0.8, 0.2], [0, -2.5, 0.2] ],
    [ "vn_b_wheeled_m54_mg_01", -6.5, [-0.3, -0.9, 0] ], 
    [ "vn_b_wheeled_m54_mg_03", -6.5, [-0.3, -0.9, 0] ],
    [ "vn_b_air_uh1d_02_02", 10, [-0.1, 2.65, -1.2] ],
    [ "vn_b_air_uh1d_02_04", 10, [-0.1, 2.65, -1.2] ],
    [ "vn_b_boat_06_01", 25, [2.2, -8.5, 0.5], [-2.2, -8.5, 0.5] ],
    [ "vn_b_boat_05_01", 25, [2.2, -8.5, 0.5], [-2.2, -8.5, 0.5] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
	["Land_vn_us_weapons_stack2", [0, 0, -0.9] ],
	["Land_vn_pavn_weapons_stack1", [0, 0, -0.9] ],
	["Land_WaterBottle_01_stack_F", [0, 0, -0.25] ],
	["Land_vn_metalbarrel_f", [0, 0, -0.4] ]
];
