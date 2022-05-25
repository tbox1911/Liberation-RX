// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_color_friendly = "ColorBLUFOR";
 
// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf
 
huron_typename = "CUP_B_CH47F_USA";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "CUP_B_M113A3_HQ_GER";
Respawn_truck_typename = "CUP_B_nM997_USMC_WDL";
ammo_truck_typename = "CUP_B_MTVR_Ammo_USMC";
fuel_truck_typename = "CUP_B_MTVR_Refuel_USMC";
repair_truck_typename = "CUP_B_MTVR_Repair_USMC";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "CUP_B_USMC_Pilot";
crewman_classname = "CUP_B_USMC_Crew";
A3W_BoxWps = "CUP_LocalBasicWeaponsBox";
 
// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
    ["CUP_B_GER_Operator_Medic",0,ai_value,0,GRLIB_perm_inf]
];
 
units_loadout_overide = [
    "CUP_B_USMC_Soldier_AT",
    "CUP_B_USMC_Soldier_AA",
    "CUP_B_USMC_Soldier_HAT"
];  

light_vehicles = [
	
   	
   // Bike
    ["CUP_B_M1030_USMC",0,20,0,GRLIB_perm_inf],
  // Vanilla
    ["C_Offroad_02_unarmed_F",0,light_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["C_Van_01_transport_F",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf],
  // CUP
    ["CUP_I_SUV_ION",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_I_SUV_Armored_ION",0,light_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["CUP_B_nM1025_Unarmed_USA_DES",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_nM1038_USA_DES",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_nM1038_4s_USA_DES",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_nM997_USA_DES",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_nM1037sc_USA_DES",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_nM1025_SOV_M2_USA_DES",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["CUP_B_nM1025_SOV_Mk19_USA_DES",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["CUP_B_nM1025_M240_USA_DES",0,light_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["CUP_B_nM1025_M2_USA_DES",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["CUP_B_nM1025_Mk19_USA_DES",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["CUP_B_nM1036_TOW_USA_DES",0,light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["CUP_B_nM1097_AVENGER_USA_DES",0,light_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["CUP_B_MTVR_BAF_DES",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
  // BAF
    ["CUP_B_LR_Transport_GB_D",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_LR_Ambulance_GB_D",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_LR_MG_GB_D",0,light_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["CUP_B_LR_Special_M2_GB_D",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["CUP_B_LR_Special_GMG_GB_D",0,light_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["CUP_I_LR_AA_AAF",0,light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["CUP_B_Jackal2_L2A1_GB_W",0,light_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["CUP_B_Jackal2_GMG_GB_W",0,light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["CUP_B_BAF_Coyote_L2A1_W",0,light_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["CUP_B_BAF_Coyote_GMG_W",0,light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["CUP_B_T810_Unarmed_CZ_WDL",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_T810_Armed_CZ_WDL",0,light_vehicle_price_tier_4,0,GRLIB_perm_inf],
  // FFAA
    ["ffaa_et_anibal",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["ffaa_et_neton_mk2",0,light_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_trans",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_et_lince_ambulancia",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_et_lince_mg3",0,light_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["ffaa_et_lince_m2",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["ffaa_et_lince_lag40",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["ffaa_et_pegaso_carga",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_et_pegaso_carga_lona",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_et_m250_carga_blin",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["ffaa_et_m250_carga_lona_blin",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
  // BW
    ["BWA3_Eagle_Fleck",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["BWA3_Eagle_FLW100_Fleck",0,light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_San",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_FJg",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_Moerser",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["rnt_lkw_5t_mil_gl_kat_i_transport_fleck",0,light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    // Vanilla Truck
    ["B_Truck_01_transport_F",0,light_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["B_Truck_01_covered_F",0,light_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["B_Truck_01_medical_F",0,light_vehicle_price_tier_4,0,GRLIB_perm_inf],
// Boats
  // CUP
    ["CUP_B_LCU1600_USMC",0,light_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["CUP_B_RHIB_USMC",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["CUP_B_RHIB2Turret_USMC",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf],
  // Vanilla Boat
    ["C_Scooter_Transport_01_F",0,15,0,GRLIB_perm_inf],
    ["B_SDV_01_F",0,light_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Boat_Transport_01_F",0,light_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Lifeboat",0,light_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Boat_Armed_01_minigun_F",0,light_vehicle_price_tier_10,0,GRLIB_perm_inf],
  // FFAA
    ["ffaa_ar_zodiac_hurricane",0,light_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["ffaa_ar_lcm",0,light_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["ffaa_ar_zodiac_hurricane_long",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["ffaa_ar_supercat",0,light_vehicle_price_tier_2,0,GRLIB_perm_inf]

];

strong_light_vehicles = [

// CUP
    ["CUP_B_M1151_USA",0,strong_light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["CUP_B_M1152_USA",0,strong_light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["CUP_B_M1151_M2_USA",0,strong_light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_M1151_Mk19_USA",0,strong_light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_M1165_GMV_USA",0,strong_light_vehicle_price_tier_6,225,0,GRLIB_perm_inf],
    ["CUP_B_M1167_USA",0,150,0,GRLIB_perm_inf],
    ["CUP_B_HMMWV_Crows_M2_USA",0,strong_light_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["CUP_B_HMMWV_Crows_MK19_USA",0,strong_light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["CUP_B_RG31E_M2_USA",0,strong_light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["CUP_B_RG31_Mk19_USA",0,strong_light_vehicle_price_tier_8,0,GRLIB_perm_inf],
  // BAF
    ["CUP_B_Ridgback_LMG_GB_D",0,strong_light_vehicle_price_tier_8,0,GRLIB_perm_inf],
    ["CUP_B_Ridgback_HMG_GB_D",0,strong_light_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["CUP_B_Ridgback_GMG_GB_D",0,strong_light_vehicle_price_tier_10,0,GRLIB_perm_inf],
    ["CUP_B_Mastiff_LMG_GB_D",0,strong_light_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["CUP_B_Mastiff_HMG_GB_D",0,strong_light_vehicle_price_tier_10,0,GRLIB_perm_inf],
    ["CUP_B_Mastiff_GMG_GB_D",0,strong_light_vehicle_price_tier_11,0,GRLIB_perm_inf],
    ["CUP_B_Wolfhound_LMG_GB_D",0,strong_light_vehicle_price_tier_8,0,GRLIB_perm_inf],
    ["CUP_B_Wolfhound_HMG_GB_D",0,strong_light_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["CUP_B_Wolfhound_GMG_GB_D",0,strong_light_vehicle_price_tier_10,0,GRLIB_perm_inf],
  // FFAA
    ["ffaa_et_vamtac_trans_blind",0,strong_light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_ume",0,strong_light_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_m2",0,strong_light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_lag40",0,strong_light_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_tow",0,strong_light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_mistral",0,strong_light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_crows",0,strong_light_vehicle_price_tier_8,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_cardom",0,strong_light_vehicle_price_tier_15,0,GRLIB_perm_inf],
    ["ffaa_ar_vamtac_st5_vsp_m2",0,strong_light_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_ar_vamtac_st5_vsp_lag40",0,strong_light_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["ffaa_et_vamtac_st5_spike",0,strong_light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["ffaa_et_rg31_samson",0,strong_light_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["ffaa_et_rg31_rollers",0,strong_light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["ffaa_et_husky2g_detector",0,strong_light_vehicle_price_tier_1,0,GRLIB_perm_inf],
  // BW
    ["BWA3_Dingo2_FLW100_MG3_CG13_Fleck",0,strong_light_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["BWA3_Dingo2_FLW200_M2_CG13_Fleck",0,strong_light_vehicle_price_tier_8,0,GRLIB_perm_inf],
    ["BWA3_Dingo2_FLW200_GMW_CG13_Fleck",0,strong_light_vehicle_price_tier_9,0,GRLIB_perm_inf],
  // Vanilla
    ["I_MRAP_03_F",0,strong_light_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["B_MRAP_01_F",0,strong_light_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["B_MRAP_01_HMG_F",0,strong_light_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["B_MRAP_01_GMG_F",0,strong_light_vehicle_price_tier_7,0,GRLIB_perm_inf]

];

 
heavy_vehicles = [
	// BAF
    ["CUP_B_FV432_GB_Ambulance",0,heavy_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["CUP_B_FV432_GB_GPMG",0,heavy_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_FV432_Mortar",0,heavy_vehicle_price_tier_11,0,GRLIB_perm_inf],
    ["CUP_B_FV432_Bulldog_GB_W",0,heavy_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["CUP_B_FV432_Bulldog_GB_W_RWS",0,heavy_vehicle_price_tier_8,0,GRLIB_perm_inf],
    ["CUP_B_FV510_GB_W",0,heavy_vehicle_price_tier_14,0,GRLIB_perm_inf],
    ["CUP_B_FV510_GB_W_SLAT",0,heavy_vehicle_price_tier_15,0,GRLIB_perm_inf],
    ["CUP_B_MCV80_GB_W",0,heavy_vehicle_price_tier_14,0,GRLIB_perm_inf],
    ["CUP_B_MCV80_GB_W_SLAT",0,heavy_vehicle_price_tier_15,0,GRLIB_perm_inf],
  // CUP
    ["CUP_B_M1133_MEV_Desert",0,heavy_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["CUP_B_M1126_ICV_M2_Desert",0,heavy_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["CUP_B_M1126_ICV_MK19_Desert",0,heavy_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_M1135_ATGMV_Desert",0,heavy_vehicle_price_tier_12,0,GRLIB_perm_inf],
    ["CUP_B_M1128_MGS_Desert",0,heavy_vehicle_price_tier_12,0,GRLIB_perm_inf],
    ["CUP_B_M6LineBacker_USA_D",0,heavy_vehicle_price_tier_13,0,GRLIB_perm_inf],
    ["CUP_B_M7Bradley_USA_D",0,heavy_vehicle_price_tier_14,0,GRLIB_perm_inf],
    ["CUP_B_M2A3Bradley_USA_D",0,heavy_vehicle_price_tier_15,0,GRLIB_perm_inf],
  // BW CUP
    ["CUP_B_Boxer_HMG_GER_WDL",0,heavy_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["CUP_B_Boxer_GMG_GER_WDL",0,heavy_vehicle_price_tier_3,0,GRLIB_perm_inf],
  // BW
    ["Redd_Tank_Fuchs_1A4_San_Tropentarn",0,heavy_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["Redd_Tank_Fuchs_1A4_Jg_Tropentarn",0,heavy_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn",0,heavy_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["rnt_sppz_2a2_luchs_tropentarn",0,heavy_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["Redd_Marder_1A5_Tropentarn",0,heavy_vehicle_price_tier_14,0,GRLIB_perm_inf],
    ["BWA3_Puma_Fleck",0,heavy_vehicle_price_tier_15,0,GRLIB_perm_inf],
    ["Redd_Tank_Wiesel_1A2_TOW_Tropentarn",0,heavy_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["Redd_Tank_Wiesel_1A4_MK20_Tropentarn",0,heavy_vehicle_price_tier_11,0,GRLIB_perm_inf],
  // Vanilla
    ["I_LT_01_scout_F",0,heavy_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["I_LT_01_AA_F",0,heavy_vehicle_price_tier_8,0,GRLIB_perm_inf],
    ["I_LT_01_AT_F",0,heavy_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["I_LT_01_cannon_F",0,heavy_vehicle_price_tier_10,0,GRLIB_perm_inf],
    ["I_APC_Wheeled_03_cannon_F",0,heavy_vehicle_price_tier_14,0,GRLIB_perm_inf],
    ["B_AFV_Wheeled_01_cannon_F",0,heavy_vehicle_price_tier_16,0,GRLIB_perm_inf],
    ["B_AFV_Wheeled_01_up_cannon_F",0,heavy_vehicle_price_tier_17,0,GRLIB_perm_inf],
  // Spain
    ["ffaa_et_toa_ambulancia",0,heavy_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_et_toa_mando",0,heavy_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_et_toa_m2",0,heavy_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["ffaa_et_toa_zapador",0,heavy_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["ffaa_et_toa_spike",0,heavy_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["ffaa_ar_piranhaIIIC",0,heavy_vehicle_price_tier_13,0,GRLIB_perm_inf],
    ["ffaa_ar_piranhaIIIC_lance",0,heavy_vehicle_price_tier_15,0,GRLIB_perm_inf],
    ["ffaa_et_pizarro_mauser",0,heavy_vehicle_price_tier_16,0,GRLIB_perm_inf]
   
];

strong_heavy_vehicles = [

    // CUP
    ["CUP_B_M60A3_USMC",0,strong_heavy_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["CUP_B_M60A3_TTS_USMC",0,strong_heavy_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["CUP_B_M1A2C_Desert_US_Army",0,strong_heavy_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["CUP_B_M1A2C_TUSK_Desert_US_Army",0,strong_heavy_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_M1A2C_TUSK_II_Desert_US_Army",0,strong_heavy_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["CUP_B_Challenger2_Desert_BAF",0,strong_heavy_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["CUP_B_Leopard2A6DST_GER",0,strong_heavy_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["CUP_B_M270_HE_USMC",0,strong_heavy_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["CUP_B_RM70_CZ",0,strong_heavy_vehicle_price_tier_7,0,GRLIB_perm_inf],
  // BW
    ["Redd_Tank_Gepard_1A2_Flecktarn",0,strong_heavy_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["BWA3_Panzerhaubitze2000_Fleck",0,strong_heavy_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["BWA3_Leopard2_Fleck",0,strong_heavy_vehicle_price_tier_5,0,GRLIB_perm_inf],
  // Spain
    ["ffaa_et_leopardo",0,strong_heavy_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["ffaa_ar_m109",0,strong_heavy_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["ffaa_et_m109",0,strong_heavy_vehicle_price_tier_5,0,GRLIB_perm_inf],
  // Vanilla
    ["B_APC_Tracked_01_AA_F",0,strong_heavy_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_MBT_01_cannon_F",0,strong_heavy_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["B_MBT_01_TUSK_F",0,strong_heavy_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["I_MBT_03_cannon_F",0,strong_heavy_vehicle_price_tier_5,0,GRLIB_perm_inf]
	
    
];


 
air_vehicles = [


// Light Transport
    // FFAA
      ["ffaa_famet_ec135",0,air_vehicle_price_tier_1,0,GRLIB_perm_inf],
    // CUP
      ["CUP_B_MH6J_USA",0,air_vehicle_price_tier_1,0,GRLIB_perm_inf],
      ["CUP_B_MH6M_USA",0,air_vehicle_price_tier_2,0,GRLIB_perm_inf],
      ["CUP_B_AH6M_USA",0,air_vehicle_price_tier_8,0,GRLIB_perm_inf],
    //["CUP_B_UH1D_GER_KSK",0,air_vehicle_price_tier_5,0,GRLIB_perm_inf], //verursacht script fehler
    //["CUP_B_UH1D_gunship_GER_KSK",0,air_vehicle_price_tier_10,0,GRLIB_perm_inf], //verursacht script fehler

  // Medium Transport
    // CUP
      ["CUP_B_UH60M_Unarmed_FFV_MEV_US",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf],
      ["CUP_B_UH60M_Unarmed_US",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf],
      ["CUP_B_UH60M_Unarmed_FFV_US",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf],
      ["CUP_B_UH60M_Unarmed_FFV_MEV_US",0,air_vehicle_price_tier_6,0,GRLIB_perm_inf],
      ["CUP_B_UH60S_USN",0,air_vehicle_price_tier_6,0,GRLIB_perm_inf],
      ["CUP_B_UH60M_US",0,air_vehicle_price_tier_7,0,GRLIB_perm_inf],                                         //Seahawk
      ["CUP_B_UH60M_FFV_US",0,air_vehicle_price_tier_7,0,GRLIB_perm_inf],
      ["CUP_B_MH60L_DAP_2x_USN",0,air_vehicle_price_tier_8,0,GRLIB_perm_inf],                                 //Knighthawk
      ["CUP_B_MH60L_DAP_2x_US",0,air_vehicle_price_tier_8,0,GRLIB_perm_inf],
      ["CUP_B_MH60L_DAP_4x_USN",0,air_vehicle_price_tier_10,0,GRLIB_perm_inf],                                //Knighthawk
      ["CUP_B_UH60S_USN",0,air_vehicle_price_tier_6,0,GRLIB_perm_inf],                                        //Seahawk
      ["B_Heli_Transport_01_F",0,air_vehicle_price_tier_6,0,GRLIB_perm_inf],
      ["CUP_B_UH1Y_MEV_USMC",0,air_vehicle_price_tier_3,0,GRLIB_perm_inf],
      ["CUP_B_UH1Y_UNA_USMC",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf],
      ["CUP_B_UH1Y_Gunship_Dynamic_USMC",0,air_vehicle_price_tier_8,0,GRLIB_perm_inf],
      ["CUP_I_412_Military_Radar_PMC",0,air_vehicle_price_tier_3,0,GRLIB_perm_inf],
      ["CUP_I_412_Military_Armed_AT_PMC",0,air_vehicle_price_tier_7,0,GRLIB_perm_inf],
      ["CUP_I_Ka60_GL_Blk_ION",0,air_vehicle_price_tier_5,0,GRLIB_perm_inf],
      ["CUP_B_AW159_Unarmed_GER",0,air_vehicle_price_tier_3,0,GRLIB_perm_inf],
      ["CUP_B_AW159_GERdd",0,air_vehicle_price_tier_7,0,GRLIB_perm_inf],

    // FFAA
      ["ffaa_famet_cougar",0,air_vehicle_price_tier_3,0,GRLIB_perm_inf],
      ["ffaa_nh90_tth_armed",0,air_vehicle_price_tier_5,0,GRLIB_perm_inf],                                 //NH-90
      ["ffaa_nh90_tth_cargo",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf],
      ["ffaa_nh90_tth_transport",0,air_vehicle_price_tier_3,0,GRLIB_perm_inf],
      ["ffaa_nh90_nfh_transport",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf],

  // Heavy Transport
    //CUP
      ["CUP_B_MH47E_USA",0,air_vehicle_price_tier_5,0,GRLIB_perm_inf],
      ["CUP_B_CH47F_USA",0,air_vehicle_price_tier_6,0,GRLIB_perm_inf],
      ["CUP_B_CH47F_VIV_USA",0,air_vehicle_price_tier_6,0,GRLIB_perm_inf],
      ["CUP_B_CH53E_GER",0,air_vehicle_price_tier_7,0,GRLIB_perm_inf],
      ["CUP_B_CH53E_VIV_GER",0,air_vehicle_price_tier_7,0,GRLIB_perm_inf],

    //BAF
      ["CUP_B_Merlin_HC3A_GB",0,air_vehicle_price_tier_8,0,GRLIB_perm_inf],
      ["CUP_B_Merlin_HC3_VIV_GB",0,air_vehicle_price_tier_8,0,GRLIB_perm_inf],
      ["CUP_B_Merlin_HC3A_Armed_GB",0,air_vehicle_price_tier_8,0,GRLIB_perm_inf],

  // Attack helicopter
    // CUP
    ["CUP_B_AH1Z_Dynamic_USMC",0,air_vehicle_price_tier_11,0,GRLIB_perm_inf],
    ["CUP_B_AH64_DL_USA",0,air_vehicle_price_tier_11,0,GRLIB_perm_inf],
    ["CUP_I_Mi24_MK4_ION",0,air_vehicle_price_tier_12,0,GRLIB_perm_inf],
    ["CUP_B_AH64D_DL_USA",0,air_vehicle_price_tier_14,0,GRLIB_perm_inf],

    // BAF
    ["CUP_B_AH1_DL_BAF",0,air_vehicle_price_tier_12,0,GRLIB_perm_inf],
    
    // BW
    ["BWA3_Tiger_Gunpod_FZ",0,air_vehicle_price_tier_10,0,GRLIB_perm_inf],
    ["BWA3_Tiger_Gunpod_PARS",0,air_vehicle_price_tier_10,0,GRLIB_perm_inf],
    ["BWA3_Tiger_Gunpod_Heavy",0,air_vehicle_price_tier_10,0,GRLIB_perm_inf],
    ["BWA3_Tiger_RMK_FZ",0,air_vehicle_price_tier_13,0,GRLIB_perm_inf],
    ["BWA3_Tiger_RMK_PARS",0,air_vehicle_price_tier_13,0,GRLIB_perm_inf],
    ["BWA3_Tiger_RMK_Heavy",0,air_vehicle_price_tier_13,0,GRLIB_perm_inf],
    ["BWA3_Tiger_RMK_Universal",0,air_vehicle_price_tier_14,0,GRLIB_perm_inf],

    // FFAA
    ["ffaa_famet_tigre",0,air_vehicle_price_tier_14,0,GRLIB_perm_inf],

  // VTOL
    // CUP
    ["CUP_B_MV22_USMC",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf], // Osprey
    ["CUP_B_MV22_VIV_USMC",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf], // Osprey
    ["CUP_B_MV22_USMC_RAMPGUN",0,air_vehicle_price_tier_4,0,GRLIB_perm_inf], // Osprey

    // Vanilla
    ["B_T_VTOL_01_infantry_F",0,air_vehicle_price_tier_5,0,GRLIB_perm_inf],  //Blackfish
    ["B_T_VTOL_01_vehicle_F",0,air_vehicle_price_tier_5,0,GRLIB_perm_inf],   //Blackfish
    ["B_W_VTOL_01_armed_F",0,air_vehicle_price_tier_15,0,GRLIB_perm_inf]     //Blackfish


   

];

fast_air_vehicle = [


  // Cargo
    // USAF
    ["USAF_C130J_Cargo",0,fast_air_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["USAF_C130J",0,fast_air_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["USAF_C17",0,fast_air_vehicle_price_tier_1,0,GRLIB_perm_inf],

  // Jets
    // CUP
    ["CUP_B_A10_DYN_USA",0,fast_air_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["CUP_B_AV8B_DYN_USMC",0,fast_air_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["CUP_B_F35B_USMC",0,fast_air_vehicle_price_tier_5,0,GRLIB_perm_inf],

    // BAF
    ["CUP_B_GR9_DYN_GB", 0, fast_air_vehicle_price_tier_4, 0, GRLIB_perm_inf],
    ["CUP_B_F35B_BAF", 0, fast_air_vehicle_price_tier_4, 0, GRLIB_perm_inf],
    ["CUP_B_F35B_Stealth_BAF", 0, fast_air_vehicle_price_tier_4, 0, GRLIB_perm_inf],

    // FFAA
    ["ffaa_ar_harrier",0,fast_air_vehicle_price_tier_7,0,GRLIB_perm_inf],
    ["ffaa_ea_ef18m",0,fast_air_vehicle_price_tier_8,0,GRLIB_perm_inf],

    // USAF
    ["USAF_A10",0,1500,0,GRLIB_perm_inf],
    ["USAF_F22",0,fast_air_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["USAF_F22_EWP_AA",0,fast_air_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["USAF_F22_EWP_AG",0,fast_air_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["USAF_F22_Heavy",0,fast_air_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["USAF_F35A_STEALTH",0,fast_air_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["USAF_F35A_LIGHT",0,fast_air_vehicle_price_tier_4,0,GRLIB_perm_inf],
    ["USAF_F35A",0,fast_air_vehicle_price_tier_5,0,GRLIB_perm_inf], //Heavy

    // F-18 super hornet
    ["JS_JC_FA18F",0,fast_air_vehicle_price_tier_9,0,GRLIB_perm_inf],
    ["JS_JC_FA18E",0,fast_air_vehicle_price_tier_6,0,GRLIB_perm_inf],

    // Eurofighter
    ["EAWS_EF2000_GER_CAP",0,fast_air_vehicle_price_tier_6,0,GRLIB_perm_inf],

    // Vanilla
    ["I_Plane_Fighter_04_F",0,fast_air_vehicle_price_tier_5,0,GRLIB_perm_inf],
    ["B_Plane_Fighter_01_F",0,fast_air_vehicle_price_tier_6,0,GRLIB_perm_inf],
    ["B_Plane_Fighter_01_Stealth_F",0,fast_air_vehicle_price_tier_8,0,GRLIB_perm_inf],

  // UAVs
    //USAF
    ["USAF_RQ4A",0,fast_air_vehicle_price_tier_1,0,GRLIB_perm_inf],     //Global hawk
    ["USAF_MQ9",0,fast_air_vehicle_price_tier_3,0,GRLIB_perm_inf],  //Reaper

    // CUP
    ["CUP_B_USMC_DYN_MQ9",0,fast_air_vehicle_price_tier_4,0,GRLIB_perm_inf],    // Reaper

    // FFAA
    ["ffaa_ea_reaper",0,fast_air_vehicle_price_tier_6,0,GRLIB_perm_inf],    // Reaper

    // Vanilla
    ["B_UAV_05_F",0,fast_air_vehicle_price_tier_5,0,GRLIB_perm_inf]     //Sentinel


 
  

];

 
blufor_air = [
    "CUP_B_UH60S_USN",
    "CUP_B_AH64D_DL_USA",
    "CUP_B_A10_DYN_USA",
    "CUP_B_F35B_USMC"
];
 
boats_west = [
    "CUP_B_RHIB2Turret_USMC",
    "CUP_B_RHIB_USMC",
    "CUP_B_LCU1600_USMC",
    "CUP_B_Zodiac_USMC"
   
];
 
static_vehicles = [
 // Light
    // BW
    ["rnt_gmw_static_ai",0,0,0,GRLIB_perm_inf],
    ["Redd_Milan_Static",0,0,0,GRLIB_perm_inf],
    ["rnt_mg3_static_ai",0,0,0,GRLIB_perm_inf],

    // CUP
    ["CUP_B_SearchLight_static_USMC",0,0,0,GRLIB_perm_inf],
    ["CUP_B_M2StaticMG_USMC",0,0,0,GRLIB_perm_inf],
    ["CUP_B_M2StaticMG_MiniTripod_USMC",0,0,0,GRLIB_perm_inf],
    ["CUP_B_MK19_TriPod_USMC",0,0,0,GRLIB_perm_inf],
    ["CUP_B_TOW_TriPod_USMC",0,0,0,GRLIB_perm_inf],
    ["CUP_B_M252_USMC",0,0,0,GRLIB_perm_inf],

  // Medium
    // CUP
    ["CUP_B_Stinger_AA_pod_Base_USMC",0,0,0,GRLIB_perm_inf],
    ["CUP_WV_B_CRAM",50,0,0,GRLIB_perm_inf],
    
    // Vanilla
    ["B_Radar_System_01_F",100,0,0,GRLIB_perm_inf],

    
  // Heavy
    // CUP
    ["CUP_WV_B_RAM_Launcher",150,0,0,GRLIB_perm_inf],
    // Vanilla
    ["B_SAM_System_03_F",200,0,0,GRLIB_perm_inf],
    // FFAA
    ["ffaa_lanzador_nasams",0,500,0,GRLIB_perm_inf],
    // CUP
    ["CUP_B_M119_USMC",0,800,0,GRLIB_perm_inf],
  // Super heavy
    ["B_Ship_MRLS_01_F",0,20000,0,GRLIB_perm_inf]

];
 
// *** Static Weapon with AI ***
static_vehicles_AI = [
    "CUP_WV_B_CRAM",
    "CUP_WV_B_RAM_Launcher",
    "B_Radar_System_01_F",
    "B_SAM_System_03_F",
    "B_Ship_MRLS_01_F",
    "B_AAA_System_01_F",
    "CUP_WV_B_SS_Launcher"
];
 
support_vehicles_west = [

  // Quadbike
    ["B_Quadbike_01_F",0,10,0,GRLIB_perm_inf],

  // Bundeswehr
    ["rnt_lkw_10t_mil_gl_kat_i_repair_fleck",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["rnt_lkw_5t_mil_gl_kat_i_fuel_fleck",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["rnt_lkw_7t_mil_gl_kat_i_mun_fleck",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["BWA3_Multi_Fleck",0,logistic_ground_vehicle_price_tier_2,0,GRLIB_perm_inf],

  // CUP
    ["CUP_B_nM1038_Repair_DF_USA_WDL",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_nM1038_Ammo_DF_USA_WDL",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_MTVR_Repair_USMC",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_MTVR_Refuel_USMC",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["CUP_B_MTVR_Ammo_USMC",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],

  // Spain
    ["ffaa_et_m250_recuperacion_blin",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["ffaa_et_m250_municion_blin",0,logistic_ground_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["ffaa_et_m250_combustible_blin",0,logistic_ground_vehicle_price_tier_2,0,GRLIB_perm_inf],
    ["ffaa_et_m250_repara_municion_blin",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],
    ["ffaa_et_m250_estacion_nasams_blin",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf],

  // Vanilla
    ["B_Truck_01_Ammo_F",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Truck_01_flatbed_F",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Truck_01_fuel_F",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Truck_01_Repair_F",0,logistic_ground_vehicle_price_tier_1,0,GRLIB_perm_inf],
    ["B_Truck_01_box_F",0,logistic_ground_vehicle_price_tier_3,0,GRLIB_perm_inf]

];

support_crates = [

  // Ersatzteile
    ["ACE_Track",0,0,0,GRLIB_perm_inf],
    ["ACE_Wheel",0,0,0,GRLIB_perm_inf],

	// Kisten
    ["Box_NATO_Equip_F",0,0,0,GRLIB_perm_inf],
    ["B_CargoNet_01_ammo_F",0,0,0,GRLIB_perm_inf],
    ["CargoNet_01_box_F",0,0,0,GRLIB_perm_inf],
    ["CargoNet_01_barrels_F",0,0,0,GRLIB_perm_inf],

  // Waffen
    ["SNC_Javelin",0,400,0,GRLIB_perm_inf],

  // Kistenfüller & Container
    ["Land_RepairDepot_01_green_F",0,0,0,GRLIB_perm_inf],
    ["ffaa_UAVStation",0,0,0,GRLIB_perm_inf],

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

  // FOB
    [FOB_box_typename,0,500,0,GRLIB_perm_inf],
    [FOB_truck_typename,0,500,0,GRLIB_perm_inf]

];


 
buildings_west = [
   
  ["Land_HBarrier_01_wall_6_green_F",0,0,0,GRLIB_perm_inf],
  ["Land_HBarrier_01_line_3_green_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrier_01_big_tower_green_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrier_01_tower_green_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrier_01_wall_corridor_green_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrier_01_wall_corner_green_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrier_01_wall_4_green_F",0,0,0,GRLIB_perm_inf],
	 
	["Land_HBarrier_1_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrierWall6_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrier_3_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrierTower_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrierWall_corridor_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrierWall4_F",0,0,0,GRLIB_perm_inf],
	["Land_HBarrierWall_corner_F",0,0,0,GRLIB_perm_inf],
	 
	["Land_CncBarrierMedium_F",0,0,0,GRLIB_perm_inf],
	["Land_CncBarrierMedium4_F",0,0,0,GRLIB_perm_inf],
	["Land_CncShelter_F",0,0,0,GRLIB_perm_inf],
	["Land_CncWall1_F",0,0,0,GRLIB_perm_inf],
	["Land_CncWall4_F",0,0,0,GRLIB_perm_inf],
	["Land_CncBarrier_stripes_F",0,0,0,GRLIB_perm_inf],
	["Flag_UNO_F",0,0,0,GRLIB_perm_inf],
	["Flag_NATO_F",0,0,0,GRLIB_perm_inf],
	["FlagCarrierGermany_EP1",0,0,0,GRLIB_perm_inf],
	["FlagCarrierRU",0,0,0,GRLIB_perm_inf],
	["Flag_UK_F",0,0,0,GRLIB_perm_inf],
	["Flag_US_F",0,0,0,GRLIB_perm_inf],
	["Land_PortableLight_single_F",0,0,0,GRLIB_perm_inf],
	 
	["Land_Campfire_F",0,0,0,GRLIB_perm_inf],
	["Land_CampingChair_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_CampingTable_F",0,0,0,GRLIB_perm_inf],
	["Land_fort_bagfence_long",0,0,0,GRLIB_perm_inf],
	 
	["Land_HelipadSquare_F",0,0,0,GRLIB_perm_inf],
	["PortableHelipadLight_01_blue_F",0,0,0,GRLIB_perm_inf],
	["PortableHelipadLight_01_green_F",0,0,0,GRLIB_perm_inf],
	 
	["Land_ClutterCutter_large_F",0,0,0,GRLIB_perm_inf],
 
    ["Land_Hangar_F",0,0,0,GRLIB_perm_inf],
    ["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_inf],
    ["Land_Medevac_house_V1_F",0,0,0,GRLIB_perm_inf],
    ["Land_Medevac_HQ_V1_F",0,0,0,GRLIB_perm_inf],
   
    ["Land_PortableLight_double_F",0,0,0,GRLIB_perm_inf],
    ["Land_LampAirport_F",0,0,0,GRLIB_perm_inf],
    ["Land_LampStreet_02_double_F",0,0,0,GRLIB_perm_inf],
    ["Land_SandbagBarricade_01_hole_F",0,0,0,GRLIB_perm_inf],
    ["Land_fortified_nest_small",0,0,0,GRLIB_perm_inf],
    ["Land_fortified_nest_big",0,0,0,GRLIB_perm_inf],
    ["Land_BagBunker_Small_F",0,0,0,GRLIB_perm_inf],
    ["land_bunker_garage",0,0,0,GRLIB_perm_inf],
    ["Land_Trench_01_grass_F",0,0,0,GRLIB_perm_inf],
    ["Land_fort_rampart",0,0,0,GRLIB_perm_inf],
    ["Land_fort_artillery_nest",0,0,0,GRLIB_perm_inf],
    ["Land_HBarrier_01_line_5_green_F",0,0,0,GRLIB_perm_inf],
    ["Land_HBarrier_01_big_4_green_F",0,0,0,GRLIB_perm_inf],
    ["zed2",0,0,0,GRLIB_perm_inf],
    ["US_WarfareBBarrier10xTall_EP1",0,0,0,GRLIB_perm_inf],
    ["WarfareBCamp",0,0,0,GRLIB_perm_inf],
    ["Fortress2",0,0,0,GRLIB_perm_inf],
    ["Land_Lampa_sidl_3",0,0,0,GRLIB_perm_inf],
    ["Land_TentHangar_V1_F", 0, 0, 0, GRLIB_perm_inf] 

];
 
if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
    "CUP_B_USMC_Soldier_SL",
    "CUP_B_USMC_Medic",
    "CUP_B_USMC_Soldier_GL",
    "CUP_B_USMC_Soldier_AR",
    "CUP_B_USMC_Soldier_LAT",
    "CUP_B_USMC_Engineer",
    "CUP_B_USMC_Soldier",
    "CUP_B_USMC_Soldier"
    ];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
    "CUP_B_USMC_Soldier_SL",
    "CUP_B_USMC_Medic",
    "CUP_B_USMC_Spotter",
    "CUP_B_USMC_Soldier_AR",
    "CUP_B_USMC_Soldier_MG",
    "CUP_B_USMC_Soldier_Marksman",
    "CUP_B_USMC_Soldier_LAT",
    "CUP_B_USMC_Engineer",
    "CUP_B_USMC_Soldier",  
    "CUP_B_USMC_Soldier"
    ];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
    "CUP_B_USMC_Soldier_SL",
    "CUP_B_USMC_Medic",
    "CUP_B_USMC_Soldier_HAT",
    "CUP_B_USMC_Soldier_LAT",
    "CUP_B_USMC_Engineer",
    "CUP_B_USMC_Soldier"
    ];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
    "CUP_B_USMC_Soldier_SL",
    "CUP_B_USMC_Medic",
    "CUP_B_USMC_Soldier_AA",
    "CUP_B_USMC_Soldier_AA",
    "CUP_B_USMC_Engineer",
    "CUP_B_USMC_Soldier"
    ];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
    "CUP_B_USMC_Soldier_SL",
    "CUP_B_USMC_Medic",
    "CUP_B_USMC_Soldier_AA",
    "CUP_B_USMC_Soldier_HAT",
    "CUP_B_USMC_Engineer",
    "CUP_B_USMC_Soldier"
    ];
};
 
squads = [
    [blufor_squad_inf_light,10,300,0,GRLIB_perm_inf],
    [blufor_squad_inf,20,400,0,GRLIB_perm_inf],
    [blufor_squad_at,25,600,0,GRLIB_perm_inf],
    [blufor_squad_aa,25,600,0,GRLIB_perm_inf],
    [blufor_squad_mix,25,600,0,GRLIB_perm_inf]
];
 
// All the UAVs must be declared here
uavs = [
    "B_UAV_01_F",
    "B_UAV_02_dynamicLoadout_F",
    "B_T_UAV_03_dynamicLoadout_F",
    "B_UAV_05_F",
    "B_UAV_06_F",
    "C_UAV_06_F",
    "B_UGV_01_F",
    "B_UGV_01_rcws_F",
    "B_UGV_02_Demining_F",
    "B_Radar_System_01_F",
    "CUP_B_USMC_DYN_MQ9",
    "CUP_WV_B_CRAM",
    "B_SAM_System_03_F",
    "B_Ship_MRLS_01_F",
    "B_AAA_System_01_F",
    "USAF_MQ9",
    "USAF_RQ4A",
    "ffaa_ea_reaper"
    ];
 
// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "CUP_B_AAV_Unarmed_USMC"
];
 
// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
    "CUP_B_AAV_Unarmed_USMC"
];
 
vehicle_rearm_sources_west = [
    "CUP_B_AAV_Unarmed_USMC"
];
 
vehicle_big_units_west = [
    "CUP_B_LCU1600_USMC"
];
 
GRLIB_vehicle_whitelist_west = [
 
];
 
GRLIB_vehicle_blacklist_west = [
    "CUP_B_SearchLight_static_USMC",
    "CUP_B_M2StaticMG_USMC",
    "CUP_B_M2StaticMG_MiniTripod_USMC",
    "CUP_B_M252_USMC",
    "CUP_B_M119_USMC",
    "CUP_B_MK19_TriPod_USMC",
    "CUP_B_Stinger_AA_pod_Base_USMC",
    "CUP_B_TOW_TriPod_USMC"
];
 
box_transport_config_west = [
    [ "CUP_B_MTVR_USMC", -6.5, [0, -0.4, 0.3], [0, -2.1, 0.3] ],
    [ "CUP_B_T810_Unarmed_CZ_DES", -5.5, [0, 0.3, 0], [0, -1.25, 0] ],
    [ "CUP_B_T810_Armed_CZ_DES", -5.5, [0, 0.3, -0.3], [0, -1.25, -0.3] ]
];
 
//GRLIB_AirDrop_1 = [];
//GRLIB_AirDrop_2 = [];
GRLIB_AirDrop_3 = [
    "CUP_B_T810_Armed_CZ_DES",
    "CUP_B_nM1025_M2_USMC_WDL",
    "CUP_B_M1151_Deploy_USMC",
    "CUP_B_RG31_M2_OD_USMC"
];
GRLIB_AirDrop_4 = [
    "CUP_B_T810_Unarmed_CZ_DES",
    "CUP_B_T810_Armed_CZ_DES",
    "CUP_B_MTVR_USMC"
];
GRLIB_AirDrop_5 = [
    "CUP_B_M1126_ICV_M2_Woodland",
    "CUP_B_M1126_ICV_MK19_Woodland",
    "CUP_B_RG31E_M2_OD_USMC"
];
//GRLIB_AirDrop_6 = [];
 

