//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
  "SPE_FW190F8"
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
	["SPE_FW190F8", 50]

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
  //Cars:
  "SPE_OpelBlitz",
  "SPE_OpelBlitz_Flak38",
  "SPE_OpelBlitz_Ambulance",
  "SPE_OpelBlitz_Ammo",
  "SPE_OpelBlitz_Open",
  "SPE_OpelBlitz_Repair",
  "SPE_OpelBlitz_Fuel",
  //Spz:
  "SPE_SdKfz250_1",
  //Tanks:
  "SPE_PzKpfwIII_J",
  "SPE_PzKpfwIII_L",
  "SPE_PzKpfwIII_M",
  "SPE_PzKpfwIII_N",
  "SPE_PzKpfwIV_G",
  "SPE_PzKpfwVI_H1",
  "SPE_Nashorn"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
  //Cars:
  "SPE_OpelBlitz",
  "SPE_OpelBlitz_Flak38",
  "SPE_OpelBlitz_Ambulance",
  "SPE_OpelBlitz_Ammo",
  "SPE_OpelBlitz_Open",
  "SPE_OpelBlitz_Repair",
  "SPE_OpelBlitz_Fuel",
  //Spz:
  "SPE_SdKfz250_1",
  //Tanks:
  "SPE_PzKpfwIII_J",
  "SPE_PzKpfwIII_L",
  "SPE_PzKpfwIII_M",
  "SPE_PzKpfwIII_N",
  "SPE_PzKpfwIV_G",
  "SPE_PzKpfwVI_H1",
  "SPE_Nashorn"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
  //Cars:
  "SPE_OpelBlitz",
  "SPE_OpelBlitz_Flak38",
  "SPE_OpelBlitz_Ambulance",
  "SPE_OpelBlitz_Ammo",
  "SPE_OpelBlitz_Open",
  "SPE_OpelBlitz_Repair",
  "SPE_OpelBlitz_Fuel",
  //Spz:
  "SPE_SdKfz250_1",
  //Tanks:
  "SPE_PzKpfwIII_J",
  "SPE_PzKpfwIII_L",
  "SPE_PzKpfwIII_M",
  "SPE_PzKpfwIII_N",
  "SPE_PzKpfwIV_G",
  "SPE_PzKpfwVI_H1",
  "SPE_Nashorn"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
  ["SPE_OpelBlitz", 50],
  ["SPE_OpelBlitz_Flak38", 50],
  ["SPE_OpelBlitz_Ambulance", 50],
  ["SPE_OpelBlitz_Ammo", 50],
  ["SPE_OpelBlitz_Open", 50],
  ["SPE_OpelBlitz_Repair", 50],
  ["SPE_OpelBlitz_Fuel", 50],
  ["SPE_US_M3_Halftrack", 50],
  ["SPE_SdKfz250_1", 50],
  ["SPE_PzKpfwIII_J", 50],
  ["SPE_PzKpfwIII_L", 50],
  ["SPE_PzKpfwIII_M", 50],
  ["SPE_PzKpfwIII_N", 50],
  ["SPE_PzKpfwIV_G", 50],
  ["SPE_PzKpfwVI_H1", 50],
  ["SPE_Nashorn", 50]
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

];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[

];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[

];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[

];

//--------------- Building ---------------
R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
];
//--------------- Static ---------------

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
	["SPE_GrW278_1", 5]
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
  "SPE_leFH18",
  "SPE_leFH18_AT",
  "SPE_Pak40"
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
  "SPE_leFH18",
  "SPE_leFH18_AT",
  "SPE_GrW278_1",
  "SPE_FlaK_30",
  "SPE_FlaK_36",
  "SPE_FlaK_36_AA",
  "SPE_FlaK_38",
  "SPE_MG34_Lafette_Deployed",
  "SPE_MG34_Lafette_Trench_Deployed",
  "SPE_MG34_Lafette_low_Deployed",
  "SPE_MG34_Bipod",
  "SPE_MG42_Lafette_Deployed",
  "SPE_MG42_Lafette_trench_Deployed",
  "SPE_MG42_Lafette_low_Deployed",
  "SPE_MG42_Bipod",
  "SPE_Pak40",
  "SPE_GER_SearchLight"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
  "SPE_leFH18",
  "SPE_leFH18_AT",
  "SPE_Pak40"
];

//--------------- Camping ---------------

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
  "Land_SPE_Guardbox",
  "Land_SPE_Tent_03",
  "Land_SPE_Netting_01",
  "Land_SPE_Sandbag_Short",
  "Land_SPE_Sandbag_Short_Low",
  "Land_SPE_Sandbag_Long",
  "Land_SPE_Sandbag_Long_Thick",
  "Land_SPE_Sandbag_Gun_Hole",
  "Land_SPE_Sandbag_Long_Line",
  "Land_SPE_Sandbag_Nest",
  "Land_SPE_BarbedWire_01",
  "Land_SPE_BarbedWire_03",
  "Land_SPE_BarbedWire_04",
  "SPE_FlagCarrier_GER"
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];
