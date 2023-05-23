// *** LRX DEFAULT CLASSNAMES ***
if ( isNil "huron_typename" ) then { huron_typename = "B_Heli_Transport_03_unarmed_F" };

FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "B_Truck_01_box_F";
FOB_outpost = "Land_BagBunker_Tower_F";
FOB_box_outpost = "Land_Cargo10_grey_F";
FOB_sign = "SignAd_Sponsor_F";
Radio_tower = "Land_Communication_F";
Warehouse_typename = "Land_Warehouse_03_F";
Arsenal_typename = "B_supplyCrate_F";
Box_Weapon_typename = "Box_NATO_Wps_F";
Box_Ammo_typename = "Box_NATO_Ammo_F";
Box_Support_typename = "Box_NATO_Support_F";
Box_Launcher_typename = "Box_NATO_WpsLaunch_F";
Box_Special_typename = "Box_NATO_WpsSpecial_F";
Respawn_truck_typename = "B_Truck_01_medical_F";
ammo_truck_typename = "B_Truck_01_ammo_F";
fuel_truck_typename = "B_Truck_01_fuel_F";
repair_truck_typename = "B_Truck_01_Repair_F";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
mobile_respawn = "Land_TentDome_F";
mobile_respawn_bag = "B_Kitbag_Base";
medicalbox_typename = "Box_B_UAV_06_medical_F";
playerbox_typename = "Land_PlasticCase_01_medium_olive_CBRN_F";
playerbox_cargospace = 1500;
ammobox_b_typename = "Box_NATO_AmmoVeh_F";
ammobox_o_typename = "Box_East_AmmoVeh_F";
ammobox_i_typename = "Box_IND_AmmoVeh_F";
waterbarrel_typename = "Land_BarrelWater_F";
fuelbarrel_typename = "Land_MetalBarrel_F";
foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F";
opfor_transport_truck = "O_Truck_03_transport_F";
repair_offroad = "C_Offroad_01_repair_F";
commander_classname = "B_officer_F";
crewman_classname = "B_crew_F";
pilot_classname = "B_Helipilot_F";
PAR_Medikit = "Medikit";
PAR_AidKit = "FirstAidKit";
basic_weapon_typename = "Box_East_Wps_F";
land_cutter_typename = "Land_ClutterCutter_large_F";
canister_fuel_typename = "Land_CanisterFuel_Red_F";
GRLIB_sar_wreck = "Land_Wreck_Heli_Attack_01_F";
GRLIB_sar_fire = "test_EmptyObjectForFireBig";
civilians = ["C_man_1"];
civilian_vehicles = ["C_SUV_01_F"];
SHOP_Man = "C_Man_formal_1_F";
SELL_Man = "C_Story_Mechanic_01_F";
WRHS_Man = "B_RangeMaster_F";
uavs = [];
boats_west = [];
opfor_boats = [];
ai_resupply_sources = [];
ai_healing_sources = [];
vehicle_rearm_sources = [];
vehicle_big_units = [];
GRLIB_vehicle_whitelist = [];
GRLIB_vehicle_blacklist = [];
opfor_texture_overide = [];
opfor_statics = [];
units_loadout_overide = [];
sticky_bombs_typename = ["SatchelCharge_Remote_Ammo", "DemoCharge_Remote_Ammo"];

// see https://community.bistudio.com/wiki/nearestTerrainObjects for list
GRLIB_clutter_cutter = ["Tree","Bush","Hide","House","Fence","Ruins","Rock","Rocks","Building"];

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
	["Land_LampStreet_02_triple_F",0,0,0,GRLIB_perm_inf],
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
	["Land_DieselGroundPowerUnit_01_F",0,0,0,GRLIB_perm_tank],
	["Land_Pallet_MilBoxes_F",0,0,0,GRLIB_perm_tank],
	["Land_PaperBox_open_full_F",0,0,0,GRLIB_perm_tank],
	["Land_CzechHedgehog_01_new_F",0,0,0,GRLIB_perm_inf],
	["Land_ConcreteHedgehog_01_F",0,0,0,GRLIB_perm_log],
	["Land_DragonsTeeth_01_4x2_old_redwhite_F",0,0,0,GRLIB_perm_tank]
];
