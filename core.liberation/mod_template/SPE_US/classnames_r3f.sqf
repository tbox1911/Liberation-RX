//--------------- Air ---------------
R3F_LOG_CFG_can_tow = R3F_LOG_CFG_can_tow +
[
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"SPE_P47"
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
	["SPE_P47", 50]

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
  //Cars:
  "SPE_US_M16_Halftrack",
  "SPE_US_M3_Halftrack_Ambulance",
  "SPE_US_M3_Halftrack_Ammo",
  "SPE_US_M3_Halftrack_Repair",
  "SPE_US_M3_Halftrack_Fuel",
  "SPE_US_M3_Halftrack_Unarmed",
  "SPE_US_M3_Halftrack_Unarmed_Open",
  "SPE_US_M3_Halftrack",
  //Tanks:
  "SPE_M10",
  "SPE_M18_Hellcat",
  "SPE_M4A0_75_Early",
  "SPE_M4A0_75",
  "SPE_M4A1_76",
  "SPE_M4A1_75",
  "SPE_M4A1_T34_Calliope_Direct",
  "SPE_M4A1_T34_Calliope"
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
  //Cars:
  "SPE_US_M16_Halftrack",
  "SPE_US_M3_Halftrack_Ambulance",
  "SPE_US_M3_Halftrack_Ammo",
  "SPE_US_M3_Halftrack_Repair",
  "SPE_US_M3_Halftrack_Fuel",
  "SPE_US_M3_Halftrack_Unarmed",
  "SPE_US_M3_Halftrack_Unarmed_Open",
  "SPE_US_M3_Halftrack",
  //Tanks:
  "SPE_M10",
  "SPE_M18_Hellcat",
  "SPE_M4A0_75_Early",
  "SPE_M4A0_75",
  "SPE_M4A1_76",
  "SPE_M4A1_75",
  "SPE_M4A1_T34_Calliope_Direct",
  "SPE_M4A1_T34_Calliope"
];

R3F_LOG_CFG_can_lift = R3F_LOG_CFG_can_lift +
[
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
  //Cars:
  "SPE_US_M16_Halftrack",
  "SPE_US_M3_Halftrack_Ambulance",
  "SPE_US_M3_Halftrack_Ammo",
  "SPE_US_M3_Halftrack_Repair",
  "SPE_US_M3_Halftrack_Fuel",
  "SPE_US_M3_Halftrack_Unarmed",
  "SPE_US_M3_Halftrack_Unarmed_Open",
  "SPE_US_M3_Halftrack",
  //Tanks:
  "SPE_M10",
  "SPE_M18_Hellcat",
  "SPE_M4A0_75_Early",
  "SPE_M4A0_75",
  "SPE_M4A1_76",
  "SPE_M4A1_75",
  "SPE_M4A1_T34_Calliope_Direct",
  "SPE_M4A1_T34_Calliope"
];

R3F_LOG_CFG_can_transport_cargo = R3F_LOG_CFG_can_transport_cargo +
[
  ["SPE_US_M16_Halftrack", 50],
  ["SPE_US_M3_Halftrack_Ambulance", 50],
  ["SPE_US_M3_Halftrack_Ammo", 50],
  ["SPE_US_M3_Halftrack_Repair", 50],
  ["SPE_US_M3_Halftrack_Fuel", 50],
  ["SPE_US_M3_Halftrack_Unarmed", 50],
  ["SPE_US_M3_Halftrack_Unarmed_Open", 50],
  ["SPE_US_M3_Halftrack", 50],
  ["SPE_M10", 50],
  ["SPE_M18_Hellcat", 50],
  ["SPE_M4A0_75_Early", 50],
  ["SPE_M4A0_75", 50],
  ["SPE_M4A1_76", 50],
  ["SPE_M4A1_75", 50],
  ["SPE_M4A1_T34_Calliope_Direct", 50],
  ["SPE_M4A1_T34_Calliope", 50]
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
	["SPE_M1_81", 5]
];

R3F_LOG_CFG_can_be_towed = R3F_LOG_CFG_can_be_towed +
[
	"SPE_57mm_M1",
	"SPE_M45_Quadmount"
];

R3F_LOG_CFG_can_be_moved_by_player = R3F_LOG_CFG_can_be_moved_by_player +
[
  "SPE_57mm_M1",
  "SPE_M1_81",
  "SPE_M1919_M2",
  "SPE_M1919_M2_Trench_Deployed",
  "SPE_M1919A6_Bipod",
  "SPE_M45_Quadmount"
];

R3F_LOG_CFG_can_be_lifted = R3F_LOG_CFG_can_be_lifted +
[
	"SPE_57mm_M1",
	"SPE_M45_Quadmount"
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
  "SPE_FlagCarrier_USA"
];

R3F_LOG_CFG_can_be_transported_cargo = R3F_LOG_CFG_can_be_transported_cargo +
[
];
