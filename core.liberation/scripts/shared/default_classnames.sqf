// *** LRX DEFAULT CLASSNAMES ***
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "B_Truck_01_box_F";
FOB_outpost = "Land_BagBunker_Tower_F";
FOB_box_outpost = "Land_Cargo10_grey_F";
FOB_sign = "SignAd_Sponsor_F";
Radio_tower = "Land_Communication_F";
Warehouse_typename = "Land_Warehouse_03_F";
Warehouse_desk_typename = "Land_PortableDesk_01_black_F";
Arsenal_typename = "B_supplyCrate_F";
Box_Weapon_typename = "Box_NATO_Wps_F";
Box_Ammo_typename = "Box_NATO_Ammo_F";
Box_Support_typename = "Box_NATO_Support_F";
Box_Launcher_typename = "Box_NATO_WpsLaunch_F";
Box_Special_typename = "Box_NATO_WpsSpecial_F";
Box_Explosives_typename = "Box_NATO_AmmoOrd_F";
Box_Grenades_typename = "Box_NATO_Grenades_F";
Box_Equipment_typename = "Box_NATO_Equip_F";
medic_truck_typename = "B_Truck_01_medical_F";
ammo_truck_typename = "B_Truck_01_ammo_F";
fuel_truck_typename = "B_Truck_01_fuel_F";
repair_truck_typename = "B_Truck_01_Repair_F";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
medic_heal_typename = "Land_MedicalTent_01_NATO_generic_open_F";
respawn_truck_typename = "B_Truck_01_medical_F";
mobile_respawn = "Land_TentDome_F";
mobile_respawn_bag = "B_Kitbag_Base";
medicalbox_typename = "Box_B_UAV_06_medical_F";
helipad_typename = "Land_HelipadSquare_F";
playerbox_typename = "Land_PlasticCase_01_medium_olive_CBRN_F";
playerbox_cargospace = 2500;
ammobox_b_typename = "Box_NATO_AmmoVeh_F";
ammobox_o_typename = "Box_East_AmmoVeh_F";
ammobox_i_typename = "Box_IND_AmmoVeh_F";
waterbarrel_typename = "Land_BarrelWater_F";
fuelbarrel_typename = "Land_MetalBarrel_F";
foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F";
repairbox_typename = "Land_ToolTrolley_02_F";
storage_medium_typename = "ContainmentArea_02_black_F";
blufor_texture_overide = [];
blufor_flag = "Flag_NATO_F";
opfor_flag = "Flag_CSAT_F";
opfor_fuel_truck = "O_Truck_03_fuel_F";
opfor_transport_truck = "O_Truck_03_covered_F";
opfor_transport_helo = "O_Heli_Transport_04_covered_F";
opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F";
opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F";
opfor_texture_overide = [];
opfor_statics = [];
opfor_boats = [];
money_typename = "Land_Money_F";
repair_offroad = "C_Offroad_01_repair_F";
commander_classname = "B_officer_F";
crewman_classname = "B_crew_F";
pilot_classname = "B_Helipilot_F";
PAR_grave_box_typename = "Land_PlasticCase_01_small_black_F";
PAR_Medikit = "Medikit";
PAR_AidKit = "FirstAidKit";
basic_weapon_typename = "Box_East_Wps_F";
land_cutter_typename = "Land_ClutterCutter_large_F";
canister_fuel_typename = "Land_CanisterFuel_Red_F";
GRLIB_sar_wreck = "Land_Wreck_Heli_Attack_01_F";
GRLIB_sar_fire = "test_EmptyObjectForSmoke";		//"test_EmptyObjectForFireBig";
FOB_Man = "B_officer_F";
SHOP_Man = "C_Man_formal_1_F";
SELL_Man = "C_Story_Mechanic_01_F";
WRHS_Man = "C_Man_Fisherman_01_F";
uavs_terminal_typename = "B_UavTerminal";
box_uavs_typename = "Land_PlasticCase_01_medium_F";
box_uavs_max = 6;
uavs_light = "B_UAV_01_F";
uavs_def = ["UAV_01_base_F","UAV_02_base_F","UAV_03_base_F","UAV_04_base_F","UAV_05_Base_F","UAV_06_base_F","UGV_01_base_F"];
uavs_west = [];
boats_west = [];
ai_healing_sources_west = [];
ai_resupply_sources_west = [];
vehicle_rearm_sources_west = [];
vehicle_repair_sources_west = [];
vehicle_repair_box_west = [];
vehicle_repaint_sources_west = [];
vehicle_refuel_sources_west = [];
vehicle_big_units = [];
GRLIB_respawn_marker = "respawn_west";
GRLIB_music_startup = "BackgroundTrack02_F";		//"LeadTrack01a_F" (This Is War)
GRLIB_music_endgame = "LeadTrack06_F_Tank";
GRLIB_vehicle_whitelist = [];
GRLIB_vehicle_blacklist = [];
static_vehicles_AI = [];
units_loadout_overide = [];
sticky_bombs_typename = [
	// need Magzine and Ammo typename
	"DemoCharge_Remote_Mag", "DemoCharge_Remote_Ammo",
	"SatchelCharge_Remote_Mag", "SatchelCharge_Remote_Ammo"
];
LOADOUT_fixed_price = [];
LOADOUT_expensive_items = [];
LOADOUT_free_items = [];

// see https://community.bistudio.com/wiki/nearestTerrainObjects for list
GRLIB_clutter_cutter = ["TREE","SMALL TREE","BUSH","HIDE","HOUSE","FENCE","RUINS","ROCK","ROCKS","BUILDING","WALL"];

// *** LRX DEFAULT BUILDINGS CLASSNAMES ***
[] call compileFinal preprocessFileLineNumbers "scripts\shared\default_building_classnames.sqf";
