// *** FRIENDLIES ***
// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

FOB_typename = "Land_DeconTent_01_CSAT_greenhex_F";
huron_typename = "O_Heli_Transport_04_black_F";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "O_T_Truck_03_device_ghex_F";
Respawn_truck_typename = "rhs_gaz66_ap2_msv" ;
ammo_truck_typename = "O_Truck_03_ammo_F";
fuel_truck_typename = "O_Truck_03_fuel_F";
repair_truck_typename = "O_Truck_03_Repair_F";
repair_sling_typename = "Land_Pod_Heli_Transport_04_repair_F";
fuel_sling_typename = "Land_Pod_Heli_Transport_04_fuel_F";
ammo_sling_typename = "Land_Pod_Heli_Transport_04_ammo_F";
medic_sling_typename = "Land_Pod_Heli_Transport_04_medevac_F";
commander_classname = "O_officer_F";
pilot_classname = "O_Helipilot_F";
crewman_classname = "O_crew_F";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["O_soldier_F",1,0,0,0],
	["O_medic_F",1,0,0,0],
	["O_engineer_F",1,0,0,0],
	["O_soldier_GL_F",1,0,0,GRLIB_perm_inf],
	["O_soldier_M_F",1,0,0,GRLIB_perm_inf],
	["O_soldier_LAT_F",1,0,0,0],
	["O_Sharpshooter_F",1,0,0,GRLIB_perm_inf],
	["O_HeavyGunner_F",1,0,0,GRLIB_perm_inf],
	["O_recon_F",1,0,0,GRLIB_perm_log],
	["O_recon_M_F",1,0,0,GRLIB_perm_log],
	["O_recon_LAT_F",1,0,0,GRLIB_perm_log],
	["O_soldier_AA_F",1,0,0,GRLIB_perm_log],
	["O_soldier_AT_F",1,0,0,GRLIB_perm_log],
	["O_sniper_F",1,0,0,GRLIB_perm_log],
	["O_soldier_PG_F",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

light_vehicles = [
	["rhs_tigr_msv",1,10,1,0],
	["rhs_tigr_3camo_msv",1,10,1,0],
	["rhs_tigr_sts_3camo_msv",1,30,1,GRLIB_perm_inf],
	["rhs_tigr_sts_msv",1,30,1,GRLIB_perm_inf],
	["rhs_gaz66_vv",1,30,1,GRLIB_perm_inf],
	["rhs_kamaz5350_vv",1,30,1,GRLIB_perm_inf],
	["rhs_kamaz5350_open_vv",1,30,1,GRLIB_perm_inf],
	["RHS_Ural_VV_01",1,30,1,GRLIB_perm_inf],
	["RHS_Ural_Open_VV_01",1,30,1,GRLIB_perm_inf],
	["rhs_btr80_msv",5,140,3,GRLIB_perm_inf],
	["rhs_btr80a_msv",8,150,5,GRLIB_perm_log],
	["RHS_Ural_Zu23_VV_01",10,200,10,GRLIB_perm_log]
];

heavy_vehicles = [
	["rhs_bmp1p_msv",10,140,10,GRLIB_perm_log],
	["rhs_bmp2k_msv",10,140,10,GRLIB_perm_log],
	["rhs_brm1k_msv",10,140,10,GRLIB_perm_log],
	["rhs_bmp1_msv",10,140,10,GRLIB_perm_log],
	["rhs_Ob_681_2",15,160,15,GRLIB_perm_log],
	["rhs_prp3_msv",10,110,10,GRLIB_perm_log],
	["rhs_bmd2m",10,80,10,GRLIB_perm_log],                     
	["rhs_t72ba_tv",15,400,20,GRLIB_perm_tank],
	["rhs_t72bb_tv",15,400,20,GRLIB_perm_tank],
	["rhs_t72bc_tv",15,400,20,GRLIB_perm_tank],
	["rhs_t80",20,500,25,GRLIB_perm_tank],
	["rhs_t80a",20,500,25,GRLIB_perm_tank],
	["rhs_t80b",20,500,25,GRLIB_perm_tank],
	["rhs_t80bk",20,500,25,GRLIB_perm_tank],
	["rhs_t80bv",20,550,25,GRLIB_perm_tank],
	["rhs_t90sm_tv",20,550,25,GRLIB_perm_tank],
	["rhs_t90am_tv",20,550,25,GRLIB_perm_tank],
	["rhs_t90_tv",10,550,15,GRLIB_perm_tank],
	["rhs_t90a_tv",10,550,15,GRLIB_perm_tank],
	["rhs_t90saa_tv",10,550,15,GRLIB_perm_tank],
	["rhs_zsu234_aa",10,500,15,GRLIB_perm_air],
	["O_T_MBT_04_command_F",20,700,30,GRLIB_perm_air],
	["O_T_MBT_04_cannon_F",20,700,30,GRLIB_perm_air],
	["rhs_9k79_K",150,10000,300,GRLIB_perm_air],
	["I_E_Truck_02_MRL_F",50,1300,100,GRLIB_perm_air]
];

air_vehicles = [
	["O_UAV_01_F",1,10,5,GRLIB_perm_log],
	["O_UAV_06_F",1,30,5,GRLIB_perm_tank],
	["O_UAV_02_dynamicLoadout_F",5,1000,5,GRLIB_perm_air],
	["O_T_UAV_04_CAS_F",5,1500,10,GRLIB_perm_max],
	["rhs_ka60_grey",20,300,30,0],
	["B_Heli_Light_01_F",20,700,30,GRLIB_perm_air],
	["B_Heli_Light_01_dynamicLoadout_F",20,700,30,GRLIB_perm_air],
	["RHS_Mi8mt_Cargo_vdv",5,500,10,GRLIB_perm_inf],
	["RHS_Mi8T_vdv",10,500,20,GRLIB_perm_inf],
	["RHS_Mi24P_vdv",10,500,20,GRLIB_perm_air],
    ["RHS_Mi24V_vdv",10,500,20,GRLIB_perm_air],
    ["RHS_Mi8MTV3_vdv",10,5000,20,GRLIB_perm_air],
    ["RHS_Mi8mtv3_Cargo_vdv",10,800,20,GRLIB_perm_air],
    ["RHS_Mi8MTV3_heavy_vdv",10,800,20,GRLIB_perm_air],
    ["RHS_Ka52_vvsc",10,1500,20,GRLIB_perm_air],
    ["rhs_mi28n_vvsc",10,2000,20,GRLIB_perm_air],
	//["O_T_VTOL_02_infantry_dynamicLoadout_F", 10,2500,20,GRLIB_perm_max],
	//["O_T_VTOL_02_vehicle_dynamicLoadout_F", 10,2500,20,GRLIB_perm_max],
	["rhs_mig29s_vvs",15,2000,15,GRLIB_perm_max],
	["RHS_Su25SM_vvs",15,2000,15,GRLIB_perm_max],  
    ["RHS_T50_vvs_generic",15,2000,15,GRLIB_perm_max],
	["RHS_TU95MS_vvs_old",50,9000,50,GRLIB_perm_max],
	["O_Plane_CAS_02_dynamicLoadout_F",20,4000,40,GRLIB_perm_max],
	["O_Plane_Fighter_02_F",20,4500,40,GRLIB_perm_max],
	["O_Plane_Fighter_02_Stealth_F",20,4500,40,GRLIB_perm_max]
];

blufor_air = [
	"rhs_mi28n_vvsc_dynamicLoadout_F",
	"RHS_Ka52_vvsc_dynamicLoadout_F",
	"O_T_VTOL_02_infantry_dynamicLoadout_F",
	"RHS_Su25SM_vvs_dynamicLoadout_F",
	"rhs_mig29s_vvs",
	"RHS_T50_vvs_generic"
];

static_vehicles = [
	["O_UGV_02_Demining_F",0,5,0,GRLIB_perm_inf],
	["rhs_Kornet_9M133_2_vmf",0,5,0,GRLIB_perm_inf],
	["rhs_Igla_AA_pod_vmf",0,5,0,GRLIB_perm_inf],
	["RHS_AGS30_TriPod_VMF",0,5,0,GRLIB_perm_inf],
	["rhs_KORD_VMF",0,5,0,GRLIB_perm_inf],
	["rhs_KORD_high_VMF",0,5,0,GRLIB_perm_inf],
	["RHS_NSV_TriPod_VMF",0,5,0,GRLIB_perm_inf],
	["rhs_SPG9M_VMF",0,5,0,GRLIB_perm_inf],
	["RHS_ZU23_VMF",0,50,0,GRLIB_perm_inf],
	["RHS_M119_WD",10,150,0,GRLIB_perm_log],
	["B_SAM_System_02_F",10,150,0,GRLIB_perm_log],
	["B_Ship_Gun_01_F",10,150,0,GRLIB_perm_log],
	["B_SAM_System_01_F",10,500,0,GRLIB_perm_max],
	["O_Radar_System_02_F",10,500,0,GRLIB_perm_max],
	["B_AAA_System_01_F",10,500,0,GRLIB_perm_max],
	["O_SAM_System_04_F",10,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"B_AAA_System_01_F",
	"B_SAM_System_02_F",
	"O_SAM_System_04_F"
];

support_vehicles_west = [
	["rhs_D30_msv",10,150,0,GRLIB_perm_log],
	["rhs_D30_at_msv",10,150,0,GRLIB_perm_log],
	["rhs_gaz66_ammo_vv",1,30,1,GRLIB_perm_inf],
	["rhs_kamaz5350_ammo_vv",1,30,1,GRLIB_perm_inf],
	["RHS_Ural_Ammo_VV_01",1,30,1,GRLIB_perm_inf],
	["RHS_Ural_Fuel_VV_01",1,30,1,GRLIB_perm_inf],
	["RHS_Ural_Repair_VV_01",1,30,1,GRLIB_perm_inf],
	["rhs_weapon_crate",0,150,0,GRLIB_perm_tank],
	["rhs_spec_weapons_crate",0,150,0,GRLIB_perm_tank],
	["rhs_launcher_crate",0,150,0,GRLIB_perm_tank],
	["rhs_gear_crate",0,150,0,GRLIB_perm_tank],
	["rhs_mags_crate",0,150,0,GRLIB_perm_tank]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["Flag_CSAT_F",0,0,0,0]
];

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"rhs_vmf_emr_medic",
	"rhs_vmf_emr_at",
	"rhs_vmf_emr_efreitor",
	"rhs_vmf_emr_junior_sergeant",
	"rhs_vmf_emr_rifleman",
	"rhs_vmf_emr_grenadier",
	"rhs_vmf_emr_machinegunner"
  ];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
    "rhs_vmf_emr_medic",
    "rhs_vmf_emr_at",
    "rhs_vmf_emr_efreitor",
    "rhs_vmf_emr_medic",
    "rhs_vmf_emr_at",
    "rhs_vmf_emr_efreitor",
    "rhs_vmf_emr_junior_sergeant",
    "rhs_vmf_emr_rifleman",
    "rhs_vmf_emr_grenadier",
    "rhs_vmf_emr_machinegunner"
  ];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
    "rhs_vmf_emr_medic",
    "rhs_vmf_emr_at",
    "rhs_vmf_emr_medic",
    "rhs_vmf_emr_at",
    "rhs_vmf_emr_efreitor",
    "rhs_vmf_emr_at",
    "rhs_vmf_emr_rifleman",
    "rhs_vmf_emr_grenadier",
    "rhs_vmf_emr_machinegunner",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_marksman",
    "rhs_vmf_emr_at"
  ];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
	"rhs_vmf_emr_medic",
    "rhs_vmf_emr_medic",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_efreitor",
    "rhs_vmf_emr_junior_sergeant",
    "rhs_vmf_emr_rifleman",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_machinegunner",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_marksman",
    "rhs_vmf_emr_aa"
  ];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"rhs_vmf_emr_medic",
	"rhs_vmf_emr_medic",
    "rhs_vmf_emr_at",
    "rhs_vmf_emr_efreitor",
    "rhs_vmf_emr_medic",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_efreitor",
    "rhs_vmf_emr_junior_sergeant",
    "rhs_vmf_emr_rifleman",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_machinegunner",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_marksman",
	"rhs_vmf_emr_machinegunner",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_marksman",
    "rhs_vmf_emr_aa"
  ];
};
if ( isNil "blufor_squad_recon" ) then { blufor_squad_recon = [] };
if ( count blufor_squad_recon == 0 ) then { blufor_squad_recon = [
	"rhs_vmf_emr_medic",
	"rhs_vmf_emr_medic",
    "rhs_vmf_emr_at",
    "rhs_vmf_emr_efreitor",
    "rhs_vmf_emr_medic",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_efreitor",
    "rhs_vmf_emr_junior_sergeant",
    "rhs_vmf_emr_rifleman",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_machinegunner",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_marksman",
	"rhs_vmf_emr_machinegunner",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_marksman",
	"rhs_vmf_emr_medic",
    "rhs_vmf_emr_medic",
    "rhs_vmf_emr_aa",
    "rhs_vmf_emr_aa"
  ];
};

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_recon,25,500,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,2500,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
	"O_UAV_01_F",
	"O_UAV_02_dynamicLoadout_F",
	"O_T_UAV_03_F",
	"O_UAV_05_F",
	"O_UAV_06_F",
	"O_UGV_01_F",
	"O_UGV_01_rcws_F",
	"O_UGV_02_Demining_F"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
];

vehicle_rearm_sources_west = [
];

vehicle_artillery_west = [
	"O_Mortar_01_F",
	"I_E_Truck_02_MRL_F",
	"O_MBT_02_arty_F"
];

vehicle_big_units_west = [
	"Land_Cargo_Tower_V1_F",
	"B_T_VTOL_01_infantry_F",
	"B_T_VTOL_01_vehicle_F",
	"B_T_VTOL_01_armed_F",
	"O_T_VTOL_01_infantry_F",
	"O_T_VTOL_01_vehicle_F",
	"O_T_VTOL_01_armed_F",
	"Land_SM_01_shed_F",
	"Land_Hangar_F"
];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];

box_transport_config_west = [

];