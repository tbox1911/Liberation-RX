// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "gm_ge_army_ch53gs";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "gm_ge_army_u1300l_firefighter" ;
Respawn_truck_typename = "gm_ge_army_u1300l_medic";
ammo_truck_typename = "gm_ge_army_kat1_451_reammo";
fuel_truck_typename = "gm_ge_army_kat1_451_refuel";
repair_truck_typename = "gm_ge_army_u1300l_repair";
repair_sling_typename = "gm_ge_army_shelteraceII_repair";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "gm_ge_army_shelteraceII_reammo";
medic_sling_typename = "gm_ge_army_shelteraceII_medic";
pilot_classname = "gm_ge_army_pilot_p1_80_oli";
crewman_classname = "gm_ge_army_crew_mp2a1_80_oli";
PAR_Medikit = "gm_ge_army_medkit_80";
PAR_AidKit = "gm_ge_army_burnBandage";
A3W_BoxWps = "gm_pl_army_ammobox_allmagazines_80";
canister_fuel_typename = "gm_jerrycan";
chimera_vehicle_overide = [
  ["B_Heli_Light_01_F",  "gm_ge_bgs_bo105m_vbh"],
  ["B_Heli_Transport_01_F", "gm_ge_bgs_bo105m_vbh"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["gm_ge_army_rifleman_g3a3_80_ols",1,0,0,0],
	["gm_ge_army_medic_g3a3_80_ols",1,0,0,0],
	["gm_ge_army_engineer_g3a4_80_ols",1,0,0,0],
	["gm_ge_army_grenadier_g3a3_80_ols",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_machinegunner_mg3_80_ols",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_antitank_g3a3_pzf44_80_ols",1,0,0,GRLIB_perm_log],
	["gm_ge_army_marksman_g3a3_80_ols",1,0,0,GRLIB_perm_tank],
	["gm_ge_army_antitank_g3a3_pzf84_80_ols",1,0,0,GRLIB_perm_tank],
	["gm_ge_army_antiair_g3a3_fim43_80_ols",1,0,0,GRLIB_perm_tank],
	["B_diver_F",1,0,0,GRLIB_perm_log],
	["gm_ge_army_paratrooper_g3a4_80_oli",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [
	"gm_ge_army_antiair_g3a3_fim43_80_ols"
];

resistance_squad = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_wdl",
	"gm_ge_army_sf_grenadier_hk69a1_80_wdl",
	"gm_ge_army_sf_rifleman_g3a4_80_wdl",
	"gm_ge_army_sf_rifleman_g3a4_80_wdl",
	"gm_ge_army_sf_demolition_mp5a2_80_wdl",
	"gm_ge_army_sf_radioman_mp5a3_80_wdl",
	"gm_ge_army_sf_marksman_g3a3_80_wdl",
	"gm_ge_army_sf_marksman_g3a3_80_wdl",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_wdl",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_wdl",
	"gm_ge_army_sf_rifleman_mp5a3_80_wdl",
	"gm_ge_army_sf_rifleman_mp5a3_80_wdl"
];

light_vehicles = [
	// boat
	["B_Boat_Transport_01_F",1,25,1,0],
	["B_Boat_Armed_01_minigun_F",3,125,3,GRLIB_perm_log],
	// lvl 0
	["gm_ge_army_k125",0,5,0,0],
	["gm_ge_army_typ1200_cargo",1,10,1,0],
	["gm_ge_army_iltis_cargo",1,20,1,0],
	["gm_ge_civ_u1300l",2,40,5,0],
	// lvl 1
	["gm_ge_army_iltis_mg3",2,50,2,GRLIB_perm_inf],
	["gm_ge_army_kat1_451_container",1,90,1,GRLIB_perm_inf],
	// lvl 2
	["gm_ge_army_kat1_451_cargo",2,100,7,GRLIB_perm_log],
	// lvl 3
	["gm_ge_army_iltis_milan",3,75,3,GRLIB_perm_tank]
];

heavy_vehicles = [
	// lvl 2
	["gm_ge_army_m113a1g_apc",3,200,7,GRLIB_perm_log],
	["gm_ge_army_fuchsa0_command",3,250,10,GRLIB_perm_log],
	// lvl 3
	["gm_ge_army_m113a1g_apc_milan",5,300,7,GRLIB_perm_tank],
	["gm_ge_army_fuchsa0_reconnaissance",5,350,10,GRLIB_perm_tank],
	["gm_ge_army_luchsa1",7,400,12,GRLIB_perm_tank],
	// lvl 4
	["gm_ge_army_marder1a1plus",10,750,10,GRLIB_perm_air],
	["gm_dk_army_m113a2dk",12,800,12,GRLIB_perm_air],
	["gm_ge_army_Leopard1a1a2",20,2000,25,GRLIB_perm_air],
	["gm_ge_army_gepard1a1",10,1000,15,GRLIB_perm_air],
	// lvl 5
	["gm_ge_army_Leopard1a5",30,2500,30,GRLIB_perm_max],
	["gm_ge_army_m109g",50,3000,50,GRLIB_perm_max],
	["gm_ge_army_kat1_463_mlrs",35,2750,35,GRLIB_perm_max]
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
	"gm_ge_army_bo105p_pah1a1",
	"gm_ge_army_bo105p_pah1a1",
	"gm_ge_army_ch53gs"
];


boats_west = [
  	"B_Boat_Transport_01_F",
	"B_Boat_Armed_01_minigun_F",
	"B_T_Boat_Armed_01_minigun_F"
];

static_vehicles = [
	["B_HMG_01_F",0,10,0,GRLIB_perm_inf],
	["B_HMG_01_high_F",0,10,0,GRLIB_perm_log],
	["gm_ge_army_mg3_aatripod",0,50,0,GRLIB_perm_tank],
	["gm_ge_army_milan_launcher_tripod",0,50,0,GRLIB_perm_tank],
	["B_Mortar_01_F",0,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["gm_ge_army_ch53gs",0,600,0,GRLIB_perm_tank]
];

//buildings_west_overide = true;
buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["gm_banner_GE",0,0,0,0],
	["gm_flag_GE",0,0,0,0],
	["gm_banner_DK",0,0,0,0],
	["gm_flag_DK",0,0,0,0]
];

blufor_squad_inf_light = [
	"gm_ge_army_squadleader_g3a3_p2a1_80_ols",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_grenadier_g3a3_80_ols",
	"gm_ge_army_machinegunner_mg3_80_ols",
	"gm_ge_army_radioman_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols"
];
blufor_squad_inf = [
	"gm_ge_army_squadleader_g3a3_p2a1_80_ols",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_marksman_g3a3_80_ols",
	"gm_ge_army_machinegunner_mg3_80_ols",
	"gm_ge_army_radioman_g3a3_80_ols",
	"gm_ge_army_machinegunner_mg3_80_ols",
	"gm_ge_army_grenadier_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols"
];
blufor_squad_at = [
	"gm_ge_army_squadleader_g3a3_p2a1_80_ols",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_antitank_g3a3_pzf44_80_ols",
	"gm_ge_army_antitank_g3a3_pzf84_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols"
];

blufor_squad_aa = [
	"gm_ge_army_squadleader_g3a3_p2a1_80_ols",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_antiair_g3a3_fim43_80_ols",
	"gm_ge_army_antiair_g3a3_fim43_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols"
];
blufor_squad_mix = [
	"gm_ge_army_squadleader_g3a3_p2a1_80_ols",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_antiair_g3a3_fim43_80_ols",
	"gm_ge_army_antitank_g3a3_pzf84_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols",
	"gm_ge_army_rifleman_g3a3_80_ols"
];

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
];

vehicle_rearm_sources_west = [
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];

GRLIB_AirDrop_1 = [
	"gm_ge_army_typ1200_cargo",
	"gm_ge_army_iltis_cargo"
];

GRLIB_AirDrop_2 = [
	"gm_ge_army_iltis_mg3"
];

GRLIB_AirDrop_3 = [
	"gm_ge_army_m113a1g_apc"
];

GRLIB_AirDrop_4 = [
	"gm_ge_army_kat1_451_cargo"
];

GRLIB_AirDrop_5 = [
	"gm_ge_army_m113a1g_apc_milan",
	"gm_ge_army_fuchsa0_reconnaissance",
	"gm_ge_army_luchsa1"
];

GRLIB_AirDrop_6 = [
	"B_Boat_Armed_01_minigun_F"
];
