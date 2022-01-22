// *** FRIENDLIES ***

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "ffaa_famet_ec135";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V3_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "ffaa_et_m250_repara_municion_blin" ;
Respawn_truck_typename = "ffaa_et_lince_ambulancia";
ammo_truck_typename = "ffaa_et_m250_municion_blin";
fuel_truck_typename = "ffaa_et_m250_combustible_blin";
repair_truck_typename = "ffaa_et_pegaso_repara_municion";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
commander_classname = "ffaa_brilat_jefe_escuadra_ds";
pilot_classname = "ffaa_piloto_famet_des";
crewman_classname = "ffaa_brilat_carrista_ds";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["ffaa_brilat_soldado_ds",1,0,0,0],
	["ffaa_brilat_medico_ds",1,0,0,0],
	["ffaa_brilat_ingeniero_ds",1,0,0,0],
	["ffaa_brilat_granadero_ds",1,0,0,GRLIB_perm_inf],
	["ffaa_brilat_tirador_ds",1,0,0,GRLIB_perm_inf],
	["ffaa_brilat_c90_ds",1,0,0,GRLIB_perm_inf],
	["ffaa_brilat_observador_ds",1,0,0,GRLIB_perm_log],
	["ffaa_brilat_mg4_ds",1,0,0,GRLIB_perm_log],
	["ffaa_et_moe_sl_ds",1,0,0,GRLIB_perm_tank],
	["B_diver_F",1,0,0,GRLIB_perm_tank],
	["ffaa_brilat_francotirador_accuracy_ds",1,0,0,GRLIB_perm_tank],
	["B_soldier_AA_F",1,0,0,GRLIB_perm_tank],
	["ffaa_brilat_alcotan_ds",1,0,0,GRLIB_perm_tank],
	["ffaa_brilat_francotirador_barrett_ds",1,0,0,GRLIB_perm_air],
	["B_soldier_PG_F",1,0,0,GRLIB_perm_inf],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [
	"B_soldier_AA_F",
	"B_soldier_PG_F"
];

light_vehicles = [
    ["C_Scooter_Transport_01_F",1,5,1,0],
	["B_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["ffaa_ar_zodiac_hurricane_long",2,50,2,GRLIB_perm_inf],
	["ffaa_ar_lcm",5,150,5,GRLIB_perm_tank],
	["B_Boat_Armed_01_minigun_F",5,100,5,GRLIB_perm_log],
	["B_SDV_01_F",5,50,2,GRLIB_perm_log],
	["B_Quadbike_01_F",1,5,1,0],
	["SUV_01_base_black_F",1,10,1,0],
	["C_SUV_01_F",1,10,3,GRLIB_perm_inf],
	["C_Van_01_transport_F",1,15,7,0],
	["ffaa_et_anibal",1,10,5,0],
	["ffaa_et_neton_mk2",1,25,5,GRLIB_perm_inf],
	["ffaa_et_vamtac_trans",2,50,5,GRLIB_perm_inf],
	["ffaa_et_vamtac_m2",5,100,7,GRLIB_perm_inf],
	["ffaa_et_vamtac_lag40",7,125,7,GRLIB_perm_log],
	["ffaa_et_vamtac_crows",7,175,7,GRLIB_perm_log],
	["ffaa_et_vamtac_tow",7,200,7,GRLIB_perm_tank],
	["ffaa_et_vamtac_st5_spike",10,350,7,GRLIB_perm_tank],
	["ffaa_et_vamtac_mistral",7,200,7,GRLIB_perm_air],
	["ffaa_et_vamtac_cardom",25,1500,20,GRLIB_perm_max],
	["ffaa_et_pegaso_carga",5,100,7,GRLIB_perm_log],
	["ffaa_et_pegaso_carga_lona",5,125,7,GRLIB_perm_tank],
	["ffaa_et_m250_carga_blin",7,175,7,GRLIB_perm_tank],
	["ffaa_et_m250_carga_lona_blin",7,200,7,GRLIB_perm_air],
	["ffaa_et_m250_estacion_nasams_blin",15,400,15,GRLIB_perm_max],
	["ffaa_et_m250_sistema_nasams_blin",50,4000,50,GRLIB_perm_max],
	["ffaa_et_lince_mg3",10,200,10,GRLIB_perm_log],
	["ffaa_et_lince_m2",10,225,10,GRLIB_perm_tank],
	["ffaa_et_lince_lag40",10,275,10,GRLIB_perm_tank],
	["B_UGV_01_F",5,10,5,GRLIB_perm_inf],
	["B_UGV_01_rcws_F",7,300,5,GRLIB_perm_tank]
];

heavy_vehicles = [
	["ffaa_ar_piranhaIIIC",15,500,20,GRLIB_perm_tank],
	["ffaa_et_toa_zapador",10,350,20,GRLIB_perm_log],
	["ffaa_et_toa_ambulancia",10,300,20,GRLIB_perm_log],
	["ffaa_et_toa_spike",20,600,20,GRLIB_perm_log],
	["ffaa_et_rg31_rollers",10,400,15,GRLIB_perm_log],
	["ffaa_et_pizarro_mauser",15,600,20,GRLIB_perm_tank],
	["ffaa_et_leopardo",35,2000,40,GRLIB_perm_max],
	["ffaa_ar_piranhaIIIC_lance",20,800,25,GRLIB_perm_air],
	["ffaa_ar_m109",40,3500,40,GRLIB_perm_max]
];

air_vehicles = [
	["ffaa_et_searcherIII",5,200,5,GRLIB_perm_log],
	["ffaa_ea_reaper",20,2000,25,GRLIB_perm_max],
	["C_Plane_Civil_01_F",1,100,5,GRLIB_perm_log],
	["ffaa_famet_cougar",10,350,20,GRLIB_perm_tank],
	["ffaa_famet_cougar_armed",15,450,25,GRLIB_perm_air],
	["ffaa_nh90_tth_transport",15,600,35,GRLIB_perm_tank],
	["ffaa_nh90_tth_cargo",15,800,35,GRLIB_perm_tank],
	["ffaa_nh90_tth_armed",20,1000,35,GRLIB_perm_air],
	["ffaa_famet_ch47_mg",20,1250,30,GRLIB_perm_tank],
	["ffaa_famet_ch47_mg_cargo",25,1500,40,GRLIB_perm_air],
	["ffaa_famet_tigre",25,2500,40,GRLIB_perm_max],
	["ffaa_ea_hercules",20,1750,35,GRLIB_perm_air],
	["ffaa_ea_hercules_cargo",25,2000,40,GRLIB_perm_max],
	["ffaa_ar_harrier",25,3000,50,GRLIB_perm_max],
	["ffaa_ea_ef18m",25,4000,50,GRLIB_perm_max]
];

blufor_air = [
	"ffaa_famet_tigre",
	"ffaa_ar_harrier",
	"ffaa_ea_ef18m",
	"ffaa_nh90_tth_armed"
];

boats_east = [
	"ffaa_ar_zodiac_hurricane_long",
	"ffaa_ar_lcm"
];

static_vehicles = [
	["ffaa_mochila_raven",0,50,0,GRLIB_perm_inf],
	["B_Static_Designator_01_F",0,20,0,GRLIB_perm_inf],
	["ffaa_m2_tripode",2,25,0,GRLIB_perm_inf],
	["ffaa_m2_ship_tripode",2,40,0,GRLIB_perm_log],
	["ffaa_lag40_tripode",4,60,0,GRLIB_perm_log],
	["ffaa_mistral_tripode",4,100,0,GRLIB_perm_tank],
	["ffaa_milan_tripode",5,125,0,GRLIB_perm_tank],
	["ffaa_tow_tripode",5,175,0,GRLIB_perm_air],
	["ffaa_spike_tripode",5,250,0,GRLIB_perm_air],
	["B_Mortar_01_F",10,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["B_G_Offroad_01_repair_F",5,50,5,GRLIB_perm_inf],
	["ffaa_famet_ec135",15,600,15,GRLIB_perm_log],
	["B_G_Van_01_fuel_F",5,50,20,GRLIB_perm_inf],
	["Box_FFAA_WpsLaunch_F",0,300,0,GRLIB_perm_tank],
	["B_APC_Tracked_01_CRV_F",15,2000,50,GRLIB_perm_max]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["ffaa_bandera_espa",0,0,0,0]
];

blufor_squad_inf_light = [
	"ffaa_brilat_jefe_peloton_ds",
	"ffaa_brilat_medico_ds",
	"ffaa_brilat_granadero_ds",
	"ffaa_brilat_mg4_ds",
	"ffaa_brilat_c90_ds",
	"ffaa_brilat_soldado_ds",
	"ffaa_brilat_soldado_ds",
	"ffaa_brilat_soldado_ds"
];
blufor_squad_inf = [
	"ffaa_brilat_jefe_peloton_ds",
	"ffaa_brilat_medico_ds",
	"ffaa_brilat_mg4_ds",
	"ffaa_brilat_mg4_ds",
	"ffaa_brilat_c90_ds",
	"ffaa_brilat_mg42_ds",
	"ffaa_brilat_observador_ds",
	"ffaa_brilat_soldado_ds",
	"ffaa_brilat_soldado_ds",
	"ffaa_brilat_soldado_ds"
];
blufor_squad_at = [
	"ffaa_brilat_jefe_peloton_ds",
	"ffaa_brilat_medico_ds",
	"ffaa_brilat_alcotan_ds",
	"ffaa_brilat_alcotan_ds",
	"ffaa_brilat_soldado_ds",
	"ffaa_brilat_soldado_ds"
];
blufor_squad_aa = [
	"ffaa_brilat_jefe_peloton_ds",
	"ffaa_brilat_medico_ds",
	"B_Soldier_AA_F",
	"B_Soldier_AA_F",
	"ffaa_brilat_soldado_ds",
	"ffaa_brilat_soldado_ds"
];
blufor_squad_mix = [
	"ffaa_brilat_jefe_peloton_ds",
	"ffaa_brilat_medico_ds",
	"B_Soldier_AA_F",
	"ffaa_brilat_alcotan_ds",
	"ffaa_brilat_soldado_ds",
	"ffaa_brilat_soldado_ds"
];
blufor_squad_recon = [
	"ffaa_et_moe_lider_ds",
	"ffaa_ar_fgne_medico_ds",
	"ffaa_ar_fgne_tirador_ds",
	"ffaa_ar_fgne_at_ds",
	"ffaa_ar_fgne_sabot_ds",
	"ffaa_et_moe_fusilero_mochila_ds"
];

squads = [
	[blufor_squad_inf_light,10,400,0,GRLIB_perm_max],
	[blufor_squad_inf,20,500,0,GRLIB_perm_max],
	[blufor_squad_at,30,700,0,GRLIB_perm_max],
	[blufor_squad_aa,30,700,0,GRLIB_perm_max],
	[blufor_squad_mix,30,800,0,GRLIB_perm_max],
	[blufor_squad_recon,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
	"ffaa_raven",
	"ffaa_et_searcherIII",
	"ffaa_ea_reaper",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F"
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

];

GRLIB_vehicle_blacklist_west = [

];

box_transport_config_west = [

];