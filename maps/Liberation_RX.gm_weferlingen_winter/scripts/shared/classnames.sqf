// All Object classname used in RX must be declared here

if ( isNil "FOB_typename" ) then { FOB_typename = "Land_Cargo_HQ_V1_F" };
if ( isNil "FOB_box_typename" ) then { FOB_box_typename = "gm_ge_army_shelteraceII_standard" };
if ( isNil "FOB_truck_typename" ) then { FOB_truck_typename = "gm_ge_army_kat1_454_cargo" };
if ( isNil "Arsenal_typename" ) then { Arsenal_typename = "B_supplyCrate_F" };
if ( isNil "Respawn_truck_typename" ) then { Respawn_truck_typename = "gm_gc_army_ural375d_medic" };
if ( isNil "mobile_respawn" ) then { mobile_respawn = "Land_TentDome_F" };
if ( isNil "mobile_respawn_bag" ) then { mobile_respawn_bag = "B_Kitbag_Base" };
if ( isNil "huron_typename" ) then { huron_typename = "gm_ge_army_ch53g" };
if ( isNil "ammobox_b_typename" ) then { ammobox_b_typename = "Box_NATO_AmmoVeh_F" };
if ( isNil "ammobox_o_typename" ) then { ammobox_o_typename = "Box_East_AmmoVeh_F" };
if ( isNil "ammobox_i_typename" ) then { ammobox_i_typename = "Box_IND_AmmoVeh_F" };
if ( isNil "waterbarrel_typename" ) then { waterbarrel_typename = "Land_BarrelWater_F" };
if ( isNil "fuelbarrel_typename" ) then { fuelbarrel_typename = "Land_MetalBarrel_F" };
if ( isNil "foodbarrel_typename" ) then { foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F" };
if ( isNil "opfor_ammobox_transport" ) then { opfor_ammobox_transport = "gm_gc_army_ural4320_cargo" };
if ( isNil "commander_classname" ) then { commander_classname = "gm_ge_army_officer_p1_80_oli" };
if ( isNil "crewman_classname" ) then { crewman_classname = "gm_ge_army_crew_mp2a1_80_oli" };
if ( isNil "pilot_classname" ) then { pilot_classname = "gm_ge_army_pilot_p1_80_oli" };
if ( isNil "FAR_Medikit" ) then { FAR_Medikit = "Medikit" };
if ( isNil "FAR_AidKit" ) then { FAR_AidKit = "FirstAidKit" };
if ( isNil "A3W_BoxWps" ) then { A3W_BoxWps = "Box_East_Wps_F" };
if ( isNil "canisterFuel" ) then { canisterFuel = "gm_jerrycan" };

// *** FRIENDLIES ***
//gm_ge_army_rifleman_g3a3_80_ols
//gm_ge_army_rifleman_g3a3_parka_80_ols
//gm_ge_army_rifleman_g3a3_parka_80_win
infantry_units = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["gm_ge_army_rifleman_g3a3_80_ols",1,0,0,0],
	["gm_ge_army_rifleman_mp2a1_80_ols",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_sf_rifleman_mp5a3_80_wdl",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_medic_g3a3_80_ols",1,0,0,0],
	["gm_ge_army_engineer_g3a4_80_ols",1,0,0,0],
	["gm_ge_army_grenadier_g3a3_80_ols",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_antitank_g3a3_milan_80_ols",1,0,0,0],
	["gm_ge_army_antitank_g3a3_pzf44_80_ols",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_machinegunner_mg3_80_ols",1,0,0,GRLIB_perm_inf],
	["gm_ge_army_sf_rifleman_mp5a3_80_wdl",1,0,0,GRLIB_perm_log],
	["gm_ge_army_antiair_g3a3_fim43_80_ols",1,0,0,GRLIB_perm_log],
	["gm_ge_army_antitank_g3a3_pzf84_80_ols",1,0,0,GRLIB_perm_log],
	["gm_ge_army_marksman_g3a3_80_ols",1,0,0,GRLIB_perm_log],
	["gm_ge_army_paratrooper_g3a4_80_oli",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

// calc units price
_grp = createGroup [GRLIB_side_friendly, true];
{
	_unit_class = _x select 0;
	_unit_mp = _x select 1;
	_unit_rank = _x select 4;
	_unit = _grp createUnit [_unit_class, [0,0,0], [], 0, "NONE"];
	_price = [_unit] call F_loadoutPrice;
	infantry_units set [_forEachIndex, [_unit_class, _unit_mp, _price, 0,_unit_rank] ];
	deleteVehicle _unit;
} foreach infantry_units ;

light_vehicles = [
	["gm_gc_army_bicycle_01_oli",1,5,1,0],
	["gm_ge_army_k125",1,10,1,0],
	["gm_gc_civ_p601",1,15,1,0],
	["gm_ge_civ_typ1200",1,15,1,GRLIB_perm_inf],
	["gm_ge_army_u1300l_container",1,25,1,0],
	["gm_ge_army_iltis_cargo",1,5,1,0],
	["gm_ge_army_iltis_milan",5,100,2,GRLIB_perm_inf],
	["gm_ge_army_iltis_mg3",5,125,2,GRLIB_perm_log],
	["gm_ge_army_m113a1g_apc",2,25,2,0],
	["gm_ge_army_m113a1g_apc_milan",5,100,2,GRLIB_perm_inf],
	["gm_ge_army_m113a1g_medic",5,125,2,GRLIB_perm_log],
	["gm_ge_army_kat1_451_container",5,30,5,GRLIB_perm_log],
	["gm_ge_army_kat1_451_cargo",5,30,5,GRLIB_perm_log],
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

buildings = [
	["Land_PierLadder_F",0,0,0,GRLIB_perm_inf],
	["Land_CncBarrierMedium4_F",0,0,0,0],
	["Land_CncWall4_F",0,0,0,0],
	["Land_BagFence_Round_F",0,0,0,GRLIB_perm_log],
	["Land_BagFence_Long_F",0,0,0,0],
	["Land_BagFence_Short_F",0,0,0,GRLIB_perm_inf],
	["Land_BagFence_Corner_F",0,0,0,GRLIB_perm_log],
	["Land_HBarrier_5_F",0,0,0,0],
	["Land_HBarrierWall4_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierWall6_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierWall_corner_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierTower_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierBig_F",0,0,0,GRLIB_perm_tank],
	["Land_CncShelter_F",0,0,0,GRLIB_perm_log],
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["Land_BagBunker_Small_F",0,0,0,0],
	["Land_BagBunker_Large_F",0,0,0,GRLIB_perm_tank],
	["Land_BagBunker_Tower_F",0,0,0,GRLIB_perm_tank],
	["Land_SM_01_shed_F",0,0,0,GRLIB_perm_max],
	["Land_Hangar_F",0,0,0,GRLIB_perm_max],
	["Flag_NATO_F",0,0,0,0],
	["Land_PortableLight_double_F",0,0,0,GRLIB_perm_log],
	["Land_LampHalogen_F",0,0,0,GRLIB_perm_tank],
	["Land_HelipadSquare_F",0,0,0,GRLIB_perm_log],
	["Land_Razorwire_F",0,0,0,GRLIB_perm_tank],
	["Land_ToolTrolley_02_F",0,0,0,GRLIB_perm_tank],
	["Land_WeldingTrolley_01_F",0,0,0,GRLIB_perm_tank],
	["Land_GasTank_02_F",0,0,0,GRLIB_perm_tank],
	["Land_Workbench_01_F",0,0,0,GRLIB_perm_tank],
	["Land_WaterTank_F",0,0,0,GRLIB_perm_tank],
	["Land_WaterBarrel_F",0,0,0,GRLIB_perm_tank],
	["Land_BarGate_F",0,0,0,GRLIB_perm_log],
	["Land_MetalCase_01_large_F",0,0,0,GRLIB_perm_tank],
	["CargoNet_01_box_F",0,0,0,GRLIB_perm_tank],
	["CamoNet_BLUFOR_open_F",0,0,GRLIB_perm_tank],
	["CamoNet_BLUFOR_big_F",0,0,0,GRLIB_perm_tank],
	["Land_CampingChair_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_CampingChair_V2_F",0,0,0,GRLIB_perm_tank],
	["Land_CampingTable_F",0,0,0,GRLIB_perm_tank],
	["MapBoard_altis_F",0,0,0,GRLIB_perm_tank],
	["Land_Metal_rack_Tall_F",0,0,0,GRLIB_perm_tank],
	["PortableHelipadLight_01_blue_F",0,0,0,GRLIB_perm_tank],
	["Land_DieselGroundPowerUnit_01_F",0,0,0,GRLIB_perm_tank],
	["Land_Pallet_MilBoxes_F",0,0,0,GRLIB_perm_tank],
	["Land_PaperBox_open_full_F",0,0,0,GRLIB_perm_tank],
	["Land_ClutterCutter_large_F",0,0,0,GRLIB_perm_tank],
	["Land_CzechHedgehog_01_new_F",0,0,0,GRLIB_perm_inf]
];

support_vehicles = [
	[Arsenal_typename,0,10,0,0],
	["Box_B_UAV_06_medical_F",5,5,0,0],
	[mobile_respawn,10,5,0,0],
	["gm_jerrycan",0,5,1,0],
	["gm_ge_army_shelteraceII_repair",5,50,5,GRLIB_perm_inf],
	["gm_gc_army_shelteraceII_medic",5,50,5,GRLIB_perm_inf],
	[Respawn_truck_typename,15,50,5,GRLIB_perm_log],
	["gm_gc_army_shelterlakII_repair",10,100,0,GRLIB_perm_log],
	["gm_gc_army_shelterlakII_medic",10,100,0,GRLIB_perm_log],
	["gm_ge_army_kat1_451_reammo",5,150,10,GRLIB_perm_tank],
	["gm_ge_army_u1300l_repair",10,130,10,GRLIB_perm_tank],
	["gm_ge_army_kat1_451_refuel",5,120,40,GRLIB_perm_tank],
	["gm_AmmoBox_wood_02_empty",0,80,0,GRLIB_perm_log],
	["gm_AmmoBox_wood_03_empty",0,150,0,GRLIB_perm_tank],
	["Land_CargoBox_V1_F",0,500,0,GRLIB_perm_max],
	[FOB_box_typename,50,1500,50,GRLIB_perm_max],
	[FOB_truck_typename,50,1500,50,GRLIB_perm_max],
	[ammobox_b_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_o_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[ammobox_i_typename,0,round(300 / GRLIB_recycling_percentage),0,99999],
	[A3W_BoxWps,0,round(150 / GRLIB_recycling_percentage),0,99999],
	[waterbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf],
	[fuelbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf],
	[foodbarrel_typename,0,round(100 / GRLIB_recycling_percentage),0,GRLIB_perm_inf]
];

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_wdl",
	"gm_ge_army_sf_marksman_g3a3_80_wdl",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_wdl",
	"gm_ge_army_sf_rifleman_g3a4_80_wdl",
	"gm_ge_army_sf_rifleman_g3a4_80_wdl"
	];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_wdl",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_sf_marksman_g3a3_80_wdl",
	"gm_ge_army_sf_marksman_g3a3_80_wdl",
	"gm_ge_army_sf_rifleman_g3a4_80_wdl",
	"gm_ge_army_sf_rifleman_g3a4_80_wdl",
	"gm_ge_army_sf_rifleman_mp5a3_80_wdl",
	"gm_ge_army_sf_rifleman_mp5a3_80_wdl",
	"gm_ge_army_sf_rifleman_mp5a3_80_wdl"
	];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_wdl",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_wdl",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_wdl",
	"gm_ge_army_sf_antitank_mp5a3_milan_80_wdl",
	"gm_ge_army_sf_rifleman_mp5a3_80_wdl"
	];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_wdl",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_sf_antiair_mp5a3_fim43_80_wdl",
	"gm_ge_army_sf_antiair_mp5a3_fim43_80_wdl",
	"gm_ge_army_sf_antiair_mp5a3_fim43_80_wdl",
	"gm_ge_army_sf_rifleman_mp5a3_80_wdl"
	];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"gm_ge_army_sf_squadleader_mp5sd3_p2a1_80_wdl",
	"gm_ge_army_medic_g3a3_80_ols",
	"gm_ge_army_sf_antiair_mp5a3_fim43_80_wdl",
	"gm_ge_army_sf_antitank_mp5a2_pzf84_80_wdl",
	"gm_ge_army_sf_rifleman_g3a4_80_wdl",
	"gm_ge_army_sf_rifleman_g3a4_80_wdl"
	];
};

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_at,25,400,0,GRLIB_perm_max],
	[blufor_squad_aa,25,500,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max],
	[blufor_squad_inf,20,800,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];
if ( isNil "uavs" ) then { uavs = [] };

elite_vehicles = [
	"gm_ge_army_Leopard1a5",
	"gm_ge_army_bpz2a0",
	"gm_ge_army_bo105p_pah1a1",
	"gm_ge_army_Leopard1a1a4",
	"gm_ge_army_Leopard1a3a3"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources = [
	Arsenal_typename,
	"gm_ge_army_kat1_451_reammo",
	"gm_ge_army_bpz2a0"
];

// Everything the AI troups should be able to healing from
ai_healing_sources = [
	Respawn_truck_typename,
	"Box_B_UAV_06_medical_F",
	"gm_gc_army_shelteraceII_medic",
	"gm_gc_army_shelterlakII_medic",
	"gm_dk_army_m113a1dk_medic",
	"gm_ge_army_bpz2a0"
];

// Everything that can resupply other vehicles
vehicle_repair_sources = [
	"gm_ge_army_bpz2a0",
	"gm_ge_army_shelteraceII_repair",
	"gm_gc_army_shelterlakII_repair",
	"gm_ge_army_u1300l_repair",
	"gm_ge_army_fuchsa0_engineer"
];

vehicle_rearm_sources = [
	"gm_ge_army_bpz2a0",
	"gm_ge_army_kat1_451_reammo",
	"gm_AmmoBox_wood_02_empty",
	"gm_AmmoBox_wood_03_empty"
];

vehicle_refuel_sources = [
	"gm_ge_army_bpz2a0",
	"gm_ge_army_kat1_451_refuel"
];

vehicle_artillery = [
	"B_Mortar_01_F"
];

// *** BADDIES ***
//gm_gc_army_rifleman_mpiak74n_80_str
//gm_gc_army_rifleman_mpiak74n_80_win
//gm_gc_army_sf_rifleman_mpikms72_80_str
//gm_gc_army_sf_rifleman_mpikms72_80_win

if ( isNil "opfor_sentry") then { opfor_sentry = "gm_gc_bgs_rifleman_mpikm72_80_str" };
if ( isNil "opfor_rifleman") then { opfor_rifleman = "gm_gc_army_rifleman_mpiak74n_80_str" };
if ( isNil "opfor_grenadier") then { opfor_grenadier = "O_Soldier_GL_F" };
if ( isNil "opfor_squad_leader") then { opfor_squad_leader = "gm_gc_army_squadleader_mpiak74n_80_str" };
if ( isNil "opfor_team_leader") then { opfor_team_leader = "gm_gc_army_sf_squadleader_mpikms72_80_str" };
if ( isNil "opfor_marksman") then { opfor_marksman = "gm_gc_army_sf_marksman_svd_80_str" };
if ( isNil "opfor_machinegunner") then { opfor_machinegunner = "gm_gc_army_machinegunner_lmgrpk74_80_str" };
if ( isNil "opfor_heavygunner") then { opfor_heavygunner = "gm_gc_army_machinegunner_pk_80_str" };
if ( isNil "opfor_medic") then { opfor_medic = "gm_pl_army_medic_akm_80_autumn_moro" };
if ( isNil "opfor_rpg") then { opfor_rpg = "gm_gc_army_antitank_mpiak74n_rpg7_80_str" };
if ( isNil "opfor_at") then { opfor_at = "gm_gc_army_antitank_mpiak74n_fagot_80_str" };
if ( isNil "opfor_aa") then { opfor_aa = "gm_gc_army_antiair_mpiak74n_9k32m_80_str" };
if ( isNil "opfor_officer") then { opfor_officer = "gm_gc_army_officer_pm_80_str" };
if ( isNil "opfor_sharpshooter") then { opfor_sharpshooter = "gm_gc_army_sf_rifleman_pm63_80_str" };
if ( isNil "opfor_sniper") then { opfor_sniper = "gm_pl_army_sf_marksman_svd_80_moro" };
if ( isNil "opfor_engineer") then { opfor_engineer = "gm_gc_army_engineer_mpiaks74n_80_str" };
if ( isNil "opfor_paratrooper") then { opfor_paratrooper = "gm_gc_army_paratrooper_mpiaks74n_80_str" };
if ( isNil "opfor_mrap") then { opfor_mrap = "gm_gc_army_brdm2um" };
if ( isNil "opfor_mrap_armed") then { opfor_mrap_armed = "gm_gc_army_brdm2" };
if ( isNil "opfor_transport_helo") then { opfor_transport_helo = "gm_gc_airforce_mi2p" };
if ( isNil "opfor_transport_truck") then { opfor_transport_truck = "gm_gc_army_ural4320_cargo" };
if ( isNil "opfor_fuel_truck") then { opfor_fuel_truck = "gm_gc_army_ural375d_refuel" };
if ( isNil "opfor_ammo_truck") then { opfor_ammo_truck = "gm_gc_army_ural4320_reammo" };
if ( isNil "opfor_fuel_container") then { opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F" };
if ( isNil "opfor_ammo_container") then { opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F" };
if ( isNil "opfor_flag") then { opfor_flag = "gm_flag_GC" };

militia_squad = [
	"gm_pl_army_sf_squadleader_akmn_80_moro",
	"gm_pl_army_medic_akm_80_moro",
	"gm_pl_army_sf_rifleman_pm63_80_moro",
	"gm_pl_army_sf_rifleman_pm63_80_moro",
	"gm_pl_army_sf_rifleman_akmn_80_moro",
	"gm_pl_army_sf_rifleman_akmn_80_moro",
	"gm_pl_army_sf_machinegunner_rpk_80_moro",
	"gm_pl_army_sf_antitank_akmn_rpg7_80_moro",
	"gm_pl_army_sf_antitank_akmn_rpg7_80_moro",
	"gm_pl_army_sf_antiair_pm63_9k32m_80_moro",
	"gm_pl_army_sf_antiair_pm63_9k32m_80_moro",
	"gm_pl_army_sf_marksman_svd_80_moro",
	"gm_pl_army_sf_machinegunner_rpk_80_moro",
	"gm_pl_army_sf_marksman_svd_80_moro",
	"gm_pl_army_sf_rifleman_pm63_80_moro",
	"gm_pl_army_sf_rifleman_akmn_80_moro"
];

divers_squad = [
	"O_diver_TL_F",
	"O_diver_TL_F",
	"O_diver_exp_F",
	"O_diver_exp_F",
	"O_diver_exp_F",
	"O_diver_exp_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F",
	"O_diver_F"
];

resistance_squad = [
	"B_G_Soldier_SL_F",
	"B_G_Soldier_A_F",
	"B_G_Soldier_AR_F",
	"B_G_medic_F",
	"B_G_engineer_F",
	"B_G_Soldier_exp_F",
	"B_G_Soldier_GL_F",
	"B_G_Soldier_M_F",
	"B_G_Soldier_F",
	"B_G_Soldier_LAT_F",
	"B_G_Soldier_lite_F",
	"B_G_Sharpshooter_F",
	"B_G_Soldier_TL_F",
	"B_G_Soldier_AA_F",
	"B_G_Soldier_AT_F"
];

militia_vehicles = [
	"gm_pl_army_brdm2",
	"gm_pl_army_ot64a",
	"gm_pl_army_bmp1sp2",
	"gm_gc_army_brdm2",
	"gm_gc_army_btr60pa",
	"gm_gc_army_btr60pb",
	"gm_gc_army_bmp1sp2",
	"gm_pl_army_brdm2",
	"gm_pl_army_ot64a",
	"gm_pl_army_bmp1sp2"
];

opfor_boat = [
];

opfor_vehicles = [
	"gm_gc_army_pt76b",
	"gm_gc_army_pt76b",
	"gm_gc_army_t55",
	"gm_gc_army_t55a",
	"gm_gc_army_t55ak",
	"gm_gc_army_t55am2",
	"gm_gc_army_t55am2b",
	"gm_gc_army_zsu234v1",
	"gm_pl_army_pt76b",
	"gm_pl_army_t55",
	"gm_pl_army_t55ak",
	"gm_pl_army_zsu234v1"
];

opfor_vehicles_low_intensity = [
	"gm_pl_army_brdm2",
	"gm_pl_army_brdm2",
	"gm_gc_army_btr60pa",
	"gm_gc_army_btr60pb",
	"gm_gc_army_pt76b",
	"gm_gc_army_pt76b",
	"gm_pl_army_ot64a",
	"gm_pl_army_ot64a",
	"gm_pl_army_pt76b"
];

opfor_battlegroup_vehicles = [
  	"gm_gc_airforce_mi2p",
  	"gm_gc_airforce_mi2urn",
  	"gm_gc_airforce_mi2us",
  	"gm_gc_bgs_mi2us",
	"gm_gc_army_pt76b",
	"gm_gc_army_t55",
	"gm_gc_army_t55a",
	"gm_gc_army_t55ak",
	"gm_gc_army_t55am2",
	"gm_gc_army_t55am2b",
	"gm_gc_army_zsu234v1",
	"gm_pl_army_pt76b",
	"gm_pl_army_t55",
	"gm_pl_army_t55ak",
	"gm_pl_army_zsu234v1",
	"gm_gc_bgs_ural4320_repair",
	"gm_gc_bgs_ural4320_reammo"
];

opfor_battlegroup_vehicles_low_intensity = [
	"gm_gc_airforce_mi2urn",
	"gm_gc_airforce_mi2us",
	"gm_gc_bgs_mi2us",
	"gm_gc_army_pt76b",
	"gm_gc_army_t55",
	"gm_gc_army_pt76b",
	"gm_gc_army_btr60pa",
	"gm_gc_army_btr60pb",
	"gm_gc_bgs_ural4320_repair"
];

opfor_troup_transports = [
	"gm_gc_army_btr60pu12",
	"gm_gc_army_ural4320_cargo",
	"gm_gc_bgs_ural4320_cargo",
	"gm_gc_airforce_mi2p",
	"gm_gc_airforce_mi2t",
	"gm_gc_airforce_l410t",
	"gm_gc_airforce_l410s_salon"
];

opfor_choppers = [
	"gm_gc_airforce_mi2p",
	"gm_gc_airforce_mi2t",
	"gm_gc_airforce_mi2urn",
	"gm_gc_airforce_mi2urn",
	"gm_gc_airforce_mi2us",
	"gm_gc_bgs_mi2us",
	"gm_pl_airforce_mi2us",
	"gm_pl_airforce_mi2urs",
	"gm_pl_airforce_mi2urpg",
	"gm_pl_airforce_mi2urp",
	"gm_pl_airforce_mi2urn"
];

opfor_air = [
	"gm_gc_airforce_l410t",
	"gm_gc_airforce_l410s_salon"
];

opfor_statics = [
	"O_HMG_01_high_F",
	"O_GMG_01_high_F",
	"O_Mortar_01_F"
];

ind_recyclable = [
	["I_Truck_02_covered_F",0,round (20 / GRLIB_recycling_percentage),0],
	["I_Truck_02_transport_F",0,round (20 / GRLIB_recycling_percentage),0]
];

opfor_texture_overide = [
	//"Urban",
	//"Digital"
];

opfor_recyclable = [
	["gm_gc_army_pt76b",0,round (20 / GRLIB_recycling_percentage),0],
	["gm_pl_army_pt76b",0,round (20 / GRLIB_recycling_percentage),0],
	["gm_gc_bgs_ural4320_repair",0,round (20 / GRLIB_recycling_percentage),0],
	["gm_gc_bgs_ural4320_reammo",0,round (20 / GRLIB_recycling_percentage),0],
	["gm_gc_army_ural4320_cargo",0,round (20 / GRLIB_recycling_percentage),0],
	["gm_gc_bgs_ural4320_cargo",0,round (20 / GRLIB_recycling_percentage),0],
	["gm_gc_army_brdm2um",0,round (20 / GRLIB_recycling_percentage),0],
	["gm_pl_army_brdm2",0,round (50 / GRLIB_recycling_percentage),0],
	["gm_pl_army_ot64a",0,round (50 / GRLIB_recycling_percentage),0],
	["gm_gc_army_btr60pa",0,round (150 / GRLIB_recycling_percentage),0],
	["gm_gc_army_btr60pb",0,round (150 / GRLIB_recycling_percentage),0],
	["gm_pl_army_bmp1sp2",0,round (150 / GRLIB_recycling_percentage),0],
	["gm_gc_army_t55",0,round (400 / GRLIB_recycling_percentage),0],
	["gm_pl_army_t55",0,round (400 / GRLIB_recycling_percentage),0],
	["gm_gc_army_t55a",0,round (400 / GRLIB_recycling_percentage),0],
	["gm_gc_army_t55ak",0,round (400 / GRLIB_recycling_percentage),0],
	["gm_pl_army_t55ak",0,round (400 / GRLIB_recycling_percentage),0],
	["gm_gc_army_t55am2",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_gc_army_t55am2b",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_gc_army_zsu234v1",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_pl_army_zsu234v1",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_gc_airforce_mi2p",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_gc_airforce_mi2t",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_gc_airforce_mi2urn",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_pl_airforce_mi2urn",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_gc_airforce_mi2us",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_pl_airforce_mi2us",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_pl_airforce_mi2urs",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_pl_airforce_mi2urpg",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_pl_airforce_mi2urp",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_gc_airforce_l410t",0,round (500 / GRLIB_recycling_percentage),0],
	["gm_gc_airforce_l410s_salon",0,round (500 / GRLIB_recycling_percentage),0]
];

// Other stuff

civilians = [
	"C_Orestes",
	"C_Nikos",
	"C_Nikos_aged",
	"C_man_1",
	"C_man_polo_6_F",
	"C_man_polo_3_F",
	"C_man_polo_2_F",
	"C_man_polo_4_F",
	"C_man_polo_5_F",
	"C_man_polo_1_F",
	"C_man_p_beggar_F",
	"C_man_1_2_F",
	"C_man_p_fugitive_F",
	"C_man_hunter_1_F",
	"C_Man_Fisherman_01_F",
	"C_man_sport_1_F",
	"C_man_sport_3_F",
	"C_man_sport_2_F",
	"C_Man_Messenger_01_F",
	"C_Story_Mechanic_01_F",
	"C_Man_casual_2_F",
	"C_Man_casual_4_F",
	"C_Man_casual_1_F",
	"C_Man_casual_3_F",
	"C_Man_casual_5_F",
	"C_journalist_F",
	"C_man_shorts_2_F",
	"C_man_w_worker_F",
	"C_Paramedic_01_base_F",
	"C_Man_UtilityWorker_01_F"
];

civilian_vehicles = [
	"gm_ge_pol_bo105m_vbh",
	"gm_gc_civ_mi2p",
	"gm_gc_civ_mi2r",
	"gm_ge_bgs_k125",
	"gm_ge_bgs_k125",
	"gm_ge_bgs_k125",
	"gm_xx_civ_bicycle_01",
	"gm_xx_civ_bicycle_01",
	"gm_xx_civ_bicycle_01",
	"gm_xx_civ_bicycle_01",
	"gm_gc_civ_p601",
	"gm_gc_civ_p601",
	"gm_gc_civ_p601",
	"gm_gc_civ_p601",
	"gm_gc_dp_p601",
	"gm_gc_ff_p601",
	"gm_gc_pol_p601",
	"gm_ge_civ_typ1200",
	"gm_ge_civ_typ1200",
	"gm_ge_civ_typ1200",
	"gm_ge_civ_typ1200",
	"gm_ge_pol_typ1200",
	"gm_ge_ff_typ1200",
	"gm_ge_dbp_typ1200",
	"gm_pl_army_ural4320_cargo",
	"gm_gc_army_ural4320_cargo",
	"gm_gc_bgs_ural4320_cargo",
	"gm_ge_army_iltis_cargo",
	"gm_ge_army_u1300l_cargo",
	"gm_ge_army_u1300l_container",
	"C_Tractor_01_F"
];

// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries
box_transport_config = [
	[ "C_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "B_G_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "I_G_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "B_Truck_01_transport_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
	[ "B_Truck_01_covered_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
	[ "C_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "C_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_Truck_02_transport_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "I_Truck_02_covered_F", -5.5, [0, 0.3, 0], [0, -1.25, 0], [0, -2.8, 0] ],
	[ "O_Truck_03_transport_F", -6.5, [0, -0.8, 0.4], [0, -2.4, 0.4], [0, -4.0, 0.4] ],
	[ "O_Truck_03_covered_F", -6.5, [0, -0.8, 0.4], [0, -2.4, 0.4], [0, -4.0, 0.4] ],
	[ "C_Van_01_box_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ],
	[ "C_Van_01_transport_F", -5.3, [0, -1.05, 0.2], [0, -2.6, 0.2] ],
	[ "B_Heli_Transport_03_F", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1] ],
	[ "B_Heli_Transport_03_unarmed_F", -7.5, [0, 2.2, -1], [0, 0.8, -1], [0, -1.0, -1] ],
	[ "I_Heli_Transport_02_F", -6.5, [0, 4.2, -1.45], [0, 2.5, -1.45], [0, 0.8, -1.45], [0, -0.9, -1.45] ]
];
transport_vehicles = [];
{transport_vehicles pushBack ( _x select 0 )} foreach (box_transport_config);

// Whitelist Vehicle (recycle)
GRLIB_vehicle_whitelist = [
	Arsenal_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	mobile_respawn,
	A3W_BoxWps,
	canisterFuel,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	"Land_PierLadder_F",
	"Box_B_UAV_06_medical_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncWall4_F",
	"Land_HBarrier_5_F",
	"Land_BagBunker_Small_F",
	"Land_BagFence_Long_F"
];
{GRLIB_vehicle_whitelist pushBack ( _x select 0 )} foreach (static_vehicles + opfor_recyclable);

// Blacklist Vehicle (lock and paint)
GRLIB_vehicle_blacklist = [
	Arsenal_typename,
	mobile_respawn,
	huron_typename,
	opfor_ammobox_transport,
	Respawn_truck_typename,
	FOB_box_typename,
	FOB_truck_typename,
	canisterFuel,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename,
	"gm_AmmoBox_wood_02_empty",
        "gm_AmmoBox_wood_03_empty",
	"Box_B_UAV_06_medical_F",
	"B_Slingload_01_Repair_F",
	"B_Slingload_01_Fuel_F",
	"B_Slingload_01_Ammo_F",
	"B_Slingload_01_Medevac_F",
	"B_Heli_Transport_01_F",
	"O_Heli_Light_02_unarmed_F",
	"O_Truck_03_transport_F",
	"O_Truck_03_covered_F",
	"O_Truck_03_ammo_F",
	"O_Truck_03_fuel_F",
	"O_Truck_03_medical_F"
];
//{GRLIB_vehicle_blacklist pushBack ( _x select 0 )} foreach (support_vehicles);

infantry_units = [ infantry_units ] call F_filterMods;
light_vehicles = [ light_vehicles ] call F_filterMods;
heavy_vehicles = [ heavy_vehicles ] call F_filterMods;
air_vehicles = [ air_vehicles ] call F_filterMods;
support_vehicles = [ support_vehicles ] call F_filterMods;
static_vehicles = [ static_vehicles ] call F_filterMods;
buildings = [ buildings ] call F_filterMods;
build_lists = [[],infantry_units,light_vehicles,heavy_vehicles,air_vehicles,static_vehicles,buildings,support_vehicles,squads];
militia_squad = [ militia_squad , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
militia_vehicles = [ militia_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_vehicles = [ opfor_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_vehicles_low_intensity = [ opfor_vehicles_low_intensity , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_battlegroup_vehicles = [ opfor_battlegroup_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_battlegroup_vehicles_low_intensity = [ opfor_battlegroup_vehicles_low_intensity , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_troup_transports = [ opfor_troup_transports , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_choppers = [ opfor_choppers , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
opfor_air = [ opfor_air , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
civilians = [ civilians , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
civilian_vehicles = [ civilian_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
military_alphabet = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliet","Kilo","Lima","Mike","November","Oscar","Papa","Quebec","Romeo","Sierra","Tango","Uniform","Victor","Whiskey","X-Ray","Yankee","Zulu"];
land_vehicles_classnames = (opfor_vehicles + militia_vehicles);
opfor_squad_low_intensity = [
	opfor_squad_leader,
	opfor_medic,
	opfor_rpg,
	opfor_sentry,
	opfor_sentry,
	opfor_sentry,
	opfor_sentry
];
opfor_squad_8_standard = [
	opfor_squad_leader,
	opfor_medic,
	opfor_machinegunner,
	opfor_rpg,
	opfor_heavygunner,
	opfor_marksman,
	opfor_marksman,
	opfor_grenadier
];
opfor_squad_8_infkillers = [
	opfor_squad_leader,
	opfor_medic,
	opfor_machinegunner,
	opfor_heavygunner,
	opfor_marksman,
	opfor_sharpshooter,
	opfor_sniper,
	opfor_rpg
];
opfor_squad_8_tankkillers = [
	opfor_squad_leader,
	opfor_medic,
	opfor_machinegunner,
	opfor_rpg,
	opfor_rpg,
	opfor_at,
	opfor_at,
	opfor_at
];
opfor_squad_8_airkillers = [
	opfor_squad_leader,
	opfor_medic,
	opfor_machinegunner,
	opfor_rpg,
	opfor_rpg,
	opfor_aa,
	opfor_aa,
	opfor_aa
];
all_resistance_troops = [] + militia_squad;
all_hostile_classnames = (land_vehicles_classnames + opfor_air + opfor_choppers + opfor_troup_transports + opfor_vehicles_low_intensity + opfor_boat);
{ land_vehicles_classnames pushback (_x select 0); } foreach (heavy_vehicles + light_vehicles);
air_vehicles_classnames = [] + opfor_choppers;
{ air_vehicles_classnames pushback (_x select 0); } foreach air_vehicles;
markers_reset = [99999,99999,0];
zeropos = [0,0,0];
squads_names = [ localize "STR_LIGHT_RIFLE_SQUAD", localize "STR_RIFLE_SQUAD", localize "STR_AT_SQUAD", localize "STR_AA_SQUAD", localize "STR_MIXED_SQUAD", localize "STR_RECON_SQUAD" ];
boats_names = [ "B_Boat_Transport_01_F", "B_Boat_Armed_01_minigun_F" ];
ammobox_transports_typenames = [];
{ ammobox_transports_typenames pushback (_x select 0) } foreach box_transport_config;
ammobox_transports_typenames = [ ammobox_transports_typenames , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
elite_vehicles = [ elite_vehicles , { [ _x ] call F_checkClass } ]  call BIS_fnc_conditionalSelect;
original_resistance = [ "O_G_Soldier_SL_F","O_G_Soldier_A_F","O_G_Soldier_AR_F","O_G_medic_F","O_G_engineer_F","O_G_Soldier_exp_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","O_G_Soldier_F","O_G_Soldier_LAT_F","O_G_Soldier_lite_F","O_G_Sharpshooter_F","O_G_Soldier_TL_F","O_Soldier_AA_F","O_Soldier_AT_F"];
opfor_infantry = [opfor_sentry,opfor_rifleman,opfor_grenadier,opfor_squad_leader,opfor_team_leader,opfor_marksman,opfor_machinegunner,opfor_heavygunner,opfor_medic,opfor_rpg,opfor_at,opfor_aa,opfor_officer,opfor_sharpshooter,opfor_sniper,opfor_engineer];
GRLIB_intel_table = "Land_CampingTable_small_F";
GRLIB_intel_chair = "Land_CampingChair_V2_F";
GRLIB_intel_file = "Land_File1_F";
GRLIB_intel_laptop = "Land_Laptop_device_F";
GRLIB_ignore_colisions_when_building = [
	Arsenal_typename,
	mobile_respawn,
	canisterFuel,
	"Box_B_UAV_06_medical_F",
	"gm_AmmoBox_wood_02_empty",
  	"gm_AmmoBox_wood_03_empty",
	"Land_CargoBox_V1_F",
	"B_HMG_01_F",
	"B_HMG_01_high_F",
	"B_GMG_01_F",
	"B_GMG_01_high_F",
	"B_static_AA_F",
	"B_static_AT_F",
	"B_Mortar_01_F",
	"CamoNet_BLUFOR_open_F",
	"CamoNet_BLUFOR_big_F",
	"Land_Flush_Light_red_F",
	"Land_Flush_Light_green_F",
	"Land_Flush_Light_yellow_F",
	"Land_runway_edgelight",
	"Land_runway_edgelight_blue_F",
	"Land_HelipadSquare_F",
	"Sign_Sphere100cm_F",
	"TMR_Autorest_Georef",
	"Land_ClutterCutter_large_F",
	"Land_HighVoltageColumn_F",
	"Land_HighVoltageColumnWire_F",
	"Land_PowerLine_01_pole_small_F",
	"Land_PowerLine_01_pole_tall_F",
	"Land_PowerLine_01_wire_50m_F",
	"Land_PowerLine_01_wire_50m_main_F"
];
GRLIB_sar_wreck = "Land_Wreck_Heli_Attack_01_F";
GRLIB_sar_fire = "test_EmptyObjectForFireBig";
GRLIB_Ammobox = [
	Arsenal_typename,
	A3W_BoxWps,
	"Box_B_UAV_06_medical_F",
	"gm_AmmoBox_wood_02_empty",
	"gm_AmmoBox_wood_03_empty",
	"mission_USLaunchers",
	"Land_CargoBox_V1_F"
];
GRLIB_AirDrop_1 = [
	"I_Quadbike_01_F",
	"I_G_Offroad_01_F",
	"I_G_Quadbike_01_F",
	"C_Offroad_01_F",
	"B_G_Offroad_01_F"
];
GRLIB_AirDrop_2 = [
	"I_G_Offroad_01_armed_F",
	"B_G_Offroad_01_armed_F"
	,"O_G_Offroad_01_armed_F",
	"I_C_Offroad_02_LMG_F"
];
GRLIB_AirDrop_3 = [
	"I_MRAP_03_hmg_F",
	"I_MRAP_03_hmg_F",
	"B_T_MRAP_01_hmg_F",
	"B_T_MRAP_01_gmg_F"
];
GRLIB_AirDrop_4 = [
	"B_Truck_01_transport_F",
	"B_Truck_01_covered_F",
	"I_Truck_02_covered_F",
	"I_Truck_02_transport_F"
];
GRLIB_AirDrop_5 = [
	"I_APC_tracked_03_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	"B_APC_Wheeled_01_cannon_F"
];
GRLIB_AirDrop_6 = [
	"C_Boat_Civil_01_F",
	"C_Boat_Transport_02_F",
	"B_Boat_Transport_01_F",
	"I_C_Boat_Transport_02_F"
];

GRLIB_player_grave = [
	"Land_Grave_rocks_F",
	"Land_Grave_forest_F",
	"Land_Grave_dirt_F"
];
