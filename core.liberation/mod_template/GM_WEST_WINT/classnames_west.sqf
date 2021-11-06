// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_color_friendly = "ColorBLUFOR";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

FOB_box_typename = "gm_ge_army_shelteraceII_standard";
FOB_truck_typename = "gm_ge_army_kat1_454_cargo";
Respawn_truck_typename = "gm_gc_army_ural375d_medic";
huron_typename = "gm_ge_army_ch53g";

commander_classname = "gm_ge_army_officer_p1_80_win";
crewman_classname = "gm_ge_army_crew_mp2a1_80_win";
pilot_classname = "gm_ge_army_pilot_p1_80_win";
PAR_Medikit = "gm_ge_army_medkit_80";
PAR_AidKit = "gm_ge_army_burnBandage";
A3W_BoxWps = "gm_AmmoBox_1000Rnd_762x51mm_ap_DM151_g3";
canisterFuel = "gm_jerrycan";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
//gm_ge_army_rifleman_g3a3_80_ols
//gm_ge_army_rifleman_g3a3_parka_80_ols
//gm_ge_army_rifleman_g3a3_parka_80_win
infantry_units = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["gm_ge_army_rifleman_g3a3_80_win",1,0,0,0],
	["gm_ge_army_rifleman_mp2a1_80_win",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_sf_rifleman_mp5a3_80_win",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_medic_g3a3_80_win",1,0,0,0],
	["gm_ge_army_engineer_g3a4_80_win",1,0,0,0],
	["gm_ge_army_grenadier_g3a3_80_win",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_antitank_g3a3_milan_80_win",1,0,0,0],
	["gm_ge_army_antitank_g3a3_pzf44_80_win",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_machinegunner_mg3_80_win",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_sf_rifleman_mp5a3_80_win",1,0,0,GRLIB_perm_log],
	["gm_ge_army_antiair_g3a3_fim43_80_win",1,0,0,GRLIB_perm_log],
	["gm_ge_army_antitank_g3a3_pzf84_80_win",1,0,0,GRLIB_perm_log],
	["gm_ge_army_marksman_g3a3_80_win",1,0,0,GRLIB_perm_log],
	["gm_ge_army_paratrooper_g3a4_80_win",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

light_vehicles = [
	["gm_gc_army_bicycle_01_win",1,5,1,0],
	["gm_ge_army_k125",1,10,1,0],
	["gm_ge_army_u1300l_container",1,25,1,0],
	["gm_ge_army_iltis_cargo",1,5,1,0],
	["gm_ge_army_iltis_milan",5,100,2,GRLIB_perm_inf],
	["gm_ge_army_iltis_mg3",5,125,2,GRLIB_perm_log],
	["gm_ge_army_m113a1g_apc",2,25,2,GRLIB_perm_log],
	["gm_ge_army_m113a1g_apc_milan",5,100,2,GRLIB_perm_inf],
	["gm_ge_army_m113a1g_medic",5,125,2,GRLIB_perm_log],
	["gm_ge_army_kat1_451_container",5,30,5,GRLIB_perm_log],
	["gm_dk_army_m113a1dk_apc",2,25,2,GRLIB_perm_inf],
	["gm_dk_army_m113a1dk_medic",5,10,5,GRLIB_perm_inf],
	["gm_dk_army_m113a2dk",5,200,2,GRLIB_perm_log],
	["gm_ge_army_fuchsa0_engineer",10,250,10,GRLIB_perm_log],
	["gm_ge_army_fuchsa0_command",10,500,10,GRLIB_perm_log],
	["gm_ge_army_fuchsa0_reconnaissance",10,500,10,GRLIB_perm_log]
];

heavy_vehicles = [
	["gm_ge_army_luchsa1",10,500,10,GRLIB_perm_log],
	["gm_ge_army_luchsa2",10,500,10,GRLIB_perm_log],
	["gm_ge_army_Leopard1a1",10,500,10,GRLIB_perm_tank],
	["gm_ge_army_Leopard1a1a1",10,500,10,GRLIB_perm_tank],
	["gm_ge_army_Leopard1a1a2",15,1000,15,GRLIB_perm_tank],
	["gm_ge_army_Leopard1a1a3",15,1000,15,GRLIB_perm_tank],
	["gm_ge_army_Leopard1a1a4",15,1000,15,GRLIB_perm_tank],
	["gm_ge_army_gepard1a1",15,1500,15,GRLIB_perm_air],
	["gm_ge_army_Leopard1a3",15,1500,15,GRLIB_perm_air],
	["gm_ge_army_Leopard1a3a1",15,1500,15,GRLIB_perm_air],
	["gm_ge_army_Leopard1a3a2",15,1500,15,GRLIB_perm_air],
	["gm_ge_army_Leopard1a3a3",15,1500,15,GRLIB_perm_air],
	["gm_ge_army_Leopard1a5",15,2500,15,GRLIB_perm_max],
	["gm_ge_army_bpz2a0",15,2000,15,GRLIB_perm_max]
];

air_vehicles = [
	["gm_ge_army_bo105m_vbh",1,100,5,GRLIB_perm_tank],
	["gm_ge_army_bo105p1m_vbh",5,120,10,GRLIB_perm_air],
	["gm_gc_civ_mi2p",1,100,5,GRLIB_perm_tank],
	["gm_gc_civ_mi2sr",10,130,20,GRLIB_perm_air],
	["gm_ge_army_bo105p1m_vbh_swooper",1,250,5,GRLIB_perm_air],
	["gm_ge_army_bo105p_pah1",10,500,15,GRLIB_perm_air],
	["gm_ge_army_bo105p_pah1a1",10,500,15,GRLIB_perm_air],
	["gm_ge_army_ch53g",10,500,15,GRLIB_perm_air],
	["gm_ge_army_ch53gs",20,800,40,GRLIB_perm_max],
	["gm_ge_airforce_do28d2",5,200,10,GRLIB_perm_air],
	["gm_gc_civ_l410s_passenger",5,220,10,GRLIB_perm_air]
];

blufor_air = [
	"gm_ge_army_bo105p1m_vbh",
	"gm_ge_army_bo105p1m_vbh",
	"gm_ge_army_bo105p_pah1",
	"gm_ge_army_bo105p_pah1",
	"gm_ge_army_bo105p_pah1",
	"gm_ge_army_bo105p_pah1a1",
	"gm_ge_army_bo105p_pah1a1",
	"gm_ge_army_bo105p_pah1a1",
	"gm_ge_army_ch53gs"
];

static_vehicles = [
	["B_HMG_01_F",0,10,0,GRLIB_perm_log],
	["B_HMG_01_high_F",0,10,0,GRLIB_perm_tank],
	["gm_ge_army_mg3_aatripod",0,50,0,GRLIB_perm_air],
	["gm_ge_army_milan_launcher_tripod",0,50,0,GRLIB_perm_air],
	["B_Mortar_01_F",0,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"B_AAA_System_01_F",
	"B_SAM_System_02_F",
	"O_SAM_System_04_F"
];

support_vehicles_west = [
	["gm_ge_army_shelteraceII_repair",5,50,5,GRLIB_perm_inf],
	["gm_gc_army_shelteraceII_medic",5,50,5,GRLIB_perm_inf],
	["gm_gc_army_shelterlakII_repair",10,100,0,GRLIB_perm_log],
	["gm_gc_army_shelterlakII_medic",10,100,0,GRLIB_perm_log],
	["gm_ge_army_kat1_451_reammo",5,150,10,GRLIB_perm_tank],
	["gm_ge_army_u1300l_repair",10,130,10,GRLIB_perm_tank],
	["gm_ge_army_kat1_451_refuel",5,120,40,GRLIB_perm_tank],
	["gm_AmmoBox_wood_02_empty",0,80,0,GRLIB_perm_log],
	["gm_AmmoBox_wood_03_empty",0,150,0,GRLIB_perm_tank]
];

buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["gm_flag_GE",0,0,0,0]
];

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_win",
	"gm_ge_army_medic_g3a3_80_win",
	"gm_ge_army_sf_marksman_g3a3_80_win",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_win",
	"gm_ge_army_sf_rifleman_mp5a3_80_win",
	"gm_ge_army_sf_rifleman_g3a4_80_win",		
	"gm_ge_army_sf_rifleman_g3a4_80_win",
	"gm_ge_army_sf_rifleman_g3a4_80_win"
	];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_win",
	"gm_ge_army_medic_g3a3_80_win",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_win",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_win",	
	"gm_ge_army_sf_marksman_g3a3_80_win",
	"gm_ge_army_sf_marksman_g3a3_80_win",
	"gm_ge_army_sf_rifleman_g3a4_80_win",
	"gm_ge_army_sf_rifleman_g3a4_80_win",
	"gm_ge_army_sf_rifleman_mp5a3_80_win",
	"gm_ge_army_sf_rifleman_mp5a3_80_win",
	"gm_ge_army_sf_rifleman_mp5a3_80_win"
	];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_win",
	"gm_ge_army_medic_g3a3_80_win",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_win",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_win",
	"gm_ge_army_sf_antitank_mp5a3_milan_80_win",
	"gm_ge_army_sf_rifleman_mp5a3_80_win"
	];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_win",
	"gm_ge_army_medic_g3a3_80_win",
	"gm_ge_army_sf_antiair_mp5a3_fim43_80_win",
	"gm_ge_army_sf_antiair_mp5a3_fim43_80_win",
	"gm_ge_army_sf_antiair_mp5a3_fim43_80_win",
	"gm_ge_army_sf_rifleman_mp5a3_80_win"
	];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_win",
	"gm_ge_army_medic_g3a3_80_win",
	"gm_ge_army_sf_antiair_mp5a3_fim43_80_win",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_win",
	"gm_ge_army_sf_rifleman_g3a4_80_win",
	"gm_ge_army_sf_rifleman_g3a4_80_win"
	];
};
if ( isNil "blufor_squad_recon" ) then { blufor_squad_recon = [] };
if ( count blufor_squad_recon == 0 ) then { blufor_squad_recon = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_win",
	"gm_ge_army_medic_g3a3_80_win",
	"gm_ge_army_sf_marksman_g3a3_80_win",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_win",
	"gm_ge_army_sf_rifleman_g3a4_80_win",
	"gm_ge_army_sf_rifleman_g3a4_80_win"
	];
};

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_recon,25,500,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
	"gm_ge_army_bpz2a0"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"gm_gc_army_shelteraceII_medic",
	"gm_gc_army_shelterlakII_medic",
	"gm_dk_army_m113a1dk_medic",
	"gm_ge_army_bpz2a0"
];

vehicle_rearm_sources_west = [
	"gm_ge_army_bpz2a0",
	"gm_ge_army_kat1_451_reammo",
	"gm_AmmoBox_wood_02_empty",
	"gm_AmmoBox_wood_03_empty"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [
	"gm_ge_army_mg3_aatripod",
	"gm_ge_army_milan_launcher_tripod",
	"gm_AmmoBox_wood_02_empty",
	"gm_AmmoBox_wood_03_empty"
];

box_transport_config_west = [
	[ "gm_ge_army_u1300l_container", -4.5, [0, -0.5, -0.4], [0, -2.1, -0.4] ],
	[ "gm_ge_army_kat1_451_container", -5.5, [0, 0.21, -0.01], [0, -1.34, -0.01], [0, -2.9, -0.01]]
];