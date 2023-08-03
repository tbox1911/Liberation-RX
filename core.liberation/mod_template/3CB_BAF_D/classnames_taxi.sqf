// taxi_helipad_type = "Land_HelipadCivil_F";		// use default from addons\TAXI\taxi_classname.sqf

// if not defined, use the default from addons\TAXI\taxi_classname.sqf

overide_taxi_type_2 = [				// Player Count <= 2
	"RHS_MELB_H6M",			// max 3
	"RHS_MELB_MH6M"			// max 6
];

overide_taxi_type_6 = [				// Player Count 2 - 6
	"RHS_MELB_MH6M",
	"I_E_Heli_light_03_unarmed_F"
];

overide_taxi_type_8 = [				// Player Count 6-8
	"UK3CB_BAF_Wildcat_AH1_TRN_8A_DPMW" 
];

overide_taxi_type_14 = [			// Player Count > 8
	"UK3CB_BAF_Merlin_HC3_18_DPMW"
];

