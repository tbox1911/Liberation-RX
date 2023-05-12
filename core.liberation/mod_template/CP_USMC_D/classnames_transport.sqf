// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
    [ "CUP_C_Pickup_unarmed_CIV", -3.5, [0, -1.4, 0.2] ],
    [ "CUP_B_M6LineBacker_USA_D", -8, [0, 0, -0.9] ],
    [ "CUP_C_Fishing_Boat_Chernarus", 15, [-0.2, -3.6, -2.7], [-0.2, -5.3, -2.7] ],
    [ "CUP_B_MTVR_USA", -8, [0, -0.3, 0.4], [0, -1.9, 0.4] ],
    [ "CUP_B_CH53E_USMC", -10, [0, 4.8, -3.2], [0, 3.2, -3.2], [0, 1.6, -3.2], [0, 0, -3.2] ],
    [ "CUP_B_MV22_USMC_RAMPGUN", -14, [0, 1.1, -1.6], [0, -0.5, -1.6], [0, -2.1, -1.6] ],
    [ "CUP_B_C130J_Cargo_USMC", -15, [0, 5, -3.7], [0, 3.4, -3.7], [0, 1.8, -3.7], [0, 0.2, -3.7], [0, -1.4, -3.7], [0, -3, -3.7] ],
    [ "CUP_B_CH47F_USA", -10, [0, 1.1, -1.9], [0, -0.5, -1.9], [0, -2.1, -1.9] ],
    [ "CUP_B_MH47E_USA", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
