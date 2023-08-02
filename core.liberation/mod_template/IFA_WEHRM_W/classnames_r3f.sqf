//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"LIB_FW190F8_2_w",
	"LIB_FW190F8_w",
	"LIB_Ju87_w"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_bf109e"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_fw190a"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_he162"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_ju88a"];
};

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["LIB_FW190F8_2_w", 150],
	["LIB_FW190F8_w", 150],
	["LIB_Ju87_w", 150]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_bf109e",150];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_fw190a",150];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_he162",150];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_ju88a",300];
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
	"LIB_Kfz1_w",
	"LIB_Kfz1_Hood_w",
	"LIB_CIV_FFI_CitC4",
	"LIB_CIV_FFI_CitC4_3",
	"LIB_SdKfz_7_w",
	"LIB_Sdkfz251_w",
	"LIB_SdKfz251_FFV_w",
	"LIB_SdKfz_7_AA_w",
	"LIB_Kfz1_MG42",
	"LIB_FlakPanzerIV_Wirbelwind_w",
	"LIB_StuG_III_G_w",
	"LIB_PzKpfwIV_H_w",
	"LIB_PzKpfwV_w",
	"LIB_PzKpfwVI_B_w",
	"LIB_PzKpfwVI_E_w",
	"LIB_OpelBlitz_Open_G_Camo_w",
	"LIB_OpelBlitz_Tent_Y_Camo_w",
	"LIB_OpelBlitz_Ammo_w",
	"LIB_OpelBlitz_Fuel_w",
	"LIB_OpelBlitz_Parm_w",
	"LIB_OpelBlitz_Ambulance_w",
	"LIB_OpelBlitz_Open_Y_Camo_w",
	"LIB_SdKfz251"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"LIB_Kfz1_w",
	"LIB_Kfz1_Hood_w",
	"LIB_CIV_FFI_CitC4",
	"LIB_CIV_FFI_CitC4_3",
	"LIB_SdKfz_7_w",
	"LIB_Sdkfz251_w",
	"LIB_SdKfz251_FFV_w",
	"LIB_SdKfz_7_AA_w",
	"LIB_Kfz1_MG42",
	"LIB_FlakPanzerIV_Wirbelwind_w",
	"LIB_StuG_III_G_w",
	"LIB_PzKpfwIV_H_w",
	"LIB_PzKpfwV_w",
	"LIB_PzKpfwVI_B_w",
	"LIB_PzKpfwVI_E_w",
	"LIB_OpelBlitz_Open_G_Camo_w",
	"LIB_OpelBlitz_Tent_Y_Camo_w",
	"LIB_OpelBlitz_Ammo_w",
	"LIB_OpelBlitz_Fuel_w",
	"LIB_OpelBlitz_Parm_w",
	"LIB_OpelBlitz_Ambulance_w",
	"LIB_OpelBlitz_Open_Y_Camo_w",
	"LIB_SdKfz251"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"LIB_Kfz1_w",
	"LIB_Kfz1_Hood_w",
	"LIB_CIV_FFI_CitC4",
	"LIB_CIV_FFI_CitC4_3",
	"LIB_SdKfz_7_w",
	"LIB_Sdkfz251_w",
	"LIB_SdKfz251_FFV_w",
	"LIB_SdKfz_7_AA_w",
	"LIB_Kfz1_MG42",
	"LIB_FlakPanzerIV_Wirbelwind_w",
	"LIB_StuG_III_G_w",
	"LIB_PzKpfwIV_H_w",
	"LIB_PzKpfwV_w",
	"LIB_PzKpfwVI_B_w",
	"LIB_PzKpfwVI_E_w",
	"LIB_OpelBlitz_Open_G_Camo_w",
	"LIB_OpelBlitz_Tent_Y_Camo_w",
	"LIB_OpelBlitz_Ammo_w",
	"LIB_OpelBlitz_Fuel_w",
	"LIB_OpelBlitz_Parm_w",
	"LIB_OpelBlitz_Ambulance_w",
	"LIB_OpelBlitz_Open_Y_Camo_w",
	"LIB_SdKfz251"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["LIB_Kfz1_w", 50],
	["LIB_Kfz1_Hood_w", 50],
	["LIB_Kfz1_MG42", 50],
	["LIB_OpelBlitz_Open_Y_Camo_w", 50],
	["LIB_CIV_FFI_CitC4", 75],
	["LIB_CIV_FFI_CitC4_3", 75],
	["LIB_SdKfz_7_w", 75],
	["LIB_Sdkfz251_w", 75],
	["LIB_SdKfz251_FFV_w", 75],
	["LIB_SdKfz_7_AA_w", 75],
	["LIB_SdKfz251", 75],
	["LIB_FlakPanzerIV_Wirbelwind_w", 75],
	["LIB_StuG_III_G_w", 100],
	["LIB_PzKpfwIV_H_w", 100],
	["LIB_PzKpfwV_w", 100],
	["LIB_PzKpfwVI_B_w", 150],
	["LIB_PzKpfwVI_E_w", 150],
	["LIB_OpelBlitz_Open_G_Camo_w", 100],
	["LIB_OpelBlitz_Tent_Y_Camo_w", 150],
	["LIB_OpelBlitz_Ammo_w", 100],
	["LIB_OpelBlitz_Fuel_w", 100],
	["LIB_OpelBlitz_Parm_w", 100],
	["LIB_OpelBlitz_Ambulance_w", 100]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

//--------------- Ship ---------------

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["B_Boat_Transport_01_F", 50]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"B_Boat_Transport_01_F"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"B_Boat_Transport_01_F"
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
	["LIB_MG34_Lafette_Deployed", 5],
	["LIB_MG42_Lafette_Deployed", 5],
	["LIB_GrWr34", 5],
	["LIB_Nebelwerfer41_Camo", 10],
	["LIB_FlaK_30_w", 25],
	["LIB_FlaK_38_w", 25],
	["LIB_Flakvierling_38_w", 50],
	["LIB_Pak40_w", 50]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"LIB_MG34_Lafette_Deployed",
	"LIB_MG42_Lafette_Deployed",
	"LIB_GrWr34",
	"LIB_Nebelwerfer41_Camo",
	"LIB_FlaK_30_w",
	"LIB_FlaK_38_w",
	"LIB_Flakvierling_38_w",
	"LIB_Pak40_w"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];
