// *** LRX DEFAULT CLASSNAMES ***

if ( isNil "FOB_typename" ) then { FOB_typename = "Land_Cargo_HQ_V1_F" };
if ( isNil "FOB_box_typename" ) then { FOB_box_typename = "B_Slingload_01_Cargo_F" };
if ( isNil "FOB_truck_typename" ) then { FOB_truck_typename = "B_Truck_01_box_F" };
if ( isNil "FOB_outpost" ) then { FOB_outpost = "Land_BagBunker_Tower_F" };
if ( isNil "FOB_box_outpost" ) then { FOB_box_outpost = "Land_Cargo10_grey_F" };
if ( isNil "FOB_sign" ) then { FOB_sign = "SignAd_Sponsor_F" };
if ( isNil "Arsenal_typename" ) then { Arsenal_typename = "B_supplyCrate_F" };
if ( isNil "Respawn_truck_typename" ) then { Respawn_truck_typename = "B_Truck_01_medical_F" };
if ( isNil "ammo_truck_typename" ) then { ammo_truck_typename = "B_Truck_01_ammo_F" };
if ( isNil "fuel_truck_typename" ) then { fuel_truck_typename = "B_Truck_01_fuel_F" };
if ( isNil "repair_truck_typename" ) then { repair_truck_typename = "B_Truck_01_Repair_F" };
if ( isNil "repair_sling_typename" ) then { repair_sling_typename = "B_Slingload_01_Repair_F" };
if ( isNil "fuel_sling_typename" ) then { fuel_sling_typename = "B_Slingload_01_Fuel_F" };
if ( isNil "ammo_sling_typename" ) then { ammo_sling_typename = "B_Slingload_01_Ammo_F" };
if ( isNil "medic_sling_typename" ) then { medic_sling_typename = "B_Slingload_01_Medevac_F" };
if ( isNil "mobile_respawn" ) then { mobile_respawn = "Land_TentDome_F" };		// "Land_SatelliteAntenna_01_F"
if ( isNil "mobile_respawn_bag" ) then { mobile_respawn_bag = "B_Kitbag_Base" };
if ( isNil "medicalbox_typename" ) then { medicalbox_typename = "Box_B_UAV_06_medical_F" };
if ( isNil "huron_typename" ) then { huron_typename = "B_Heli_Transport_03_unarmed_F" };
if ( isNil "ammobox_b_typename" ) then { ammobox_b_typename = "Box_NATO_AmmoVeh_F" };
if ( isNil "ammobox_o_typename" ) then { ammobox_o_typename = "Box_East_AmmoVeh_F" };
if ( isNil "ammobox_i_typename" ) then { ammobox_i_typename = "Box_IND_AmmoVeh_F" };
if ( isNil "waterbarrel_typename" ) then { waterbarrel_typename = "Land_BarrelWater_F" };
if ( isNil "fuelbarrel_typename" ) then { fuelbarrel_typename = "Land_MetalBarrel_F" };
if ( isNil "foodbarrel_typename" ) then { foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F" };
if ( isNil "opfor_transport_truck" ) then { opfor_transport_truck = "O_Truck_03_transport_F" };
if ( isNil "repair_offroad" ) then { repair_offroad = "C_Offroad_01_repair_F" };
if ( isNil "commander_classname" ) then { commander_classname = "B_officer_F" };
if ( isNil "crewman_classname" ) then { crewman_classname = "B_crew_F" };
if ( isNil "pilot_classname" ) then { pilot_classname = "B_Helipilot_F" };
if ( isNil "PAR_Medikit" ) then { PAR_Medikit = "Medikit" };
if ( isNil "PAR_AidKit" ) then { PAR_AidKit = "FirstAidKit" };
if ( isNil "A3W_BoxWps" ) then { A3W_BoxWps = "Box_East_Wps_F" };
if ( isNil "canisterFuel" ) then { canisterFuel = "Land_CanisterFuel_Red_F" };
if ( isNil "uavs" ) then { uavs = [] };
if ( isNil "boats_west" ) then { boats_west = [] };
if ( isNil "boats_east" ) then { boats_east = [] };
if ( isNil "ai_resupply_sources" ) then { ai_resupply_sources = [] };
if ( isNil "ai_healing_sources" ) then { ai_healing_sources = [] };
if ( isNil "vehicle_rearm_sources" ) then { vehicle_rearm_sources = [] };
if ( isNil "vehicle_big_units" ) then { vehicle_big_units = [] };
if ( isNil "GRLIB_sar_wreck" ) then { GRLIB_sar_wreck = "Land_Wreck_Heli_Attack_01_F" };
if ( isNil "GRLIB_sar_fire" ) then { GRLIB_sar_fire = "test_EmptyObjectForFireBig" };
if ( isNil "GRLIB_vehicle_whitelist" ) then { GRLIB_vehicle_whitelist = [] };
if ( isNil "GRLIB_vehicle_blacklist" ) then { GRLIB_vehicle_blacklist = [] };
if ( isNil "box_transport_config" ) then { box_transport_config = [] };
if ( isNil "opfor_texture_overide" ) then { opfor_texture_overide = [] };
if ( isNil "civilians" ) then { civilians = ["C_man_1"] };
if ( isNil "civilian_vehicles" ) then { civilian_vehicles = ["C_SUV_01_F"] };
if ( isNil "box_transport_config_west" ) then { box_transport_config_west = [] };
if ( isNil "box_transport_config_east" ) then { box_transport_config_east = [] };
if ( isNil "opfor_statics" ) then { opfor_statics = [] };
if ( isNil "units_loadout_overide" ) then { units_loadout_overide = [] };

// *** LRX DEFAULT BUILDINGS CLASSNAMES ***
buildings_default = [	
	["Land_PierLadder_F",0,0,0,GRLIB_perm_inf],
	["Land_CncBarrierMedium4_F",0,0,0,0],
	["Land_CncWall4_F",0,0,0,0],
	["Land_BagFence_Round_F",0,0,0,GRLIB_perm_log],
	["Land_BagFence_Long_F",0,0,0,0],
	["Land_BagFence_Short_F",0,0,0,GRLIB_perm_inf],
	["Land_BagFence_Corner_F",0,0,0,GRLIB_perm_log],
	["Land_RampConcrete_F",0,0,0,GRLIB_perm_log],
	["Land_RampConcreteHigh_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrier_5_F",0,0,0,0],
	["Land_HBarrierWall_corridor_F",0,0,0,0],
	["Land_HBarrierWall4_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierWall6_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierWall_corner_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierTower_F",0,0,0,GRLIB_perm_tank],
	["Land_HBarrierBig_F",0,0,0,GRLIB_perm_tank],
	["Land_CncShelter_F",0,0,0,GRLIB_perm_log],
	["Land_BagBunker_Small_F",0,0,0,0],
	["Land_BagBunker_Large_F",0,0,0,GRLIB_perm_tank],
	["Land_MedicalTent_01_NATO_generic_open_F",0,0,0,GRLIB_perm_inf],
	//["Land_BagBunker_Tower_F",0,0,0,GRLIB_perm_tank],
	["Land_SandbagBarricade_01_F",0,0,0,GRLIB_perm_log],
	["Land_SandbagBarricade_01_hole_F",0,0,0,GRLIB_perm_log],
	["Land_SandbagBarricade_01_half_F",0,0,0,GRLIB_perm_log],
	["Land_SM_01_shed_F",0,0,0,GRLIB_perm_max],
	["Land_Hangar_F",0,0,0,GRLIB_perm_max],
	["Land_Medevac_house_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Medevac_HQ_V1_F",0,0,0,GRLIB_perm_air],
	["Land_PortableLight_double_F",0,0,0,GRLIB_perm_log],
	["Land_TentLamp_01_suspended_F",0,0,0,GRLIB_perm_log],
    ["Land_TentLamp_01_suspended_red_F",0,0,0,GRLIB_perm_log],
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
	["PortableHelipadLight_01_red_F",0,0,0,GRLIB_perm_tank],
	["PortableHelipadLight_01_white_F",0,0,0,GRLIB_perm_tank],
	["PortableHelipadLight_01_green_F",0,0,0,GRLIB_perm_tank],
	["PortableHelipadLight_01_yellow_F",0,0,0,GRLIB_perm_tank],
	["Land_DieselGroundPowerUnit_01_F",0,0,0,GRLIB_perm_tank],
	["Land_Pallet_MilBoxes_F",0,0,0,GRLIB_perm_tank],
	["Land_PaperBox_open_full_F",0,0,0,GRLIB_perm_tank],
	["Land_CzechHedgehog_01_new_F",0,0,0,GRLIB_perm_inf],
	["Land_ConcreteHedgehog_01_F",0,0,0,GRLIB_perm_log],
	["Land_DragonsTeeth_01_4x2_old_redwhite_F",0,0,0,GRLIB_perm_tank],
	["Land_ClutterCutter_large_F",0,0,0,GRLIB_perm_tank]
];