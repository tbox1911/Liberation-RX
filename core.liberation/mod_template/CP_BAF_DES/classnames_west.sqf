// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_color_friendly = "ColorKhaki";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "CUP_B_Merlin_HC3_GB";  // comment to use value from lobby/server.cfg
Respawn_truck_typename = "CUP_B_LR_Ambulance_GB_D";
ammo_truck_typename = "CUP_B_MTVR_Ammo_BAF_DES";
fuel_truck_typename = "CUP_B_MTVR_Refuel_BAF_DES";
repair_truck_typename = "CUP_B_MTVR_Repair_BAF_DES";
pilot_classname = "CUP_B_BAF_Soldier_Pilot_DDPM";
crewman_classname = "CUP_B_BAF_Soldier_Crew_DDPM";
A3W_BoxWps = "CUP_LocalBasicWeaponsBox";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["CUP_B_BAF_Soldier_Rifleman_DDPM",1,0,0,0],
	["CUP_B_BAF_Soldier_Medic_DDPM",1,0,0,0],
	["CUP_B_BAF_Soldier_Engineer_DDPM",1,0,0,0],
	["CUP_B_BAF_Soldier_Grenadier_DDPM",1,0,0,GRLIB_perm_inf],
	["CUP_B_BAF_Soldier_Marksman_DDPM",1,0,0,GRLIB_perm_inf],
	["CUP_B_BAF_Soldier_RiflemanLAT_DDPM",1,0,0,0],
	["CUP_B_BAF_Soldier_AutoRifleman_DDPM",1,0,0,GRLIB_perm_log],
	["CUP_B_BAF_Soldier_SharpShooter_DDPM",1,0,0,GRLIB_perm_inf],
	["CUP_B_BAF_Soldier_HeavyGunner_DDPM",1,0,0,GRLIB_perm_inf],
	["CUP_B_BAF_Soldier_RiflemanAT_DDPM",1,0,0,GRLIB_perm_log],
	["CUP_B_BAF_Soldier_AA_DDPM",1,0,0,GRLIB_perm_log],
	["CUP_B_BAF_Soldier_AT_DDPM",1,0,0,GRLIB_perm_log],
	["CUP_B_BAF_Sniper_DDPM",1,0,0,GRLIB_perm_log],
	["CUP_B_BAF_Soldier_Paratrooper_DDPM",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [
	"CUP_B_BAF_Soldier_RiflemanAT_DDPM",
	"CUP_B_BAF_Soldier_AA_DDPM",
	"CUP_B_BAF_Soldier_AT_DDPM"
];	

light_vehicles = [
	["CUP_O_TT650_TKA",1,5,1,0],
	["CUP_B_M1030_USMC",1,5,1,GRLIB_perm_log],
	["B_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["C_Boat_Transport_02_F",2,25,2,GRLIB_perm_log],
	["CUP_B_MK10_GB",5,30,5,GRLIB_perm_log],
	//["C_Van_01_transport_F",1,15,1,0],
	["CUP_B_T810_Unarmed_CZ_DES",1,15,1,0],
	["CUP_B_T810_Armed_CZ_DES",5,30,5,GRLIB_perm_log],
	["CUP_B_MTVR_BAF_DES",5,30,5,GRLIB_perm_tank],
	["CUP_B_LR_Transport_GB_D",2,10,2,0],
	["CUP_B_LR_Special_M2_GB_D",2,20,2,0],
	["CUP_B_LR_Special_GMG_GB_D",2,20,2,0],
	["CUP_B_Jackal2_L2A1_GB_D",1,100,1,0],
	["CUP_B_Jackal2_GMG_GB_D",1,110,1,0],
	["CUP_B_Ridgback_HMG_GB_D",1,150,1,GRLIB_perm_inf],
	["CUP_B_Ridgback_GMG_GB_D",1,125,1,GRLIB_perm_inf],
	["CUP_B_Wolfhound_LMG_GB_D",5,200,2,GRLIB_perm_inf],
	["CUP_B_Wolfhound_GMG_GB_D",5,225,2,GRLIB_perm_log]
];

heavy_vehicles = [
	["CUP_B_Mastiff_HMG_GB_D",10,400,10,GRLIB_perm_log],
	["CUP_B_Mastiff_GMG_GB_D",10,400,10,GRLIB_perm_log],
	["CUP_B_BAF_Coyote_L2A1_D",10,500,10,GRLIB_perm_tank],
	["CUP_B_BAF_Coyote_GMG_D",10,500,10,GRLIB_perm_tank],
	["CUP_B_MCV80_GB_D",10,600,10,GRLIB_perm_tank],
	["CUP_B_MCV80_GB_D_SLAT",10,600,10,GRLIB_perm_tank],
	["CUP_B_FV510_GB_D",15,800,15,GRLIB_perm_tank],
	["CUP_B_FV510_GB_D_SLAT",15,800,15,GRLIB_perm_air],
	["CUP_B_Challenger2_Desert_BAF",15,1200,15,GRLIB_perm_max],
	["CUP_B_Challenger2_2CD_BAF",15,1250,15,GRLIB_perm_max]
];

air_vehicles = [
	["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_air],
	["CUP_B_AC47_Spooky_USA",1,150,5,GRLIB_perm_max],
	["CUP_B_AW159_Unarmed_GB",1,50,5,GRLIB_perm_log],
	["CUP_B_AW159_GB",5,200,10,GRLIB_perm_air],
	["CUP_B_AW159_RN_Blackcat",5,200,10,GRLIB_perm_tank],	
	["CUP_B_SA330_Puma_HC1_BAF",5,300,10,GRLIB_perm_air],
	["CUP_B_Merlin_HC3_GB",10,500,15,GRLIB_perm_tank],
	["CUP_B_Merlin_HC3_Armed_GB",10,1500,15,GRLIB_perm_air],
	["CUP_B_Merlin_HC4_GB",10,1500,15,GRLIB_perm_max],
	["CUP_B_AH1_DL_BAF",10,1300,15,GRLIB_perm_air],
	["CUP_B_CH47F_GB",20,2500,40,GRLIB_perm_max],
	["CUP_B_GR9_DYN_GB",20,3000,40,GRLIB_perm_max],
	["CUP_B_F35B_BAF",20,4500,40,GRLIB_perm_max],
	["CUP_B_C130J_Cargo_GB",20,3000,50,GRLIB_perm_max]
];

blufor_air = [
	"CUP_B_AW159_RN_Blackcat",
	"CUP_B_AH1_DL_BAF",
	"CUP_B_GR9_DYN_GB",
	"CUP_B_F35B_BAF"
];

boats_west = [
  "CUP_B_MK10_GB"
];

static_vehicles = [
	["CUP_B_SearchLight_static_BAF_DDPM",0,10,0,GRLIB_perm_log],
	["CUP_B_L111A1_BAF_DDPM",0,50,0,GRLIB_perm_log],
	["CUP_B_L111A1_MiniTripod_BAF_DDPM",0,70,0,GRLIB_perm_tank],
	["CUP_B_L16A2_BAF_DDPM",0,100,0,GRLIB_perm_max],
	["CUP_B_M119_HIL",0,150,0,GRLIB_perm_air],
	["CUP_WV_B_CRAM",0,200,0,GRLIB_perm_air],
	["CUP_WV_B_RAM_Launcher",0,250,0,GRLIB_perm_max],
	["CUP_WV_B_SS_Launcher",0,250,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"CUP_WV_B_CRAM",
	"CUP_WV_B_RAM_Launcher",
	"CUP_WV_B_SS_Launcher"
];

support_vehicles_west = [
	["CUP_B_nM1038_Repair_USA_DES",5,15,5,GRLIB_perm_inf],
	["CUP_B_MTVR_Refuel_BAF_DES",5,15,20,GRLIB_perm_inf],
	["CUP_BOX_GB_WpsLaunch_F",0,150,0,GRLIB_perm_tank],
	["CUP_B_FV432_Bulldog_GB_D",10,2000,20,GRLIB_perm_max]
];

buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["CUP_FlagCarrierBAF",0,0,0,0]
];

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"CUP_B_BAF_Soldier_SquadLeader_DDPM",
	"CUP_B_BAF_Soldier_Medic_DDPM",
	"CUP_B_BAF_Soldier_Grenadier_DDPM",
	"CUP_B_BAF_Soldier_AutoRifleman_DDPM",
	"CUP_B_BAF_Soldier_AT_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM"
	];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
	"CUP_B_BAF_Soldier_SquadLeader_DDPM",
	"CUP_B_BAF_Soldier_Medic_DDPM",
	"CUP_B_BAF_Soldier_Marksman_DDPM",
	"CUP_B_BAF_Soldier_AutoRifleman_DDPM",
	"CUP_B_BAF_Soldier_HeavyGunner_DDPM",
	"CUP_B_BAF_Soldier_SharpShooter_DDPM",
	"CUP_B_BAF_Soldier_AT_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM",	
	"CUP_B_BAF_Soldier_Rifleman_DDPM"
	];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	"CUP_B_BAF_Soldier_SquadLeader_DDPM",
	"CUP_B_BAF_Soldier_Medic_DDPM",
	"CUP_B_BAF_Soldier_AT_DDPM",
	"CUP_B_BAF_Soldier_AT_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM"
	];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
	"CUP_B_BAF_Soldier_SquadLeader_DDPM",
	"CUP_B_BAF_Soldier_Medic_DDPM",
	"CUP_B_BAF_Soldier_AA_DDPM",
	"CUP_B_BAF_Soldier_AA_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM"
	];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"CUP_B_BAF_Soldier_SquadLeader_DDPM",
	"CUP_B_BAF_Soldier_Medic_DDPM",
	"CUP_B_BAF_Soldier_AA_DDPM",
	"CUP_B_BAF_Soldier_AT_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM",
	"CUP_B_BAF_Soldier_Rifleman_DDPM"
	];
};

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
	"B_UAV_01_F",
	"B_UAV_02_dynamicLoadout_F",
	"B_T_UAV_03_dynamicLoadout_F",
	"B_UAV_05_F",
	"B_UAV_06_F",
	"C_UAV_06_F",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "CUP_B_FV432_Bulldog_GB_D"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"CUP_B_FV432_Bulldog_GB_D"
];

vehicle_rearm_sources_west = [
	"CUP_B_FV432_Bulldog_GB_D"
];

vehicle_big_units_west = [
	"CUP_B_MK10_GB"
];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [
	"CUP_B_SearchLight_static_BAF_DDPM",
	"CUP_B_L111A1_BAF_DDPM",
	"CUP_B_L111A1_MiniTripod_BAF_DDPM",
	"CUP_B_L16A2_BAF_DDPM",
	"CUP_B_M119_HIL"
];

box_transport_config_west = [
	[ "CUP_B_MTVR_BAF_DES", -6.5, [0, -0.4, 0.3], [0, -2.1, 0.3] ],
	[ "CUP_B_T810_Unarmed_CZ_DES", -5.5, [0, 0.3, 0], [0, -1.25, 0] ],
	[ "CUP_B_T810_Armed_CZ_DES", -5.5, [0, 0.3, -0.3], [0, -1.25, -0.3] ]
];

//GRLIB_AirDrop_1 = [];
//GRLIB_AirDrop_2 = [];
GRLIB_AirDrop_3 = [
	"CUP_B_T810_Armed_CZ_DES",
	"CUP_B_LR_Special_M2_GB_D",
	"CUP_B_Jackal2_L2A1_GB_D",
	"CUP_B_Ridgback_HMG_GB_D"	
];
GRLIB_AirDrop_4 = [
	"CUP_B_T810_Unarmed_CZ_DES",
	"CUP_B_T810_Armed_CZ_DES",
	"CUP_B_MTVR_BAF_DES"
];
GRLIB_AirDrop_5 = [
	"CUP_B_Mastiff_HMG_GB_D",
	"CUP_B_BAF_Coyote_L2A1_D",
	"CUP_B_Wolfhound_LMG_GB_D"
];
//GRLIB_AirDrop_6 = [];