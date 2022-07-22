// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
    [ "ffaa_ar_lcm", 30, [2, -4, -1.7], [2, -2.4, -1.7], [2, -0.8, -1.7], [2, 0.8, -1.7], [2, 2.4, -1.7], [2, 4, -1.7] ],
    [ "ffaa_et_pegaso_carga", -6.5, [0.05, -1, 0.4], [0.05, -2.6, 0.4] ],
    [ "ffaa_et_pegaso_carga_lona", -6.5, [0.05, -1, 0.4], [0.05, -2.6, 0.4] ],
    [ "ffaa_et_m250_carga_blin", -6.5, [-0.1, 0.6, 0.3], [-0.1, -1, 0.3], [-0.1, -2.6, 0.3] ],
    [ "ffaa_et_m250_carga_lona_blin", -6.5, [-0.1, 0.6, 0.3], [-0.1, -1, 0.3], [-0.1, -2.6, 0.3] ],
    [ "ffaa_et_m250_estacion_nasams_blin", -6.5,  [-0.1, -1.5, 0.3], [-0.1, -3.1, 0.3] ],
    [ "ffaa_famet_cougar", -12, [0.15, 2.45, -1.05] ],
    [ "ffaa_famet_ch47_mg_cargo", -10, [0, 1.3, -1.9], [0, -0.5, -1.9], [0, -2.1, -1.9] ],
    [ "ffaa_nh90_tth_cargo", -12, [0.1, 2, -1.15], [0.1, 0.4, -1.15] ],
	[ "ffaa_famet_ch47_mg", -10, [0, 1.3, -1.9], [0, -0.5, -1.9], [0, -2.1, -1.9] ],
    [ "ffaa_nh90_tth_transport", -12, [0.1, 0.35, -1.15] ],
    [ "ffaa_nh90_tth_armed", -12, [0.1, 0.4, -1.15] ],
    [ "ffaa_nh90_nfh_transport", -12, [0.1, 0.35, -1.15] ],
	[ "ffaa_ea_hercules_cargo", -12, [0, 6, -3.7], [0, 4.4, -3.7], [0, 2.8, -3.7], [0, 1.2, -3.7], [0, -0.4, -3.7], [0, -2, -3.7] ] 
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
