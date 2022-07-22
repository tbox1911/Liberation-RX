// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries

box_transport_config = box_transport_config + [
    // the 'opfor_transport_truck' MUST be declared here
	[ "rhsusf_M1078A1P2_WD_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M1084A1P2_B_WD_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M977A4_usarmy_wd", -6.5, [0,0.5,1.5], [0,-0.9,1.5], [0,-2.4,1.5], [0,-3.8,1.5] ],
	[ "RHS_CH_47F", -7.5, [0,2,-1.8], [0,0.6,-1.8], [0,-1.2,-1.8], [0,-2.6,-1.8] ]
];

// Additional offset per object
// objects in this list can be loaded on vehicle position defined above

box_transport_offset = box_transport_offset + [
    // use default config
];
