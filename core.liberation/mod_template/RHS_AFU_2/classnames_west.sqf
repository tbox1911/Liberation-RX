// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_west_modder = "fugasjunior";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

FOB_typename = "Land_Cargo_HQ_V3_F";
huron_typename = "b_afougf_Mi8MTV3_Cargo";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "O_T_Truck_03_device_ghex_F"; // TODO
Respawn_truck_typename = "rhs_gaz66_ap2_msv" ; // TODO
ammo_truck_typename = "O_Truck_03_ammo_F"; // TODO
fuel_truck_typename = "O_Truck_03_fuel_F"; // TODO
repair_truck_typename = "O_Truck_03_Repair_F"; // TODO
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
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["b_afougf_rifleman_ak74",1,0,0,0],
	["b_afougf_medic",1,0,0,0],
	["b_afougf_sapper",1,0,0,0],
	["b_afougf_rifleman_gp25",1,0,0,GRLIB_perm_inf],
	["b_afougf_teamleader_gp25",1,0,0,GRLIB_perm_inf],
	["b_afougf_sergeant_gp25",1,0,0,GRLIB_perm_inf],
	["b_afougf_marksman_svdm",1,0,0,GRLIB_perm_inf],
	["b_afougf_marksman_m14",1,0,0,GRLIB_perm_inf],
	["b_afougf_marksman_m82",1,0,0,GRLIB_perm_inf],
	["b_afougf_pt_rpg7",1,0,0,0],
	["b_afougf_rifleman_at4_heat",1,0,0,0],
	["b_afougf_pt_maaws",1,0,0,0],
	["b_afougf_mg_rpk74",1,0,0,GRLIB_perm_inf],
	["b_afougf_mg_pkm",1,0,0,GRLIB_perm_inf],
	["b_afougf_mg_m240",1,0,0,GRLIB_perm_inf],
	["b_afougf_mg_mg42",1,0,0,GRLIB_perm_inf],
	["b_afougf_aa_igla_specialist",1,0,0,GRLIB_perm_log],
	["b_afougf_aa_stinger_specialist",1,0,0,GRLIB_perm_log],
	["b_afougf_pt_nlaw",1,0,0,GRLIB_perm_log],
	["b_afougf_pt_fgm148",1,0,0,GRLIB_perm_log],
	["b_afougf_pt_nlaw",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

// TODO
// *** RHS NAPA ***
resistance_squad = [
	"rhsgref_nat_pmil_commander",
	"rhsgref_nat_pmil_specialist_aa",
	"rhsgref_nat_pmil_machinegunner",
	"rhsgref_nat_pmil_grenadier_rpg",
	"rhsgref_nat_pmil_saboteur",
	"rhsgref_nat_pmil_medic",
	"rhsgref_nat_pmil_rifleman_akm",
	"rhsgref_nat_pmil_rifleman_aksu",
	"rhsgref_nat_pmil_grenadier",
	"rhsgref_nat_pmil_rifleman",
	"rhsgref_nat_pmil_hunter"
];

resistance_squad_static = "RHS_Stinger_AA_pod_WD";

light_vehicles = [
	["O_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["O_Boat_Armed_01_hmg_F",5,30,5,GRLIB_perm_log],
	["b_afougf_UAZ_Base",1,10,1,0],
	["b_afougf_offroad_01_dshkm",1,50,1,GRLIB_perm_inf],
	["b_afougf_gaz66_truck",1,15,1,0],
	["rhs_kamaz5350_open_msv",1,50,1,GRLIB_perm_inf], // TODO
	["b_afougf_Ural_open",1,50,1,GRLIB_perm_log],
	["rhs_kraz255b1_cargo_open_msv",1,50,1,GRLIB_perm_tank], // TODO
	["rhsusf_m1240a1_usarmy_wd",2,25,2,0],
	["b_afougf_btr70",5,100,2,GRLIB_perm_inf],
	["UA_btr80",5,125,2,GRLIB_perm_log],
	["UA_btr80a",5,145,2,GRLIB_perm_log],
	["rhs_kamaz5350_msv",5,10,5,GRLIB_perm_inf], // TODO
	["b_afougf_Ural_Zu23",10,400,10,GRLIB_perm_tank]
];

heavy_vehicles = [
	["b_afougf_brm1k_Base",10,150,10,GRLIB_perm_tank],
	["UA_bmp1",10,150,10,GRLIB_perm_tank],
	["b_afougf_bmp1p",10,160,10,GRLIB_perm_air],
	["b_afougf_prp3_Base",10,170,10,GRLIB_perm_tank],
	["BTR4E_AFU",180,80,10,GRLIB_perm_tank],
	["UA_bmp2",15,200,20,GRLIB_perm_air],
	["mkk_t64_bv_ua",15,500,20,GRLIB_perm_tank],
	["b_afougf_t72bb",15,500,20,GRLIB_perm_tank],
	["UA_T72BA",20,600,25,GRLIB_perm_air],
	["b_afougf_t80bv",20,500,25,GRLIB_perm_tank],
	["b_afougf_t80u",20,500,25,GRLIB_perm_air],
	["ssr_Leopard2a4",20,1500,25,GRLIB_perm_max],
	["b_afougf_zsu234_aa",20,750,25,GRLIB_perm_air],
	["b_afougf_2s1tank",50,2000,100,GRLIB_perm_tank],
	["b_afougf_2s3",50,2300,100,GRLIB_perm_air],
	["UA_HIMARS",10,3500,0,GRLIB_perm_max]
];

air_vehicles = [
	["b_afougf_Mi8MTV3_UPK23",20,800,30,GRLIB_perm_inf],
    ["b_afougf_Mi24V_AT",10,500,20,GRLIB_perm_air],
    ["b_afougf_Mi8MTV3_Cargo",10,800,20,GRLIB_perm_air],
	["b_afougf_mig29s",20,2000,40,GRLIB_perm_air],
	["b_afougf_Su25SM",20,2000,40,GRLIB_perm_air]
];

blufor_air = [
    "b_afougf_Mi24V_AT",
    "b_afougf_Mi8MTV3_UPK23",
	"b_afougf_Su25SM",
	"b_afougf_mig29s"
];

static_vehicles = [
	["b_afougf_DSHkM_Mini_TriPod",0,15,0,0],
	["b_afougf_AGS30_TriPod",0,15,0,GRLIB_perm_inf],
	["b_afougf_DSHKM",0,25,0,GRLIB_perm_log],
	["b_afougf_SPG9M",0,15,0,GRLIB_perm_log],
	["RHS_Stinger_AA_pod_WD",0,50,0,GRLIB_perm_air],
	["RHS_TOW_TriPod_WD",0,50,0,GRLIB_perm_tank],
	["b_afougf_ZU23",0,500,0,GRLIB_perm_air],
	["b_afougf_m119",10,600,0,GRLIB_perm_air],
	["b_afougf_BM21",10,2600,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["RHS_Ural_Repair_VV_01",1,30,1,GRLIB_perm_inf],
	["RHS_Ural_Ammo_VV_01",1,30,1,GRLIB_perm_inf],
	["RHS_Ural_Fuel_VV_01",1,30,1,GRLIB_perm_inf],
	["rhs_launcher_crate",0,150,0,GRLIB_perm_tank]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["rhs_Flag_Russia_F",0,0,0,0]
];

blufor_squad_inf_light = [
	"b_afougf_medic",
	"b_afougf_pt_rpg7",
	"b_afougf_teamleader_gp25",
	"b_afougf_sergeant_gp25",
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
    "b_afougf_sergeant_gp25",
    "b_afougf_rifleman_ak74",
    "b_afougf_rifleman_gp25",
    "b_afougf_mg_pkm",
	"b_afougf_rifleman_ak74",
	"b_afougf_rifleman_ak74"
 ];
blufor_squad_at = [
    "b_afougf_medic",
    "b_afougf_pt_nlaw",
    "b_afougf_pt_nlaw",
	"b_afougf_pt_fgm148",
    "b_afougf_aa_stinger_specialist",
    "b_afougf_rifleman_ak74",
    "rhs_vmf_emr_marksman"
 ];
blufor_squad_aa = [
    "b_afougf_medic",
    "b_afougf_aa_igla_specialist",
    "b_afougf_aa_igla_specialist",
	"b_afougf_aa_igla_specialist",
    "b_afougf_pt_rpg7",
    "b_afougf_rifleman_ak74",
    "b_afougf_marksman_m14"
 ];
blufor_squad_mix = [
    "b_afougf_medic",
    "b_afougf_aa_igla_specialist",
    "b_afougf_aa_igla_specialist",
	"b_afougf_pt_nlaw",
    "b_afougf_pt_nlaw",
    "b_afougf_rifleman_ak74",
    "b_afougf_marksman_m14"
 ];

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
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

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [
	"b_afougf_DSHkM_Mini_TriPod",
	"b_afougf_AGS30_TriPod",
	"b_afougf_DSHKM",
	"b_afougf_SPG9M",
	"RHS_Stinger_AA_pod_WD",
	"RHS_TOW_TriPod_WD",
	"b_afougf_ZU23",
	"b_afougf_m119"
];

GRLIB_AirDrop_1 = [			// Unarmed Offroader 50
	"b_afougf_UAZ_Base"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"rhsusf_m1240a1_m240_usarmy_wd"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"b_afougf_BRDM2_UM"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"b_afougf_gaz66_truck"
];

GRLIB_AirDrop_5 = [			// APC 750
	"b_afougf_btr70"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"O_Boat_Transport_01_F"
];
