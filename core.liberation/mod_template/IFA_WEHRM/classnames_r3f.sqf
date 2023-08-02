//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"LIB_FW190F8",
	"LIB_Ju87_Italy",
	"LIB_Ju87"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_bf109e"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_fw190a"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_he162"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_fl_ju88a"];
};

// Additional Airplanes from Mod Secret Weapons (requ. Mod Flying Legends):
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_do335"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_bf110"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_he177"];
	R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["sab_sw_ar234"];
};

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["LIB_FW190F8", 150],
	["LIB_Ju87_Italy", 150],
	["LIB_Ju87", 150]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_bf109e",150];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_fw190a",150];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_he162",150];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_fl_ju88a",300];
};

// Additional Airplanes from Mod Secret Weapons (requ. Mod Flying Legends):
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_do335",150];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_bf110",150];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_he177",200];
  R3F_LOG_CFG_can_transport_cargo pushBack ["sab_sw_ar234",100];
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
	"LIB_GazM1",
	"LIB_GazM1_dirty",
	"LIB_CIV_FFI_CitC4",
	"LIB_CIV_FFI_CitC4_3",
	"LIB_US_NAC_Willys_MB",
	"LIB_US6_Open_Cargo",
	"LIB_GazM1_SOV",
	"LIB_Kfz1_Hood_camo",
	"LIB_Kfz1_MG42_camo",
	"LIB_SdKfz_7",
	"LIB_SdKfz251",
	"LIB_SdKfz251_FFV",
	"LIB_FlakPanzerIV_Wirbelwind",
	"LIB_SdKfz_7_AA",
	"LIB_SdKfz124",
	"LIB_T34_76_captured",
	"LIB_PzKpfwIV_H",
	"LIB_PzKpfwIV_H_tarn51c",
	"LIB_PzKpfwVI_E_tarn51d",
	"LIB_PzKpfwVI_E_tarn52d",
	"LIB_Kfz1_camo",
	"LIB_OpelBlitz_Open_Y_Camo",
	"LIB_OpelBlitz_Tent_Y_Camo",
	"LIB_OpelBlitz_Ammo",
	"LIB_OpelBlitz_Parm",
	"LIB_OpelBlitz_Fuel"
];

// Additional Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow + ["FA_Pz38t"];
  R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow + ["FA_T26_Captured"];
  R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow + ["FA_Panzer2"];
};

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"LIB_GazM1",
	"LIB_GazM1_dirty",
	"LIB_CIV_FFI_CitC4",
	"LIB_CIV_FFI_CitC4_3",
	"LIB_US_NAC_Willys_MB",
	"LIB_US6_Open_Cargo",
	"LIB_GazM1_SOV",
	"LIB_Kfz1_Hood_camo",
	"LIB_Kfz1_MG42_camo",
	"LIB_SdKfz_7",
	"LIB_SdKfz251",
	"LIB_SdKfz251_FFV",
	"LIB_FlakPanzerIV_Wirbelwind",
	"LIB_SdKfz_7_AA",
	"LIB_SdKfz124",
	"LIB_T34_76_captured",
	"LIB_PzKpfwIV_H",
	"LIB_PzKpfwIV_H_tarn51c",
	"LIB_PzKpfwVI_E_tarn51d",
	"LIB_PzKpfwVI_E_tarn52d",
	"LIB_Kfz1_camo",
	"LIB_OpelBlitz_Open_Y_Camo",
	"LIB_OpelBlitz_Tent_Y_Camo",
	"LIB_OpelBlitz_Ammo",
	"LIB_OpelBlitz_Parm",
	"LIB_OpelBlitz_Fuel",
	// Static
	"LIB_leFH18",
	"LIB_leFH18_AT",
	"LIB_Nebelwerfer41_Camo",
	"LIB_Pak40"
];

// Additional Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["FA_Pz38t"];
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["FA_T26_Captured"];
  R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed + ["FA_Panzer2"];
};

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"LIB_GazM1",
	"LIB_GazM1_dirty",
	"LIB_CIV_FFI_CitC4",
	"LIB_CIV_FFI_CitC4_3",
	"LIB_US_NAC_Willys_MB",
	"LIB_US6_Open_Cargo",
	"LIB_GazM1_SOV",
	"LIB_Kfz1_Hood_camo",
	"LIB_Kfz1_MG42_camo",
	"LIB_SdKfz_7",
	"LIB_SdKfz251",
	"LIB_SdKfz251_FFV",
	"LIB_FlakPanzerIV_Wirbelwind",
	"LIB_SdKfz_7_AA",
	"LIB_SdKfz124",
	"LIB_T34_76_captured",
	"LIB_PzKpfwIV_H",
	"LIB_PzKpfwIV_H_tarn51c",
	"LIB_PzKpfwVI_E_tarn51d",
	"LIB_PzKpfwVI_E_tarn52d",
	"LIB_Kfz1_camo",
	"LIB_OpelBlitz_Open_Y_Camo",
	"LIB_OpelBlitz_Tent_Y_Camo",
	"LIB_OpelBlitz_Ammo",
	"LIB_OpelBlitz_Parm",
	"LIB_OpelBlitz_Fuel"
];

// Additional Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted + ["FA_Pz38t"];
  R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted + ["FA_T26_Captured"];
  R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted + ["FA_Panzer2"];
};

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
	["LIB_GazM1", 75],
	["LIB_GazM1_dirty", 75],
	["LIB_CIV_FFI_CitC4", 75],
	["LIB_CIV_FFI_CitC4_3", 75],
	["LIB_US_NAC_Willys_MB", 75],
	["LIB_US6_Open_Cargo", 150],
	["LIB_GazM1_SOV", 75],
	["LIB_Kfz1_Hood_camo", 75],
	["LIB_Kfz1_MG42_camo", 75],
	["LIB_SdKfz_7", 100],
	["LIB_SdKfz251", 100],
	["LIB_SdKfz251_FFV", 100],
	["LIB_FlakPanzerIV_Wirbelwind", 150],
	["LIB_SdKfz_7_AA", 150],
	["LIB_SdKfz124", 150],
	["LIB_T34_76_captured", 200],
	["LIB_PzKpfwIV_H", 200],
	["LIB_PzKpfwIV_H_tarn51c", 200],
	["LIB_PzKpfwVI_E_tarn51d", 200],
	["LIB_PzKpfwVI_E_tarn52d", 200],
	["LIB_Kfz1_camo", 150],
	["LIB_OpelBlitz_Open_Y_Camo", 100],
	["LIB_OpelBlitz_Tent_Y_Camo", 100],
	["LIB_OpelBlitz_Ammo", 100],
	["LIB_OpelBlitz_Parm", 100],
	["LIB_OpelBlitz_Fuel", 100]
];

// Additional Mod WW2 Tank
if (isClass(configFile >> "CfgPatches" >> "FA_WW2_Tanks")) then {
  R3F_LOG_CFG_can_transport_cargo pushBack ["FA_Pz38t", 100];
  R3F_LOG_CFG_can_transport_cargo pushBack ["FA_T26_Captured", 100];
  R3F_LOG_CFG_can_transport_cargo pushBack ["FA_Panzer2", 100];
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
	["B_Boat_Transport_01_F", 50]
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["B_Boat_Transport_01_F", 5]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"B_Boat_Transport_01_F"
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
	["Concrete_Wall_EP1", 20],
	["Land_WW2_BET_Sandsack", 5]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"FenceWood",
	"Concrete_Wall_EP1",
	"Land_WW2_French_Wall_Small_Long_01",
	"Land_WW2_French_Wall_Small_Short_01",
	"Land_WW2_French_Wall_Tall_Short_01",
	"Land_WW2_French_Wall_Tall_Door_01",
	"Land_WW2_French_Gate_03",
	"Land_WW2_BET_Sandsack"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];

//--------------- Static ---------------

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["LIB_MG34_Lafette_Deployed", 5],
	["LIB_MG42_Lafette_Deployed", 5],
	["LIB_GER_SearchLight", 5],
	["LIB_GrWr34", 5],
	["LIB_Nebelwerfer41_Camo", 10],
	["LIB_leFH18", 25],
	["LIB_leFH18_AT", 25],
	["LIB_FlaK_30", 50],
	["LIB_FlaK_38", 50],
	["LIB_Flakvierling_38", 75],
	["LIB_Pak40", 100]
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
	"LIB_GER_SearchLight",
	"LIB_MG34_Lafette_Deployed",
	"LIB_MG42_Lafette_Deployed",
	"LIB_GrWr34",
	"LIB_Nebelwerfer41_Camo",
	"LIB_leFH18",
	"LIB_leFH18_AT",
	"LIB_FlaK_30",
	"LIB_FlaK_38",
	"LIB_Flakvierling_38",
	"LIB_Pak40"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];
