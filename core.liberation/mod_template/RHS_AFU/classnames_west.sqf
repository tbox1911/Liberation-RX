// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_west_modder = "fugasjunior";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

FOB_typename = "Land_Cargo_HQ_V3_F";
huron_typename = "b_afougf_Mi8MTV3_Cargo";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "rhsgref_cdf_gaz66_r142";
Respawn_truck_typename = "UA_M113";
ammo_truck_typename = "rhsusf_M977A4_AMMO_BKIT_usarmy_wd";
fuel_truck_typename = "b_afougf_kraz255b1_fuel";
repair_truck_typename = "b_afougf_Ural_repair";
repair_sling_typename = "Land_Pod_Heli_Transport_04_repair_F";
fuel_sling_typename = "Land_Pod_Heli_Transport_04_fuel_F";
ammo_sling_typename = "Land_Pod_Heli_Transport_04_ammo_F";
medic_sling_typename = "Land_Pod_Heli_Transport_04_medevac_F";
pilot_classname = "b_afougf_pilot_F";
crewman_classname = "b_afougf_tankist_F";
basic_weapon_typename = "Box_Syndicate_Ammo_F";

chimera_vehicle_overide = [
  ["B_Heli_Transport_01_F", "b_afougf_Mi8MTV3_Cargo"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,0],
	["Fin_random_F",0,0,0,0],
	["b_afougf_mg_rpk74",1,0,0,0],
    ["b_afougf_mg_pkm",1,0,0,0],
    ["b_afougf_marksman_svdm",1,0,0,0],
    ["b_afougf_teamleader_gp25",1,0,0,0],
    ["b_afougf_rifleman_ak74",1,0,0,0],
    ["b_afougf_pt_rpg7",1,0,0,0],
    ["b_afougf_aa_igla_specialiDst",1,0,0,0],
    ["b_afougf_medic",1,0,0,0],
    ["b_afougf_rifleman_gp25",1,0,0,0],
    ["b_afougf_marksman_svdm",1,0,0,0],
	[crewman_classname,1,0,0,0],
	[pilot_classname,1,0,0,0]
];

units_loadout_overide = [
];

// *** Territorial defense ***
resistance_squad = [
    "b_ngu_sapper",
    "b_ngu_teamleader_gp25",
    "b_ngu_sergeant_gp25",
    "b_ngu_pt_rpg7",
    "b_ngu_rifleman_ak74",
    "b_ngu_rifleman_ak74",
    "b_ngu_medic",
    "b_ngu_mg_rpk74",
    "b_ngu_pt_rpg7",
    "b_ngu_rifleman_gp25",
    "b_ngu_marksman_svdm"
];

resistance_squad_static = "b_ngu_M2_TriPod_high";

// TODO add US-supplied vehicles
light_vehicles = [
	["O_Boat_Transport_01_F",1,25,1,0],
	["O_Boat_Armed_01_hmg_F",5,30,5,0],
	["C_Offroad_01_covered_F",1,10,1,0],
	["c_uacivil_tracktor_01",1,25,3,0],
	["C_Quadbike_01_F",1,5,1,0],
	["C_Van_02_vehicle_F",1,10,1,0],
	["Kraz_spartan_camo_gs",1,15,1,0], // TODO change to oskosh
	["UA_btr80",5,125,2,0],
	["UA_btr80a",5,145,2,0],
	["b_afougf_Ural_Base",5,10,5,0],
	["b_afougf_kraz255ba_cargo_open",5,10,5,0]
];

heavy_vehicles = [
	["UA_bmp1",10,150,10,0],
	["BTR4E_AFU",15,350,10,0],
	["UA_bmp2",15,200,20,0],
	["mkk_t64_bv_ua",15,500,20,0],
	["ssr_Leopard2a4",20,500,25,0, GRLIB_perm_max],
	["b_afougf_zsu234_aa",20,750,25,0],
	["b_afougf_BM21",10,2600,0,0,GRLIB_perm_max],
	["UA_HIMARS",50,3000,100,GRLIB_perm_max]
];

air_vehicles = [
	["b_afougf_Mi24V_AT",20,1400,30,0,GRLIB_perm_max],
    ["b_afougf_Mi8MTV3_UPK23",10,800,20,0],
    ["b_afougf_Mi8MTV3_Cargo",10,400,20,0],
	["b_afougf_Su25SM",20,2000,40,0,GRLIB_perm_max],
	["b_afougf_mig29sm",20,2000,40,0]
];

blufor_air = [
	"b_afougf_Mi24V_AT",
	"b_afougf_Mi8MTV3_UPK23",
	"b_afougf_Mi8MTV3_Cargo",
	"b_afougf_Mi8MTV3_Cargo",
	"b_afougf_Su25SM",
	"b_afougf_mig29sm"
];

static_vehicles = [
	["b_afougf_M2_TriPod_high",0,15,0,0],
	["b_afougf_M2_TriPod_low",0,15,0,0],
	["b_afougf_AGS30_TriPod",0,15,0,0],
	["b_afougf_DSHkM_Mini_TriPod",0,25,0,0],
	["b_afougf_SPG9",0,15,0,0],
	["rhs_Igla_AA_pod_msv",0,50,0,0],
	["rhs_Kornet_9M133_2_msv",0,50,0,0],
	["b_afougf_ZU23",0,500,0,0]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["b_afougf_Ural_repair",1,30,1,0],
	["rhsusf_M977A4_AMMO_BKIT_usarmy_wd",1,30,1,0],
	["b_afougf_kraz255b1_fuel",1,30,1,0],
	["rhs_launcher_crate",0,150,0,0]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,0],
	["Land_Cargo_House_V3_F",0,0,0,0],
	["Land_Cargo_Patrol_V3_F",0,0,0,0],
	["FA_UAF_FlagTrident",0,0,0,0]
];

// TODO change squads
blufor_squad_inf_light = [
	"b_afougf_medic",
	"b_afougf_pt_rpg7",
	"b_afougf_teamleader_gp25",
	"b_afougf_teamleader_gp25",
	"b_afougf_rifleman_ak74",
	"b_afougf_rifleman_gp25",
	"b_afougf_rifleman_ak74",
	"b_afougf_rifleman_ak74"
 ];
blufor_squad_inf = [
    "b_afougf_medic",
    "b_afougf_pt_rpg7",
    "b_afougf_teamleader_gp25",
    "b_afougf_pt_rpg7",
    "b_afougf_teamleader_gp25",
    "b_afougf_rifleman_ak74",
    "b_afougf_rifleman_gp25",
    "b_afougf_mg_pkm",
	"b_afougf_rifleman_ak74",
	"b_afougf_marksman_svdm"
 ];
blufor_squad_at = [
    "b_afougf_medic",
    "b_afougf_pt_rpg7",
    "b_afougf_pt_rpg7",
	"b_afougf_pt_rpg7",
    "b_afougf_aa_igla_specialist",
    "b_afougf_rifleman_ak74",
    "b_afougf_marksman_svdm"
 ];
blufor_squad_aa = [
    "b_afougf_medic",
    "b_afougf_aa_igla_specialist",
    "b_afougf_aa_igla_specialist",
	"b_afougf_aa_igla_specialist",
    "b_afougf_pt_rpg7",
    "b_afougf_rifleman_ak74",
    "b_afougf_marksman_svdm"
 ];
blufor_squad_mix = [
    "b_afougf_medic",
    "b_afougf_aa_igla_specialist",
    "b_afougf_aa_igla_specialist",
	"b_afougf_pt_rpg7",
    "b_afougf_pt_rpg7",
    "b_afougf_rifleman_ak74",
    "b_afougf_marksman_svdm"
 ];

squads = [
	[blufor_squad_inf_light,10,300,0,0],
	[blufor_squad_inf,20,400,0,0],
	[blufor_squad_at,25,600,0,0],
	[blufor_squad_aa,25,600,0,0],
	[blufor_squad_mix,25,2500,0,0]
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

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [
	"b_ngu_M2_TriPod_high",
	"b_afougf_AGS30_TriPod",
	"b_afougf_DSHkM_Mini_TriPod",
	"b_afougf_SPG9",
	"rhs_Igla_AA_pod_msv",
	"rhs_Kornet_9M133_2_msv",
	"b_afougf_ZU23"
];

GRLIB_AirDrop_1 = [			// Unarmed Offroader 50
	"UA_2020_cup_Hilux_unarmed_01"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"UA_2020_cup_Hilux_DSHKM_01"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"b_afougf_BRDM2"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"b_afougf_Ural_Base"
];

GRLIB_AirDrop_5 = [			// APC 750
	"UA_btr80"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"O_Boat_Transport_01_F"
];
