// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_color_friendly = "ColorBLUFOR";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "";
FOB_typename = "Land_Cargo_HQ_V1_F";
Respawn_truck_typename = "";  //"rhsusf_m113_usarmy_medical"
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "rhsusf_m113_usarmy_unarmed"; // B_Truck_01_box_F
commander_classname = "rhsusf_army_ucp_officer";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "rhsusf_army_ucp_helipilot";
crewman_classname = "rhsusf_army_ucp_crewman";
A3W_BoxWps = "rhs_weapon_crate";


/* 
RX permissions:
GRLIB_perm_inf
GRLIB_perm_log
GRLIB_perm_tank
GRLIB_perm_air
GRLIB_perm_max -> elite vehicles
*/


// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
	["rhsusf_socom_marsoc_sarc",0,25,0,GRLIB_perm_inf],
	["BWA3_Medic_Fleck",0,25,0,GRLIB_perm_inf],
	["rhs_msv_emr_medic",0,25,0,GRLIB_perm_inf]
];

units_loadout_overide = [];

light_vehicles = [
    ["B_Quadbike_01_F",0,40,0,GRLIB_perm_inf],
    ["rhs_uaz_open_MSV_01",0,60,0,GRLIB_perm_inf],
	
    ["UK3CB_BAF_LandRover_Soft_FFR_Arctic_A_Arctic",0,80,0,GRLIB_perm_inf],
    ["rhsusf_mrzr4_d",0,80,0,GRLIB_perm_inf],
    ["rhs_kamaz5350_open_msv",0,100,0,GRLIB_perm_inf],
    ["rhsusf_m1151_usmc_wd",0,110,0,GRLIB_perm_inf],
    ["BWA3_Eagle_Fleck",0,110,0,GRLIB_perm_inf],
    ["rhs_tigr_3camo_msv",0,120,0,GRLIB_perm_inf],
	
    ["rhsusf_m1151_m2_v3_usmc_wd",0,130,0,GRLIB_perm_inf],
    ["UK3CB_BAF_Husky_Passenger_HMG_Green_DPMW",0,140,0,GRLIB_perm_inf],
    ["UK3CB_BAF_Coyote_Passenger_L111A1_W_Arctic",0,150,0,GRLIB_perm_inf],
    ["UK3CB_BAF_Panther_GPMG_Green_A_DPMW",0,160,0,GRLIB_perm_inf],
    ["rhsusf_m966_w",0,170,0,GRLIB_perm_inf],
	
    ["rhsusf_M1237_M2_usarmy_wd",0,220,0,GRLIB_perm_inf],
    ["BWA3_Dingo2_FLW200_M2_Fleck",0,220,0,GRLIB_perm_inf],
	
    ["B_Boat_Transport_01_F",0,30,0,GRLIB_perm_inf],
    ["rhs_bmk_t",0,40,0,GRLIB_perm_inf],
    ["I_C_Boat_Transport_02_F",0,50,0,GRLIB_perm_inf],
    ["UK3CB_BAF_RHIB_HMG_MTP",0,50,0,GRLIB_perm_inf],
    ["B_Boat_Armed_01_minigun_F",0,50,0,GRLIB_perm_inf],
	["rhsusf_mkvsoc",0,60,0,GRLIB_perm_inf]
];

strong_light_vehicles = [];

heavy_vehicles = [
    ["rhs_btr80a_msv",0,300,0,GRLIB_perm_inf],
    ["rhsusf_m113_usarmy",0,300,0,GRLIB_perm_inf],
    ["UK3CB_BAF_FV432_Mk3_RWS_Green_DPMW",0,350,0,GRLIB_perm_inf],
    ["rhsusf_stryker_m1126_m2_wd",0,400,0,GRLIB_perm_inf],
	["rhsusf_stryker_m1134_wd",0,400,0,GRLIB_perm_inf],
    ["I_LT_01_cannon_F",0,350,0,GRLIB_perm_inf],
    ["I_LT_01_AT_F",0,350,0,GRLIB_perm_inf],
    ["I_LT_01_AA_F",0,350,0,GRLIB_perm_inf],
	
    ["rhs_bmp2d_msv",0,350,0,GRLIB_perm_inf],
    ["UK3CB_BAF_Warrior_A3_W_Cage_Camo_MTP",0,400,0,GRLIB_perm_inf],
    ["RHS_M2A3_wd",0,400,0,GRLIB_perm_inf],
    ["BWA3_Puma_Fleck",0,450,0,GRLIB_perm_inf],
    
    ["rhs_zsu234_aa",0,350,0,GRLIB_perm_inf],
    ["RHS_M6_wd",0,400,0,GRLIB_perm_inf],
	
    ["rhs_t90a_tv",0,600,0,GRLIB_perm_inf],
    ["BWA3_Leopard2_Fleck",0,600,0,GRLIB_perm_inf],
    ["rhsusf_m1a2sep1tuskiiwd_usarmy",0,600,0,GRLIB_perm_inf],
	
    ["RHS_M119_WD",0,650,0,GRLIB_perm_inf],
    ["rhs_D30_msv",0,650,0,GRLIB_perm_inf],
    ["rhsusf_m109_usarmy",0,750,0,GRLIB_perm_inf],
    ["BWA3_Panzerhaubitze2000_Fleck",0,750,0,GRLIB_perm_inf]
];

strong_heavy_vehicles = [];

air_vehicles = [
    ["RHS_MELB_MH6M",0,400,0,GRLIB_perm_inf],
    ["rhsusf_CH53e_USMC_cargo",0,550,0,GRLIB_perm_inf],
    ["rhs_ka60_grey",0,400,0,GRLIB_perm_inf],
    ["RHS_UH1Y_UNARMED",0,420,0,GRLIB_perm_inf],
    ["RHS_Mi8AMT_vvs",0,440,0,GRLIB_perm_inf],
	
    ["RHS_UH60M",0,480,0,GRLIB_perm_inf],
    ["UK3CB_BAF_Merlin_HC3_CSAR_DPMW_RM",0,500,0,GRLIB_perm_inf],
    ["RHS_CH_47F",0,550,0,GRLIB_perm_inf],
    ["RHS_C130J",0,550,0,GRLIB_perm_inf],
	
    ["RHS_MELB_AH6M",0,580,0,GRLIB_perm_inf],
    ["RHS_UH1Y",0,600,0,GRLIB_perm_inf],
    ["UK3CB_BAF_Wildcat_AH1_CAS_6C_DPMW_RM",0,630,0,GRLIB_perm_inf],
    ["RHS_Mi8MTV3_heavy_vvs",0,650,0,GRLIB_perm_inf],
    ["RHS_UH60M_ESSS",0,650,0,GRLIB_perm_inf],
	
	["vtx_UH60M_SLICK",5,400,15,GRLIB_perm_inf], // UH-60 Advanced
	["vtx_UH60M_MEDEVAC",5,400,15,GRLIB_perm_inf], // UH-60 Advanced
	["vtx_UH60M",10,500,20,GRLIB_perm_inf], // UH-60 Advanced
	["vtx_HH60",10,500,20,GRLIB_perm_inf], // UH-60 Advanced
	["vtx_MH60M",10,500,20,GRLIB_perm_inf], // UH-60 Advanced
	["vtx_MH60S",10,500,20,GRLIB_perm_inf], // UH-60 Advanced
	["vtx_MH60S_GAU21L",10,500,20,GRLIB_perm_inf], // UH-60 Advanced
	["vtx_MH60M_DAP",10,700,30,GRLIB_perm_inf], // UH-60 Advanced
	["vtx_MH60S_Pylons",10,700,30,GRLIB_perm_inf], // UH-60 Advanced
	
    ["rhsgref_mi24g_CAS",0,1000,0,GRLIB_perm_inf],
    ["BWA3_Tiger_RMK_Heavy",0,1000,0,GRLIB_perm_inf],
    ["RHS_AH1Z_wd",0,1000,0,GRLIB_perm_inf],
    ["RHS_AH64D_wd",0,1000,0,GRLIB_perm_inf],
    ["rhs_mi28n_vvs",0,1000,0,GRLIB_perm_inf],
    ["RHS_Ka52_vvs",0,1000,0,GRLIB_perm_inf],
	
    ["RHSGREF_A29B_HIDF",0,1500,0,GRLIB_perm_inf],
    ["rhsusf_f22",0,1500,0,GRLIB_perm_inf],
    ["rhs_mig29sm_vvsc",0,1500,0,GRLIB_perm_inf],
    ["I_Plane_Fighter_03_dynamicLoadout_F",0,1500,0,GRLIB_perm_inf],
	
    ["RHS_Su25SM_vvsc",0,1500,0,GRLIB_perm_inf],
    ["B_Plane_CAS_01_dynamicLoadout_F",0,1500,0,GRLIB_perm_inf],
    ["RHS_A10",0,1500,0,GRLIB_perm_inf],
	["Peral_A10C",25,1500,50,GRLIB_perm_inf] // A-10 Advanced
];

fast_air_vehicle = [];

blufor_air = [
	"RHS_AH1Z_wd",
	"RHS_A10",
	"rhsusf_f22",
	"B_Heli_Attack_01_F"
];

static_vehicles = [
	["RHS_M2StaticMG_MiniTripod_WD",0,0,0,GRLIB_perm_inf],
	["RHS_M2StaticMG_WD",0,0,0,GRLIB_perm_inf],
	["RHS_MK19_TriPod_WD",0,0,0,GRLIB_perm_inf],
	["RHS_TOW_TriPod_WD",0,0,0,GRLIB_perm_inf],
	["RHS_Stinger_AA_pod_WD",0,0,0,GRLIB_perm_inf],
    ["BWA3_MRS120_Fleck",0,40,0,GRLIB_perm_inf]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
  // Quadbike
    ["B_Quadbike_01_F",0,10,0,GRLIB_perm_inf],
	
  // Bundeswehr
    ["rnt_lkw_10t_mil_gl_kat_i_repair_fleck",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["rnt_lkw_5t_mil_gl_kat_i_fuel_fleck",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["rnt_lkw_7t_mil_gl_kat_i_mun_fleck",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["BWA3_Multi_Fleck",0,logistic_ground_vehicle_price_tier_2,0,GRLIB_perm_inf],
	
  // Vanilla
    ["B_Truck_01_Ammo_F",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Truck_01_flatbed_F",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Truck_01_fuel_F",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Truck_01_Repair_F",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Truck_01_box_F",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["B_T_UGV_01_olive_F",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["B_T_UGV_01_rcws_olive_F",0,heavy_vehicle_price_tier_9 ,0,GRLIB_perm_inf],
    
    //RHS USAF
    ["rhsusf_M1078A1R_SOV_M2_D_fmtv_socom",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1084A1R_SOV_M2_D_fmtv_socom",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1078A1P2_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1078A1P2_WD_flatbed_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1078A1P2_B_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1078A1P2_B_M2_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1078A1P2_B_M2_WD_flatbed_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1083A1P2_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1083A1P2_WD_flatbed_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1083A1P2_B_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1083A1P2_B_WD_flatbed_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1083A1P2_B_M2_WD_flatbed_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1084A1P2_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1084A1P2_B_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M1084A1P2_B_M2_WD_fmtv_usarmy",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M977A4_AMMO_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M977A4_REPAIR_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M977A4_BKIT_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M977A4_AMMO_BKIT_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M977A4_BKIT_M2_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M977A4_REPAIR_BKIT_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M978A4_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["rhsusf_M978A4_BKIT_usarmy_wd",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf]
];


support_crates = [
// support_crates
  // Ersatzteile
    ["ACE_Track",0,0,0,GRLIB_perm_inf],
    ["ACE_Wheel",0,0,0,GRLIB_perm_inf],
	// Kisten
    ["Box_NATO_Equip_F",0,0,0,GRLIB_perm_inf],
    ["B_CargoNet_01_ammo_F",0,0,0,GRLIB_perm_inf],
    ["CargoNet_01_box_F",0,0,0,GRLIB_perm_inf],
    ["CargoNet_01_barrels_F",0,0,0,GRLIB_perm_inf],
  // Waffen
   // ["SNC_Javelin",0,400,0,GRLIB_perm_inf],
  // Kistenfüller & Container
    ["Land_RepairDepot_01_green_F",0,0,0,GRLIB_perm_inf],
  // Bundeswehr	Fleck
    ["BWA3_WLP14_Ammo_Fleck",0,0,0,GRLIB_perm_inf],
    ["BWA3_WLP14_Flatbed_Oliv",0,0,0,GRLIB_perm_inf],
    ["BWA3_TCK9_Fuel_Fleck",0,0,0,GRLIB_perm_inf],
    ["BWA3_WLP14_Repair_Fleck",0,0,0,GRLIB_perm_inf],
  // Bundeswehr Tropen
    ["BWA3_WLP14_Ammo_Tropen",0,0,0,GRLIB_perm_inf],
    ["BWA3_WLP14_Flatbed_Tropen",0,0,0,GRLIB_perm_inf],
    ["BWA3_TCK9_Fuel_Tropen",0,0,0,GRLIB_perm_inf],
    ["BWA3_WLP14_Repair_Tropen",0,0,0,GRLIB_perm_inf],
  // Bundeswehr	Winter
    ["BWA3_WLP14_Ammo_Winter",0,0,0,GRLIB_perm_inf],
    ["BWA3_WLP14_Flatbed_Winter",0,0,0,GRLIB_perm_inf],
    ["BWA3_TCK9_Fuel_Winter",0,0,0,GRLIB_perm_inf],
    ["BWA3_WLP14_Repair_Winter",0,0,0,GRLIB_perm_inf],
  // USAF Container
    ["USAF_SlingLoad_Ammo",0,0,0,GRLIB_perm_inf],
    ["USAF_SlingLoad_Repair",0,0,0,GRLIB_perm_inf],
    ["USAF_SlingLoad_Fuel",0,0,0,GRLIB_perm_inf],
  // Huron Container
    [ammo_sling_typename,0,0,0,GRLIB_perm_inf],
    [repair_sling_typename,0,0,0,GRLIB_perm_inf],
    [fuel_sling_typename,0,0,0,GRLIB_perm_inf],
    [medic_sling_typename,0,0,0,GRLIB_perm_inf],
  // BAF Container
    ["UK3CB_BAF_MAN_HX60_Container_Blue",0,0,0,GRLIB_perm_inf],     //Cargo
    ["UK3CB_BAF_MAN_HX60_Container_Green",0,0,0,GRLIB_perm_inf],    //Cargo
    ["UK3CB_BAF_MAN_HX60_Container_ReArm",0,0,0,GRLIB_perm_inf],    //Cargo
    ["UK3CB_BAF_MAN_HX60_Container_Sand",0,0,0,GRLIB_perm_inf],     //Cargo
    ["UK3CB_BAF_MAN_HX60_Container_Logistics_Green",0,0,0,GRLIB_perm_inf],
    ["UK3CB_BAF_MAN_HX60_Container_Logistics_Sand",0,0,0,GRLIB_perm_inf],
    ["UK3CB_BAF_MAN_HX60_Container_Servicing_Ground_Green",0,0,0,GRLIB_perm_inf],
    ["UK3CB_BAF_MAN_HX60_Container_Servicing_Ground_Sand",0,0,0,GRLIB_perm_inf],
    ["UK3CB_BAF_MAN_HX60_Container_Servicing_Air_Green",0,0,0,GRLIB_perm_inf],
    ["UK3CB_BAF_MAN_HX60_Container_Servicing_Air_Sand",0,0,0,GRLIB_perm_inf],
    ["UK3CB_BAF_MAN_HX58_Container_Blue",0,0,0,GRLIB_perm_inf],     //Cargo
    ["UK3CB_BAF_MAN_HX58_Container_Green",0,0,0,GRLIB_perm_inf],    //Cargo
    ["UK3CB_BAF_MAN_HX58_Container_ReArm",0,0,0,GRLIB_perm_inf],    //Cargo
    ["UK3CB_BAF_MAN_HX58_Container_Sand",0,0,0,GRLIB_perm_inf],     //Cargo
  // BAF Station
    ["UK3CB_BAF_Vehicles_Logistics_Point",0,0,0,GRLIB_perm_inf],
    ["UK3CB_BAF_Vehicles_Servicing_Aircraft_Point",0,0,0,GRLIB_perm_inf],
    ["UK3CB_BAF_Vehicles_Servicing_Ground_Point",0,0,0,GRLIB_perm_inf],
  // FOB
    [FOB_box_typename,0,15000,0,GRLIB_perm_inf],
    [FOB_truck_typename,0,15000,0,GRLIB_perm_inf]
];

buildings_west = [
    ["Land_HBarrier_01_wall_6_green_F",0,0,0,GRLIB_perm_inf],
    ["Land_HBarrier_01_line_3_green_F",0,0,0,GRLIB_perm_inf],
    ["Land_HBarrierWall6_F",0,0,0,GRLIB_perm_inf],
    ["Land_HBarrier_3_F",0,0,0,GRLIB_perm_inf],
    ["Flag_UNO_F",0,0,0,GRLIB_perm_inf],
    ["Flag_NATO_F",0,0,0,GRLIB_perm_inf],
	["BWA3_Flag_Germany",0,0,0,GRLIB_perm_inf],
    ["rhs_Flag_Russia_F",0,0,0,GRLIB_perm_inf],
    ["Flag_UK_F",0,0,0,GRLIB_perm_inf],
    ["Flag_US_F",0,0,0,GRLIB_perm_inf],
    ["Land_PortableLight_single_F",0,0,0,GRLIB_perm_inf],
    ["Land_Campfire_F",0,0,0,GRLIB_perm_inf],
    ["Land_CampingChair_V1_F",0,0,0,GRLIB_perm_inf],
    ["Land_CampingTable_F",0,0,0,GRLIB_perm_inf],
    ["Land_fort_bagfence_long",0,0,0,GRLIB_perm_inf],
    ["PortableHelipadLight_01_blue_F",0,0,0,GRLIB_perm_inf],
    ["PortableHelipadLight_01_green_F",0,0,0,GRLIB_perm_inf],
    ["Land_ClutterCutter_large_F",0,0,0,GRLIB_perm_inf]
];


if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };

/*
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"rhsusf_army_ucp_arb_maaws",
	"rhsusf_army_ucp_arb_autorifleman",
    "rhsusf_army_ucp_arb_marksman"
	];
};

if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
	"rhsusf_army_ucp_arb_maaws",
	"rhsusf_army_ucp_arb_autorifleman",
    "rhsusf_army_ucp_arb_marksman"
	];
};

if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	"rhsusf_army_ucp_arb_maaws",
	"rhsusf_army_ucp_arb_maaws",
    "rhsusf_army_ocp_javelin"
	];
};

if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa"
	];
};

if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"rhsusf_army_ucp_arb_maaws",
	"rhsusf_army_ucp_arb_autorifleman",
    "rhsusf_army_ucp_arb_marksman"
	];
};
*/

squads = [
	[blufor_squad_inf_light,0,0,0,GRLIB_perm_inf],
	[blufor_squad_inf,0,0,0,GRLIB_perm_inf],
	[blufor_squad_at,0,0,0,GRLIB_perm_inf],
	[blufor_squad_aa,0,0,0,GRLIB_perm_inf],
	[blufor_squad_mix,0,0,0,GRLIB_perm_inf]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "UK3CB_BAF_Vehicles_Logistics_Point"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy",
	"B_Slingload_01_Medevac_F"
];

vehicle_rearm_sources_west = [
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [
];

box_transport_config_west = [
	[ "rhsusf_M1078A1P2_B_WD_flatbed_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M1084A1P2_B_WD_fmtv_usarmy", -6.5, [0,-0.2,0.6], [0,-1.8,0.6] ],
	[ "rhsusf_M977A4_usarmy_wd", -6.5, [0,0.5,1.5], [0,-0.9,1.5], [0,-2.4,1.5], [0,-3.8,1.5] ],
	[ "RHS_CH_47F", -7.5, [0,2,-1.8], [0,0.6,-1.8], [0,-1.2,-1.8], [0,-2.6,-1.8] ]
];
