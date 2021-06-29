// *** FRIENDLIES ***
// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "RHS_CH_47F";
FOB_typename = "Land_DeconTent_01_NATO_tropic_F";
Respawn_truck_typename = "rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy";  //"rhsusf_m113_usarmy_medical"
//FOB_box_typename = "B_Slingload_01_Cargo_F";
//FOB_truck_typename = "B_Truck_01_box_F";
commander_classname = "rhsusf_army_ucp_officer";
pilot_classname = "rhsusf_army_ucp_helipilot";
crewman_classname = "rhsusf_army_ucp_crewman";
A3W_BoxWps = "rhs_weapon_crate";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["rhsusf_army_ucp_rifleman",1,0,0,0],
	["rhsusf_army_ucp_medic",1,0,0,0],
	["rhsusf_army_ucp_engineer",1,0,0,0],
	["rhsusf_army_ucp_grenadier",1,0,0,GRLIB_perm_inf],
	["rhsusf_army_ucp_marksman",1,0,0,GRLIB_perm_inf],
	["rhsusf_army_ucp_riflemanat",1,0,0,0],
	["rhsusf_army_ucp_machinegunner",1,0,0,GRLIB_perm_inf],
	["rhsusf_army_ucp_sniper",1,0,0,GRLIB_perm_inf],
	["rhsusf_army_ucp_sniper_m107",1,0,0,GRLIB_perm_log],
	["rhsusf_army_ucp_aa",1,0,0,GRLIB_perm_log],
	["rhsusf_army_ucp_javelin",1,0,0,GRLIB_perm_log],
	["rhsusf_army_ucp_rifleman_m590",1,0,0,GRLIB_perm_inf],
	["rhsusf_usmc_recon_marpat_wd_rifleman_lite",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

light_vehicles = [
	["rhsusf_m1025_w_m2",0,50,5,0],
	["rhsusf_m1025_w_mk19",0,70,5,0],
	["rhsusf_m1045_w",0,150,5,0],
	["rhsusf_M1078A1R_SOV_M2_D_fmtv_socom",10,150,5,0],
	["rhsusf_m1151_m2crows_usarmy_wd",0,50,5,0],
	["rhsusf_m1151_mk19crows_usarmy_wd",0,50,5,0],
	["rhsusf_m1151_m2_v1_usarmy_wd",0,50,5,0],
	["rhsusf_m1151_m2_lras3_v1_usarmy_wd",0,50,5,0],
	["rhsusf_m1151_m240_v1_usarmy_wd",0,50,5,0],
	["rhsusf_m1151_mk19_v2_usarmy_wd",0,70,5,0],
	["rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy",0,50,5,GRLIB_perm_inf],
	["rhsusf_M1117_W",10,170,5,GRLIB_perm_inf],
	["rhsusf_M1220_M153_M2_usarmy_wd",10,170,5,GRLIB_perm_inf],
	["rhsusf_M1220_M2_usarmy_wd",10,170,5,GRLIB_perm_inf],
	["rhsusf_M1220_MK19_usarmy_wd",10,180,5,GRLIB_perm_inf],
	["rhsusf_M1230_M2_usarmy_wd",10,170,5,GRLIB_perm_inf],
	["rhsusf_M1237_M2_usarmy_wd",10,170,5,GRLIB_perm_inf],
	["rhsusf_m1240a1_m2_usarmy_wd",10,170,5,GRLIB_perm_inf],
	["rhsusf_m1240a1_m240_usarmy_wd",10,170,5,GRLIB_perm_inf],
	["rhsusf_m1240a1_mk19_usarmy_wd",10,180,5,GRLIB_perm_inf],
	["rhsusf_m1240a1_m2_uik_usarmy_wd",10,170,5,GRLIB_perm_inf],
	["rhsusf_m1165a1_gmv_mk19_m240_socom_d",10,180,5,GRLIB_perm_inf],
	["rhsusf_m1165a1_gmv_m2_m240_socom_d",10,170,5,GRLIB_perm_inf],
	["rhsusf_stryker_m1126_m2_wd",10,170,5,GRLIB_perm_log],
	["rhsusf_stryker_m1126_mk19_wd",10,180,5,GRLIB_perm_log],
	["rhsusf_stryker_m1134_wd",10,170,5,GRLIB_perm_log],
	["rhsusf_M1078A1P2_WD_fmtv_usarmy",10,280,5,GRLIB_perm_inf],
	["rhsusf_M1078A1P2_B_WD_fmtv_usarmy",10,290,5,GRLIB_perm_log],
	["rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy",10,280,5,GRLIB_perm_inf],
	["rhsusf_M1083A1P2_WD_fmtv_usarmy",10,290,5,GRLIB_perm_inf],
	["rhsusf_M1083A1P2_B_WD_fmtv_usarmy",10,280,5,GRLIB_perm_log],
	["rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy",10,290,5,GRLIB_perm_inf],
	["rhsusf_M1084A1P2_WD_fmtv_usarmy",10,290,5,GRLIB_perm_inf],
	["rhsusf_M1084A1P2_B_WD_fmtv_usarmy",10,280,5,GRLIB_perm_inf],
	["rhsusf_M1084A1P2_B_M2_WD_fmtv_usarmy",10,290,5,GRLIB_perm_log],
	["rhsusf_M977A4_usarmy_wd",10,380,5,GRLIB_perm_inf],
	["rhsusf_M977A4_BKIT_usarmy_wd",10,390,5,GRLIB_perm_log],
	["rhsusf_M977A4_BKIT_M2_usarmy_wd",10,400,5,GRLIB_perm_log]
];

heavy_vehicles = [
	["RHS_M2A2_wd",20,250,25,GRLIB_perm_log],
	["RHS_M2A2_BUSKI_WD",20,200,25,GRLIB_perm_log],
	["RHS_M2A3_wd",20,250,25,GRLIB_perm_log],
	["RHS_M2A3_BUSKI_wd",20,250,25,GRLIB_perm_log],
	["RHS_M2A3_BUSKIII_wd",10,300,10,GRLIB_perm_log],
	["RHS_M6_wd",10,400,10,GRLIB_perm_log],
	["rhsusf_m1a1aimwd_usarmy",20,350,25,GRLIB_perm_inf],
	["rhsusf_m1a1aim_tuski_wd",20,350,25,GRLIB_perm_tank],
	["rhsusf_m1a2sep1wd_usarmy",20,350,25,GRLIB_perm_tank],
	["rhsusf_m1a2sep1tuskiwd_usarmy",20,400,25,GRLIB_perm_tank],
	["rhsusf_m1a2sep1tuskiiwd_usarmy",20,450,25,GRLIB_perm_tank],
	["rhsusf_m1a2sep2wd_usarmy",20,350,25,GRLIB_perm_tank],
	["rhsusf_m1a1fep_wd",20,350,25,GRLIB_perm_tank],
	["rhsusf_m1a1fep_od",20,350,25,GRLIB_perm_tank],
	["rhsusf_m1a1hc_wd",20,350,25,GRLIB_perm_tank],
	["rhsusf_M142_usmc_WD",30,500,30,GRLIB_perm_air],
	["rhsusf_m109_usarmy",30,5000,30,GRLIB_perm_max]
];

air_vehicles = [
	["RHS_MELB_H6M",10,200,15,0],
	["RHS_MELB_MH6M",10,200,15,0],
	["RHS_MELB_AH6M",10,200,15,0],
	["RHS_UH1Y_UNARMED",10,100,15,0],
	["RHS_UH1Y_FFAR",10,500,15,GRLIB_perm_log],
	["RHS_UH1Y",10,200,5,GRLIB_perm_air],
	["RHS_MELB_AH6M",10,200,5,GRLIB_perm_air],
	["RHS_AH64D_wd",10,800,5,GRLIB_perm_air],
	["RHS_AH1Z_wd",10,500,5,GRLIB_perm_air],
	["rhsusf_CH53e_USMC_cargo",5,350,100,GRLIB_perm_log],
	["rhsusf_CH53E_USMC_GAU21",5,300,100,GRLIB_perm_log],
	["RHS_CH_47F",5,350,100,0],
	["RHS_CH_47F_cargo",5,300,100,0],
	["RHS_UH60M",5,350,100,GRLIB_perm_log],
	["RHS_UH60M_ESSS",5,350,100,GRLIB_perm_log],
	["RHS_UH60M_ESSS2",5,350,100,GRLIB_perm_log],
	["RHS_UH60M2",5,350,100,GRLIB_perm_log],
	["RHS_UH60M_MEV2",5,350,100,GRLIB_perm_log],
	["RHS_UH60M_MEV",5,350,100,GRLIB_perm_log],
	["RHS_C130J_Cargo",100,300,110,GRLIB_perm_inf],
	["RHS_C130J",100,300,110,GRLIB_perm_inf],
	["rhsusf_f22",15,1500,15,GRLIB_perm_max],
	["RHS_TU95MS_vvs_old",50,9000,50,GRLIB_perm_max]
];

blufor_air = [
	"B_Heli_Attack_01_F",
	"B_Plane_CAS_01_F",
	"B_Plane_Fighter_01_F",
	"B_Heli_Attack_01_F"
];

static_vehicles = [
	["RHS_M2StaticMG_WD",0,10,0,GRLIB_perm_log],
	["RHS_M2StaticMG_MiniTripod_WD",0,10,0,GRLIB_perm_tank],
	["B_GMG_01_F",0,20,0,GRLIB_perm_log],
	["RHS_TOW_TriPod_WD",0,20,0,GRLIB_perm_tank],
	["RHS_Stinger_AA_pod_WD",0,50,0,GRLIB_perm_air],
	["RHS_MK19_TriPod_WD",0,50,0,GRLIB_perm_air],
	["RHS_M119_WD",0,500,0,GRLIB_perm_air],
	["B_Mortar_01_F",0,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["rhs_D30_msv",10,150,0,GRLIB_perm_log],
	["rhs_D30_at_msv",10,150,0,GRLIB_perm_log],
	["rhsusf_mags_crate",0,50,0,GRLIB_perm_tank],
	["rhsusf_gear_crate",0,50,0,GRLIB_perm_tank],
	["rhsusf_launcher_crate",0,50,0,GRLIB_perm_tank],
	["rhsusf_spec_weapons_crate",0,50,0,GRLIB_perm_tank]
];

buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["Flag_US_F",0,0,0,0]
];

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"rhsusf_army_ucp_arb_autorifleman",
    "rhsusf_army_ucp_arb_autoriflemana",
    "rhsusf_army_ucp_arb_medic",
    "rhsusf_army_ucp_arb_engineer",
    "rhsusf_army_ucp_arb_machinegunner",
    "rhsusf_army_ucp_arb_marksman",
    "rhsusf_army_ucp_arb_squadleader",
    "rhsusf_army_ucp_arb_teamleader"
	];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
	"rhsusf_army_ucp_arb_teamleader",
    "rhsusf_army_ucp_arb_squadleader",
    "rhsusf_army_ucp_arb_sniper_m107",
    "rhsusf_army_ucp_arb_machinegunner",
    "rhsusf_army_ucp_arb_grenadier",
    "rhsusf_army_ucp_arb_medic",
    "rhsusf_army_ucp_arb_maaws",
    "rhsusf_army_ucp_arb_maaws"
	];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	  "rhsusf_army_ucp_arb_squadleader",
    "rhsusf_usmc_recon_marpat_d_teamleader",
    "rhsusf_usmc_recon_marpat_d_sniper_M107",
    "rhsusf_army_ocp_arb_maaws",
    "rhsusf_army_ocp_arb_maaws",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ocp_medic"
	];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
    "rhsusf_army_ucp_arb_squadleader",
	  "rhsusf_army_ocp_machinegunner",
    "rhsusf_army_ocp_medic",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_sniper_m24sws"
	];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"rhsusf_army_ocp_arb_teamleader",
    "rhsusf_army_ocp_arb_squadleader",
    "rhsusf_army_ocp_arb_sniper_m107",
    "rhsusf_army_ocp_rifleman_arb_m16",
    "rhsusf_army_ocp_arb_riflemanat",
    "rhsusf_army_ocp_arb_rifleman",
    "rhsusf_army_ocp_arb_rifleman",
    "rhsusf_army_ocp_arb_machinegunner",
    "rhsusf_army_ocp_arb_medic",
    "rhsusf_army_ocp_arb_maaws",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa"
	];
};
if ( isNil "blufor_squad_recon" ) then { blufor_squad_recon = [] };
if ( count blufor_squad_recon == 0 ) then { blufor_squad_recon = [
	"B_recon_TL_F",
	"B_recon_medic_F",
	"B_Recon_Sharpshooter_F",
	"B_recon_LAT_F",
	"B_recon_M_F",
	"B_recon_F"
	];
};

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_recon,25,500,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,800,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "B_APC_Tracked_01_CRV_F"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"B_APC_Tracked_01_CRV_F"
];

vehicle_rearm_sources_west = [
	"B_APC_Tracked_01_CRV_F"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [
	"RHS_M2StaticMG_WD",
	"RHS_M2StaticMG_MiniTripod_WD",
	"RHS_TOW_TriPod_WD",
	"RHS_Stinger_AA_pod_WD",
	"RHS_MK19_TriPod_WD",
	"RHS_M119_WD"
];

GRLIB_vehicle_blacklist_west = [

];

box_transport_config_west = [
	[ "rhs_kamaz5350_open_msv", -6.5, [0,	  0.8,	  0], [0,	  -0.8,	  0.0], [0,	-2.5,	0] ],
	[ "rhsusf_M1078A1P2_wd_open_fmtv_usarmy", -6.5, [0,	  -0.2,	  0.6], [0,	  -1.8,	  0.6] ],
	[ "rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy", -6.5, [0,	  -0.2,	  0.6], [0,	  -1.8,	  0.6] ],
	[ "rhsusf_M977A4_BKIT_usarmy_wd", -6.5, [0,	  0.5,	  1.5], [0,	  -0.9,	  1.5], [0,	  -2.4,	  1.5], [0,	  -3.8,	  1.5], [0,	  0,	  3], [0,	  -1.5,	  3], [0,	  -3,	  3] ],
	[ "rhsusf_M977A4_BKIT_M2_usarmy_wd", -6.5, [0,	  0.5,	  0.8], [0,	  -0.9,	  0.8], [0,	  -2.4,	  0.8], [0,	  -3.8,	  0.8], [0,	  0,	  2.3], [0,	  -1.5,	  2.3], [0,	  -3,	  2.3] ],
	[ "RHS_CH_47F", -7.5, [0,	2,	-1.8], [0,	0.6,	-1.8], [0,	-1.2, -1.8], [0,	-2.6, -1.8] ]
];
