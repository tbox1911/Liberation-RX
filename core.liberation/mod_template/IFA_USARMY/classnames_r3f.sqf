//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"LIB_C47_Skytrain",
	"LIB_CG4_WACO",
	"LIB_US_P39",
	"LIB_US_P39_2",
	"LIB_P47"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_f4f"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_f4u"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_p51d"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_sbd"];
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_p38"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_p40"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_a26"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_tbf"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_b17"];
};

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["LIB_C47_Skytrain", 150],
	["LIB_CG4_WACO", 150],
	["LIB_US_P39", 150],
	["LIB_US_P39_2", 150],
	["LIB_P47", 150]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_f4f",150];
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_f4u",150];
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_p51d",150];
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_sbd",150];
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_p38",150];
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_p40",150];
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_a26",150];
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_tbf",150];
	R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_b17",150];
};


R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

//--------------- Ground ---------------

R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
	"LIB_US_Willys_MB",
	"LIB_US_Willys_MB_Hood",
	"LIB_US_Willys_MB_M1919",
	"LIB_US_GMC_Tent",
	"LIB_US_Scout_M3",
	"LIB_M8_Greyhound",
	"LIB_US_M3_Halftrack",
	"LIB_M3A3_Stuart",
	"LIB_M4A3_75",
	"LIB_M4A3_76",
	"LIB_M5A1_Stuart",
	"LIB_US_GMC_Ammo",
	"LIB_US_GMC_Fuel",
	"LIB_US_GMC_Parm",
	"LIB_US_GMC_Ambulance"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"LIB_US_Willys_MB",
	"LIB_US_Willys_MB_Hood",
	"LIB_US_Willys_MB_M1919",
	"LIB_US_GMC_Tent",
	"LIB_US_Scout_M3",
	"LIB_M8_Greyhound",
	"LIB_US_M3_Halftrack",
	"LIB_M3A3_Stuart",
	"LIB_M4A3_75",
	"LIB_M4A3_76",
	"LIB_M5A1_Stuart",
	"LIB_US_GMC_Ammo",
	"LIB_US_GMC_Fuel",
	"LIB_US_GMC_Parm",
	"LIB_US_GMC_Ambulance"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"LIB_US_Willys_MB",
	"LIB_US_Willys_MB_Hood",
	"LIB_US_Willys_MB_M1919",
	"LIB_US_GMC_Tent",
	"LIB_US_Scout_M3",
	"LIB_M8_Greyhound",
	"LIB_US_M3_Halftrack",
	"LIB_M3A3_Stuart",
	"LIB_M4A3_75",
	"LIB_M4A3_76",
	"LIB_M5A1_Stuart",
	"LIB_US_GMC_Ammo",
	"LIB_US_GMC_Fuel",
	"LIB_US_GMC_Parm",
	"LIB_US_GMC_Ambulance"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["LIB_US_Willys_MB", 75],
	["LIB_US_Willys_MB_Hood", 75],
	["LIB_US_Willys_MB_M1919", 75],
	["LIB_US_GMC_Tent", 100],
	["LIB_US_Scout_M3", 100],
	["LIB_M8_Greyhound", 100],
	["LIB_US_M3_Halftrack", 125],
	["LIB_M3A3_Stuart", 150],
	["LIB_M4A3_75", 150],
	["LIB_M4A3_76", 150],
	["LIB_M5A1_Stuart", 150],
	["LIB_US_GMC_Ammo", 200],
	["LIB_US_GMC_Fuel", 200],
	["LIB_US_GMC_Parm", 200],
	["LIB_US_GMC_Ambulance", 150]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["LIB_US_Willys_MB", 100],
	["LIB_US_Willys_MB_Hood", 100],
	["LIB_US_Willys_MB_M1919", 100]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

//--------------- Ship ---------------

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["I_G_Boat_Transport_01_F", 75],
	["LIB_LCVP", 150],
	["LIB_LCM3_Armed", 150],
	["LIB_LCI", 300]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"I_G_Boat_Transport_01_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"I_G_Boat_Transport_01_F",
	"LIB_LCVP",
	"LIB_LCM3_Armed",
	"LIB_LCI"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"I_G_Boat_Transport_01_F",
	"LIB_LCVP",
	"LIB_LCM3_Armed",
	"LIB_LCI"
];

//--------------- Building ---------------
R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["FenceWood", 5],
	["Concrete_Wall_EP1", 20]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"FenceWood",
	"Concrete_Wall_EP1"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

//--------------- Static ---------------

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["LIB_M1919_M2", 5],
	["LIB_M2_60", 5]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"LIB_M1919_M2",
	"LIB_M2_60"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];
