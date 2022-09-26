// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
    [ "vn_o_wheeled_z157_01_nva65", -6.5, [0, -0.8, 0.4], [0, -2.5, 0.4] ],
    [ "vn_o_wheeled_z157_02_nva65", -6.5, [0, -0.8, 0.4], [0, -2.5, 0.4] ],
    [ "vn_o_boat_03_02", 25, [1, -10.7, -0.9], [-1, -10.7, -0.9] ],
    [ "vn_o_boat_04_02", 25, [1, -10.7, -0.9], [-1, -10.7, -0.9] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
	["Land_vn_us_weapons_stack2", [0, 0, -0.9] ],
	["Land_vn_pavn_weapons_stack1", [0, 0, -0.9] ],
	["Land_WaterBottle_01_stack_F", [0, 0, -0.25] ],
	["Land_vn_metalbarrel_f", [0, 0, -0.4] ]
];
