//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"LIB_P39",
	"LIB_RA_P39_2",
	"LIB_Pe2"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_yak3"];
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_i16"];
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_il2"];
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_il2_2"];
};

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[

];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[

];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["LIB_P39", 150],
	["LIB_RA_P39_2", 150],
	["LIB_Pe2", 150]
];
// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_yak3",150];
};

if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  R3F_LOG_CFG_can_transport_cargo pushBack  ["sab_sw_i16",150];
  R3F_LOG_CFG_can_transport_cargo pushBack  ["sab_sw_il2",150];
  R3F_LOG_CFG_can_transport_cargo pushBack  ["sab_sw_il2_2",150];
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
	"LIB_GazM1_SOV",
	"LIB_Willys_MB",
	"LIB_Scout_M3",
	"LIB_SOV_M3_Halftrack",
	"LIB_SdKfz251_captured",
	"LIB_SdKfz251_captured_FFV",
	"LIB_Zis5v_61K",
	"LIB_T34_76",
	"LIB_T34_85",
	"LIB_SU85",
	"LIB_JS2_43",
	"LIB_M4A2_SOV",
	"LIB_US6_Ammo",
	"LIB_Zis5v_Fuel",
	"LIB_Zis6_Parm",
	"LIB_Zis5v_Med",
	"LIB_US6_Tent",
	"LIB_Scout_M3_FFV",
	"LIB_Willys_MB_Hood",
	"LIB_US6_BM13"
];

// Additional Tanks from Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow + ["FA_KV1"];
  R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow + ["FA_T26"];
};

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"LIB_GazM1_SOV",
	"LIB_Willys_MB",
	"LIB_Scout_M3",
	"LIB_SOV_M3_Halftrack",
	"LIB_SdKfz251_captured",
	"LIB_SdKfz251_captured_FFV",
	"LIB_Zis5v_61K",
	"LIB_T34_76",
	"LIB_T34_85",
	"LIB_SU85",
	"LIB_JS2_43",
	"LIB_M4A2_SOV",
	"LIB_US6_Ammo",
	"LIB_Zis5v_Fuel",
	"LIB_Zis6_Parm",
	"LIB_Zis5v_Med",
	"LIB_US6_Tent",
	"LIB_Scout_M3_FFV",
	"LIB_Willys_MB_Hood",
	"LIB_US6_BM13"
];

// Additional Tanks from Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["FA_KV1"];
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +  ["FA_T26"];
};

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"LIB_GazM1_SOV",
	"LIB_Willys_MB",
	"LIB_Scout_M3",
	"LIB_SOV_M3_Halftrack",
	"LIB_SdKfz251_captured",
	"LIB_SdKfz251_captured_FFV",
	"LIB_Zis5v_61K",
	"LIB_T34_76",
	"LIB_T34_85",
	"LIB_SU85",
	"LIB_JS2_43",
	"LIB_M4A2_SOV",
	"LIB_US6_Ammo",
	"LIB_Zis5v_Fuel",
	"LIB_Zis6_Parm",
	"LIB_Zis5v_Med",
	"LIB_US6_Tent",
	"LIB_Scout_M3_FFV",
	"LIB_Willys_MB_Hood",
	"LIB_US6_BM13"
];

// Additional Tanks from Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted + ["FA_KV1"];
  R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +  ["FA_T26"];
};

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["LIB_GazM1_SOV", 75],
	["LIB_Willys_MB", 75],
	["LIB_Willys_MB_Hood", 75],
	["LIB_Scout_M3", 75],
	["LIB_SOV_M3_Halftrack", 100],
	["LIB_SdKfz251_captured", 100],
	["LIB_SdKfz251_captured_FFV", 100],
	["LIB_Zis5v_61K", 125],
	["LIB_T34_76", 150],
	["LIB_T34_85", 150],
	["LIB_SU85", 150],
	["LIB_JS2_43", 150],
	["LIB_M4A2_SOV", 150],
	["LIB_US6_Ammo", 200],
	["LIB_Zis5v_Fuel", 200],
	["LIB_Zis6_Parm", 200],
	["LIB_Zis5v_Med", 200],
	["LIB_US6_Tent", 150],
	["LIB_Scout_M3_FFV", 75],
	["LIB_US6_BM13",150]
];


// Additional Tanks from Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  R3F_LOG_CFG_can_transport_cargo pushBack ["FA_KV1", 100];
  R3F_LOG_CFG_can_transport_cargo pushBack ["FA_T26", 100];
};


R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

//--------------- Ship ---------------

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["B_Boat_Transport_01_F", 50],
	["O_Boat_Transport_01_F", 50]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_Boat_Transport_01_F", 5],
	["O_Boat_Transport_01_F", 5]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"B_Boat_Transport_01_F",
	"O_Boat_Transport_01_F"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"B_Boat_Transport_01_F",
	"O_Boat_Transport_01_F"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"B_Boat_Transport_01_F",
	"O_Boat_Transport_01_F"
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
	["LIB_Maxim_M30_base", 5],
	["LIB_BM37", 5],
	["LIB_61k", 10],
	["LIB_Zis3", 10]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"LIB_Maxim_M30_base",
	"LIB_BM37",
	"LIB_61k",
	"LIB_Zis3"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];
