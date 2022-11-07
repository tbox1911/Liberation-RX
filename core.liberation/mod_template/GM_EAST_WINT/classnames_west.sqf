// *** FRIENDLIES ***
GRLIB_side_friendly = EAST;

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "gm_gc_airforce_mi2p";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "gm_gc_bgs_ural4320_repair" ;
Respawn_truck_typename = "gm_gc_army_ural375d_medic";
ammo_truck_typename = "gm_gc_army_ural4320_reammo";
fuel_truck_typename = "gm_gc_army_ural375d_refuel";
repair_truck_typename = "gm_gc_army_ural4320_repair";
repair_sling_typename = "gm_ge_army_shelteraceII_repair";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "gm_ge_army_shelteraceII_reammo";
medic_sling_typename = "gm_ge_army_shelteraceII_medic";
pilot_classname = "gm_pl_airforce_pilot_pm_80_gry";
crewman_classname = "gm_pl_army_crew_pm63_80_moro";
PAR_Medikit = "gm_gc_army_medbox";
PAR_AidKit = "gm_gc_army_medkit";
A3W_BoxWps = "gm_pl_army_ammobox_allmagazines_80";
canister_fuel_typename = "gm_jerrycan";
chimera_vehicle_overide = [
  ["B_Heli_Light_01_F",  "gm_pl_airforce_mi2p"],
  ["B_Heli_Transport_01_F", "gm_pl_airforce_mi2t"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["gm_pl_army_rifleman_akm_80_win",1,0,0,0],
	["gm_pl_army_medic_akm_80_win",1,0,0,0],
	["gm_pl_army_engineer_akm_80_win",1,0,0,0],
	["gm_pl_army_grenadier_akm_pallad_80_win",1,0,0,GRLIB_perm_inf],
	["gm_pl_army_machinegunner_rpk_80_win",1,0,0,GRLIB_perm_inf],
	["gm_pl_army_antitank_akm_rpg7_80_win",1,0,0,GRLIB_perm_log],
	["gm_pl_army_marksman_svd_80_win",1,0,0,GRLIB_perm_tank],
	["gm_pl_army_machinegunner_pk_80_win",1,0,0,GRLIB_perm_tank],
	["gm_pl_army_antiair_akm_9k32m_80_win",1,0,0,GRLIB_perm_tank],
	["O_diver_F",1,0,0,GRLIB_perm_log],
	["gm_pl_army_paratrooper_pm63_80_win",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [
	"gm_pl_army_antiair_akm_9k32m_80_win"
];

resistance_squad = [
	"gm_gc_army_sf_squadleader_mpikms72_80_win",
	"gm_gc_army_sf_machinegunner_lmgrpk_80_win",
	"gm_gc_army_sf_machinegunner_lmgrpk_80_win",
	"gm_gc_army_sf_rifleman_mpikms72_80_win",
	"gm_gc_army_sf_demolition_pm63_80_win",
	"gm_gc_army_sf_rifleman_pm63_80_win",
	"gm_gc_army_sf_radioman_mpikms72_80_win",
	"gm_gc_army_sf_marksman_svd_80_win",
	"gm_gc_army_sf_antitank_mpikms72_rpg7_80_win",
	"gm_gc_army_sf_antitank_mpikms72_rpg7_80_win",
	"gm_gc_army_sf_rifleman_mpikms72_80_win",
	"gm_gc_army_sf_marksman_svd_80_win"
];

light_vehicles = [
	// boat
	["I_Boat_Transport_01_F",1,25,1,0],
	["I_Boat_Armed_01_minigun_F",3,125,3,GRLIB_perm_log],
	// lvl 0
	["gm_gc_army_bicycle_01_oli",0,5,0,0],
	["gm_gc_army_p601",1,10,1,0],
	["gm_gc_army_uaz469_cargo",1,20,1,0],
	["gm_ge_civ_u1300l",2,40,5,0],
	// lvl 1
	["gm_gc_army_uaz469_dshkm",2,50,2,GRLIB_perm_inf],
	// lvl 2
	["gm_gc_army_ural375d_cargo",2,100,7,GRLIB_perm_log],
	// lvl 3
	["gm_gc_army_uaz469_spg9",3,75,3,GRLIB_perm_tank]
];

heavy_vehicles = [
	// lvl 2
	["gm_gc_army_brdm2um",3,200,7,GRLIB_perm_log],
	["gm_gc_army_brdm2",3,250,10,GRLIB_perm_log],
	// lvl 3
	["gm_gc_army_bmp1sp2",5,300,7,GRLIB_perm_tank],
	["gm_gc_army_btr60pb",5,350,10,GRLIB_perm_tank],
	["gm_pl_army_ot64a",7,400,12,GRLIB_perm_tank],
	// lvl 4
	["gm_gc_army_pt76b",12,800,12,GRLIB_perm_air],
	["gm_gc_army_t55ak",20,2000,25,GRLIB_perm_air],
	["gm_gc_army_zsu234v1",10,1000,15,GRLIB_perm_air],
	// lvl 5
	["gm_gc_army_t55am2b",30,2500,30,GRLIB_perm_max],
	["gm_gc_army_ural375d_mlrs",50,3000,50,GRLIB_perm_max],
	["gm_gc_army_2s1",35,2750,35,GRLIB_perm_max]
];

air_vehicles = [
	["gm_pl_airforce_mi2p",5,300,10,GRLIB_perm_log],
	["gm_pl_airforce_mi2us",10,500,15,GRLIB_perm_tank],
	["gm_pl_airforce_mi2urn",15,600,20,GRLIB_perm_air],
	["gm_pl_airforce_mi2urp",30,1250,30,GRLIB_perm_max],
	["gm_gc_airforce_l410t",5,500,15,GRLIB_perm_air]
];

blufor_air = [
	"gm_gc_airforce_mi2urn",
	"gm_gc_airforce_mi2us",
	"gm_gc_bgs_mi2us",
	"gm_pl_airforce_mi2us",
	"gm_pl_airforce_mi2urs",
	"gm_pl_airforce_mi2urpg",
	"gm_pl_airforce_mi2urp",
	"gm_pl_airforce_mi2urn"
];

boats_west = [
	"I_Boat_Transport_01_F",
	"I_Boat_Armed_01_minigun_F"
];

static_vehicles = [
	["O_HMG_01_F",0,10,0,GRLIB_perm_inf],
	["O_HMG_01_high_F",0,10,0,GRLIB_perm_log],
	["gm_gc_army_dshkm_aatripod",0,15,0,GRLIB_perm_log],
	["gm_gc_army_fagot_launcher_tripod",0,75,0,GRLIB_perm_tank],
	["gm_gc_army_spg9_tripod",0,50,0,GRLIB_perm_tank],
	["O_Mortar_01_F",0,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["gm_gc_airforce_mi2p",0,300,0,GRLIB_perm_tank]
];

//buildings_west_overide = true;
buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["gm_banner_GC",0,0,0,0],
	["gm_flag_GC",0,0,0,0],
	["gm_banner_PL",0,0,0,0],
	["gm_flag_PL",0,0,0,0]
];

blufor_squad_inf_light = [
	"gm_pl_army_squadleader_akm_80_win",
	"gm_pl_army_medic_akm_80_win",
	"gm_pl_army_grenadier_akm_pallad_80_win",
	"gm_pl_army_machinegunner_rpk_80_win",
	"gm_pl_army_radioman_akm_80_win",
	"gm_pl_army_rifleman_akm_80_win",
	"gm_pl_army_rifleman_akm_80_win",
	"gm_pl_army_rifleman_akm_80_win"
];
blufor_squad_inf = [
	"gm_pl_army_squadleader_akm_80_win",
	"gm_pl_army_medic_akm_80_win",
	"gm_pl_army_marksman_svd_80_win",
	"gm_pl_army_machinegunner_rpk_80_win",
	"gm_pl_army_radioman_akm_80_win",
	"gm_pl_army_machinegunner_pk_80_win",
	"gm_pl_army_grenadier_akm_pallad_80_win",
	"gm_pl_army_rifleman_akm_80_win",
	"gm_pl_army_rifleman_akm_80_win",
	"gm_pl_army_rifleman_akm_80_win"
];
blufor_squad_at = [
	"gm_pl_army_squadleader_akm_80_win",
	"gm_pl_army_medic_akm_80_win",
	"gm_pl_army_antitank_akm_rpg7_80_win",
	"gm_pl_army_antitank_akm_rpg7_80_win",
	"gm_pl_army_rifleman_akm_80_win",
	"gm_pl_army_rifleman_akm_80_win"
];

blufor_squad_aa = [
	"gm_pl_army_squadleader_akm_80_win",
	"gm_pl_army_medic_akm_80_win",
	"gm_pl_army_antiair_akm_9k32m_80_win",
	"gm_pl_army_antiair_akm_9k32m_80_win",
	"gm_pl_army_rifleman_akm_80_win",
	"gm_pl_army_rifleman_akm_80_win"
];
blufor_squad_mix = [
	"gm_pl_army_squadleader_akm_80_win",
	"gm_pl_army_medic_akm_80_win",
	"gm_pl_army_antiair_akm_9k32m_80_win",
	"gm_pl_army_antitank_akm_rpg7_80_win",
	"gm_pl_army_rifleman_akm_80_win",
	"gm_pl_army_rifleman_akm_80_win"
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
	"gm_gc_army_p601",
	"gm_gc_army_uaz469_cargo"
];

GRLIB_AirDrop_2 = [
	"gm_gc_army_uaz469_dshkm"
];

GRLIB_AirDrop_3 = [
	"gm_gc_army_brdm2um"
];

GRLIB_AirDrop_4 = [
	"gm_gc_army_ural375d_cargo"
];

GRLIB_AirDrop_5 = [
	"gm_pl_army_ot64a",
	"gm_gc_army_btr60pb",
	"gm_gc_army_brdm2"
];

GRLIB_AirDrop_6 = [
	"I_Boat_Armed_01_minigun_F"
];
