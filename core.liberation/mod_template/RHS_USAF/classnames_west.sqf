// *** FRIENDLIES ***
// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "RHS_CH_47F";
FOB_typename = "Land_Cargo_HQ_V1_F";
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
	["rhsusf_army_ucp_maaws",1,0,0,0],
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
	["B_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["B_Boat_Armed_01_minigun_F",5,30,5,GRLIB_perm_log],
	["rhsusf_m1025_w",1,10,5,0],
	["rhsusf_m1025_w_m2",1,50,5,GRLIB_perm_inf],
	["rhsusf_m1025_w_mk19",1,50,5,GRLIB_perm_log],
	["rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy",1,15,7,0],
	["rhsusf_M1084A1P2_B_WD_fmtv_usarmy",1,20,7,GRLIB_perm_inf],
	["rhsusf_M977A4_usarmy_wd",5,50,12,GRLIB_perm_log],
	["rhsusf_m1151_usarmy_wd",2,25,12,0],
	["rhsusf_m1151_m240_v2_usarmy_wd",5,100,12,GRLIB_perm_inf],
	["rhsusf_m1151_m2_v2_usarmy_wd",5,125,12,GRLIB_perm_log],
	["rhsusf_M1083A1P2_B_WD_fmtv_usarmy",5,30,15,GRLIB_perm_log],
	["rhsusf_m1240a1_usarmy_wd",5,50,10,0],
	["rhsusf_m1240a1_m2_usarmy_wd",5,150,5,GRLIB_perm_inf],
	["rhsusf_m1240a1_mk19_usarmy_wd",5,150,5,GRLIB_perm_tank]
];

heavy_vehicles = [
	["RHS_M2A2_wd",10,250,20,GRLIB_perm_log],
	["RHS_M2A3_wd",10,250,20,GRLIB_perm_log],
	["RHS_M2A2_BUSKI_WD",15,300,25,GRLIB_perm_log],
	["RHS_M2A3_BUSKIII_wd",15,350,25,GRLIB_perm_log],
	["RHS_M6_wd",15,350,25,GRLIB_perm_log],
	["rhsusf_m1a1aim_tuski_wd",20,450,25,GRLIB_perm_tank],
	["rhsusf_m1a2sep1wd_usarmy",20,350,25,GRLIB_perm_tank],
	["rhsusf_m1a2sep1tuskiwd_usarmy",20,400,25,GRLIB_perm_tank],
	["rhsusf_m1a2sep1tuskiiwd_usarmy",20,450,25,GRLIB_perm_tank],
	["rhsusf_m1a1hc_wd",20,550,25,GRLIB_perm_air],
	["rhsusf_M142_usmc_WD",30,500,30,GRLIB_perm_air],
	["rhsusf_m109_usarmy",30,5000,30,GRLIB_perm_max]
];

air_vehicles = [
	["RHS_MELB_MH6M",10,20,15,GRLIB_perm_tank],
	["RHS_MELB_AH6M",10,50,15,GRLIB_perm_air],
	["RHS_UH1Y_UNARMED",10,100,5,GRLIB_perm_tank],
	["RHS_UH1Y",10,150,5,GRLIB_perm_air],
	["rhsusf_CH53e_USMC_cargo",5,350,200,GRLIB_perm_air],
	["rhsusf_CH53E_USMC_GAU21",5,300,200,GRLIB_perm_air],
	["RHS_CH_47F",5,350,150,GRLIB_perm_air],
	["rhsusf_CH53E_USMC",15,500,15,GRLIB_perm_max],
	["RHS_UH60M",5,350,600,GRLIB_perm_air],
	["RHS_UH60M2",5,350,600,GRLIB_perm_air],
	["RHS_AH64D_wd",10,800,5,GRLIB_perm_air],
	["RHS_AH1Z_wd",10,1000,5,GRLIB_perm_air],
	["rhsusf_f22",15,1500,15,GRLIB_perm_max],
	["RHS_A10",15,1500,15,GRLIB_perm_max]
];

blufor_air = [
	"RHS_AH1Z_wd",
	"RHS_A10",
	"rhsusf_f22",
	"B_Heli_Attack_01_F"
];

static_vehicles = [
	["RHS_M2StaticMG_MiniTripod_WD",0,10,0,GRLIB_perm_log],
	["RHS_M2StaticMG_WD",0,10,0,GRLIB_perm_tank],
	["RHS_MK19_TriPod_WD",0,20,0,GRLIB_perm_log],
	["RHS_TOW_TriPod_WD",0,20,0,GRLIB_perm_tank],
	["RHS_Stinger_AA_pod_WD",0,50,0,GRLIB_perm_tank],
	["RHS_M119_WD",0,500,0,GRLIB_perm_air],
	["RHS_M252_WD",0,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["rhsusf_M977A4_REPAIR_usarmy_wd",5,15,5,GRLIB_perm_inf],
	["rhsusf_M978A4_usarmy_wd",5,15,20,GRLIB_perm_inf],
	["rhsusf_M977A4_AMMO_usarmy_wd",5,15,20,GRLIB_perm_tank],
	["rhsusf_launcher_crate",0,150,0,GRLIB_perm_tank]
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
    "rhsusf_army_ucp_arb_medic",
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
    "rhsusf_army_ucp_arb_maaws"
	];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	"rhsusf_army_ucp_arb_squadleader",
    "rhsusf_army_ucp_arb_marksman",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_arb_maaws",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ocp_medic"
	];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
	"rhsusf_army_ucp_arb_squadleader",
    "rhsusf_army_ucp_arb_marksman",
    "rhsusf_army_ocp_arb_maaws",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_medic"
	];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"rhsusf_army_ucp_arb_squadleader",
    "rhsusf_army_ucp_arb_marksman",
    "rhsusf_army_ocp_arb_maaws",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ucp_arb_autorifleman",
    "rhsusf_army_ocp_medic"
	];
};

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,800,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "rhsusf_M977A4_AMMO_usarmy_wd"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy"
];

vehicle_rearm_sources_west = [
	"rhsusf_M977A4_AMMO_usarmy_wd"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [
	"RHS_M2StaticMG_MiniTripod_WD",
	"RHS_M2StaticMG_WD",
	"RHS_MK19_TriPod_WD",
	"RHS_TOW_TriPod_WD",
	"RHS_Stinger_AA_pod_WD",
	"RHS_M119_WD",
	"RHS_M252_WD"
];

box_transport_config_west = [
	[ "rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M1084A1P2_B_WD_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M977A4_usarmy_wd", -6.5, [0,0.5,1.5], [0,-0.9,1.5], [0,-2.4,1.5], [0,-3.8,1.5] ],
	[ "RHS_CH_47F", -7.5, [0,2,-1.8], [0,0.6,-1.8], [0,-1.2,-1.8], [0,-2.6,-1.8] ]
];
