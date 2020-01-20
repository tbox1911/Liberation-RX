// !! IF YOU WANT TO EDIT THIS FOR MODDING PURPOSES, PLEASE USE CLASSNAMES_EXTENSIONS.SQF INSTEAD !!
// If you know what you're doing then sure, proceed :)

if ( isNil "FOB_typename" ) then { FOB_typename = "Land_Cargo_HQ_V1_F"; };
if ( isNil "FOB_box_typename" ) then { FOB_box_typename = "B_Slingload_01_Cargo_F"; };
if ( isNil "FOB_truck_typename" ) then { FOB_truck_typename = "B_Truck_01_box_F"; };
if ( isNil "Arsenal_typename" ) then { Arsenal_typename = "B_supplyCrate_F"; };
if ( isNil "Respawn_truck_typename" ) then { Respawn_truck_typename = "B_Truck_01_medical_F"; };
if ( isNil "huron_typename" ) then { huron_typename = "B_Heli_Transport_03_unarmed_F"; };
if ( isNil "ammobox_b_typename" ) then { ammobox_b_typename = "Box_NATO_AmmoVeh_F"; };
if ( isNil "ammobox_o_typename" ) then { ammobox_o_typename = "Box_East_AmmoVeh_F"; };
if ( isNil "ammobox_i_typename" ) then { ammobox_i_typename = "Box_IND_AmmoVeh_F"; };
if ( isNil "opfor_ammobox_transport" ) then { opfor_ammobox_transport = "O_Truck_03_transport_F"; };
if ( isNil "commander_classname" ) then { commander_classname = "B_officer_F"; };
if ( isNil "crewman_classname" ) then { crewman_classname = "B_crew_F" };
if ( isNil "pilot_classname" ) then { pilot_classname = "B_Helipilot_F" };

infantry_units = [
	["B_Soldier_lite_F",1,0,0],
	["B_soldier_F",1,0,0],
	["B_medic_F",1,0,0],
	["B_engineer_F",1,0,0],
	["B_soldier_GL_F",1,0,0],
	["B_soldier_M_F",1,0,0],
	["B_soldier_LAT_F",1,0,0],
	["B_Sharpshooter_F",1,0,0],
	["B_HeavyGunner_F",1,0,0],
	["B_recon_F",1,0,0],
	["B_recon_medic_F",1,0,0],
	["B_recon_M_F",1,0,0],
	["B_Recon_Sharpshooter_F",1,0,0],
	["B_soldier_AA_F",1,0,0],
	["B_soldier_AT_F",1,0,0],
	["B_sniper_F",1,0,0],
	["B_soldier_PG_F",1,0,0],
	["B_crew_F",1,0,0],
	["B_helipilot_F",1,0,0]
];

// calc units price
_grp = createGroup [GRLIB_side_friendly, true];
{
	_unit_class = _x select 0;
	_unit_mp = _x select 1;
	_unit = _grp createUnit [_unit_class, [0,0,0], [], 0, "NONE"];
	_price = [_unit] call F_loadoutPrice;
	infantry_units set [_forEachIndex, [_unit_class, _unit_mp, _price, 0] ];
	deleteVehicle _unit;
} foreach infantry_units ;

if ( isNil "infantry_units_extension" ) then { infantry_units_extension = [] };
if ( isNil "infantry_units_overwrite" ) then { infantry_units_overwrite = false };
if ( infantry_units_overwrite ) then { infantry_units = infantry_units_extension; } else { infantry_units = infantry_units + infantry_units_extension; };

light_vehicles = [
	["B_Quadbike_01_F",1,5,1],
	["C_Scooter_Transport_01_F",1,5,1],
	["C_Hatchback_01_F",1,10,1],
	["C_Hatchback_01_sport_F",1,10,1],
	["C_Offroad_01_F",1,10,1],
	["C_Offroad_02_unarmed_black_F",1,10,1],
	["C_SUV_01_F",1,10,1],
	["C_Van_01_transport_F",1,15,1],
	["C_Van_01_box_F",1,15,1],
	["B_MRAP_01_F",2,25,2],
	["I_MRAP_03_F",2,25,2],
	["B_Truck_01_transport_F",5,30,5],
	["B_Truck_01_covered_F",5,30,5],
	["B_Boat_Transport_01_F",1,25,1],
	["C_Boat_Transport_02_F",2,25,2],
	["B_MRAP_01_hmg_F",5,100,2],
	["B_MRAP_01_gmg_F",5,125,2],
	["I_MRAP_03_hmg_F",5,100,2],
	["I_MRAP_03_gmg_F",5,125,2],
	["I_LT_01_cannon_F",2,200,2],
	["B_LSV_01_armed_F",5,100,2],
	["B_UGV_01_F",5,10,5],
	["B_UGV_01_rcws_F",5,250,5],
	["B_Boat_Armed_01_minigun_F",5,30,5],
	["B_SDV_01_F",5,30,5]
];
if ( isNil "light_vehicles_extension" ) then { light_vehicles_extension = [] };
if ( isNil "light_vehicles_overwrite" ) then { light_vehicles_overwrite = false };
if ( light_vehicles_overwrite ) then { light_vehicles = light_vehicles_extension; } else { light_vehicles = light_vehicles + light_vehicles_extension; };

heavy_vehicles = [
	["B_APC_Tracked_01_rcws_F",10,500,10],
	["I_APC_Wheeled_03_cannon_F",10,500,10],
	["B_APC_Tracked_01_AA_F",10,500,10],
	["B_APC_Wheeled_01_cannon_F",10,500,10],
	["I_APC_tracked_03_cannon_F",10,500,10],
	["B_MBT_01_cannon_F",15,1000,15],
	["B_MBT_01_TUSK_F",15,1500,15],
	["B_T_APC_Tracked_01_rcws_F",15,1500,15],
	["B_MBT_01_arty_F",15,3000,15],
	["B_AFV_Wheeled_01_cannon_F",15,3000,15],
	["I_MBT_03_cannon_F",15,4500,15]
];
if ( isNil "heavy_vehicles_extension" ) then { heavy_vehicles_extension = [] };
if ( isNil "heavy_vehicles_overwrite" ) then { heavy_vehicles_overwrite = false };
if ( heavy_vehicles_overwrite ) then { heavy_vehicles = heavy_vehicles_extension; } else { heavy_vehicles = heavy_vehicles + heavy_vehicles_extension; };

air_vehicles = [
	["B_UAV_01_F",1,10,5],
	["B_UAV_06_F",1,30,5],
	["C_Plane_Civil_01_F",1,50,5],
	["B_Heli_Light_01_F",1,50,5],
	["I_Heli_light_03_unarmed_F",1,50,5],
	["B_Heli_Light_01_armed_F",5,200,10],
	["B_UAV_02_F",5,1000,5],
	["B_T_UAV_03_F",5,1500,10],
	["B_Heli_Transport_03_F",10,1000,15],
	["B_Heli_Transport_01_camo_F",10,2000,15],
	["B_T_VTOL_01_infantry_F",10,1000,15],
	["B_T_VTOL_01_vehicle_F",10,1000,15],
	["I_Heli_light_03_F",10,2500,20],
	["B_Heli_Attack_01_F",10,3000,20],
	["I_Plane_Fighter_04_F", 10,2500,20],
	["B_Plane_CAS_01_F",20,4000,40],
	["B_Plane_Fighter_01_F",20,4500,40]
];

blufor_air = [
	"I_Heli_light_03_F",
	"B_Heli_Attack_01_F",
	"B_Plane_CAS_01_F",
	"B_Plane_Fighter_01_F",
	"B_Plane_Fighter_01_Stealth_F",
	"B_Plane_CAS_01_Cluster_F",
	"B_Plane_Fighter_01_Cluster_F",
	"B_Plane_Fighter_01_F",
	"I_Plane_Fighter_04_F"
];

vip_vehicles = [
	"I_Heli_light_03_F",
	"B_Heli_Attack_01_F",
	"B_Plane_CAS_01_F",
	"B_MBT_01_arty_F",
	"I_MBT_03_cannon_F",
	"B_AFV_Wheeled_01_cannon_F",
	"B_Plane_Fighter_01_F",
	"I_Plane_Fighter_04_F"
];

if ( isNil "air_vehicles_extension" ) then { air_vehicles_extension = [] };
if ( isNil "air_vehicles_overwrite" ) then { air_vehicles_overwrite = false };
if ( air_vehicles_overwrite ) then { air_vehicles = air_vehicles_extension; } else { air_vehicles = air_vehicles + air_vehicles_extension; };

static_vehicles = [
	["B_UGV_02_Demining_F",0,5,0],
	["B_Static_Designator_01_F",0,5,0],
	["B_HMG_01_F",0,10,0],
	["B_HMG_01_high_F",0,10,0],
	["B_GMG_01_F",0,20,0],
	["B_GMG_01_high_F",0,20,0],
	["B_static_AA_F",0,50,0],
	["B_static_AT_F",0,50,0],
	["B_Mortar_01_F",0,500,0],
	["B_AAA_System_01_F",10,500,0],
	["B_Ship_Gun_01_F",10,1500,0]
];
if ( isNil "static_vehicles_extension" ) then { static_vehicles_extension = [] };
if ( isNil "static_vehicles_overwrite" ) then { static_vehicles_overwrite = false };
if ( static_vehicles_overwrite ) then { static_vehicles = static_vehicles_extension; } else { static_vehicles = static_vehicles + static_vehicles_extension; };

buildings = [
	["Land_PierLadder_F",0,0,0],
	["Land_CncBarrierMedium4_F",0,0,0],
	["Land_CncWall4_F",0,0,0],
	["Land_BagBunker_Small_F",0,0,0],
	["Land_HBarrier_5_F",0,0,0],
	["Land_CncWall1_F",0,0,0],
	["Land_BagFence_Round_F",0,0,0],
	["Land_BagFence_Long_F",0,0,0],
	["Land_BagFence_Short_F",0,0,0],
	["Land_BagFence_Corner_F",0,0,0],
	["Land_HBarrierWall4_F",0,0,0],
	["Land_HBarrierWall6_F",0,0,0],
	["Land_HBarrierWall_corner_F",0,0,0],
	["Land_HBarrierTower_F",0,0,0],
	["Land_CncShelter_F",0,0,0],
	["Land_Cargo_Tower_V1_F",0,0,0],
	["Land_Cargo_House_V1_F",0,0,0],
	["Land_Cargo_Patrol_V1_F",0,0,0],
	["Land_BagBunker_Large_F",0,0,0],
	["Land_BagBunker_Tower_F",0,0,0],
	["Land_HBarrierBig_F",0,0,0],
	["Flag_NATO_F",0,0,0],
	["Land_PortableLight_single_F",0,0,0],
	["Land_HelipadSquare_F",0,0,0],
	["Land_Razorwire_F",0,0,0],
	["Land_ToolTrolley_02_F",0,0,0],
	["Land_WeldingTrolley_01_F",0,0,0],
	["Land_GasTank_02_F",0,0,0],
	["Land_Workbench_01_F",0,0,0],
	["Land_WaterTank_F",0,0,0],
	["Land_WaterBarrel_F",0,0,0],
	["Land_BarGate_F",0,0,0],
	["Land_MetalCase_01_large_F",0,0,0],
	["CargoNet_01_box_F",0,0,0],
	["CamoNet_BLUFOR_open_F",0,0,0],
	["CamoNet_BLUFOR_big_F",0,0,0],
	["Land_CampingChair_V1_F",0,0,0],
	["Land_CampingChair_V2_F",0,0,0],
	["Land_CampingTable_F",0,0,0],
	["MapBoard_altis_F",0,0,0],
	["Land_Metal_rack_Tall_F",0,0,0],
	["PortableHelipadLight_01_blue_F",0,0,0],
	["Land_DieselGroundPowerUnit_01_F",0,0,0],
	["Land_Pallet_MilBoxes_F",0,0,0],
	["Land_PaperBox_open_full_F",0,0,0],
	["Land_ClutterCutter_large_F",0,0,0]
];
if ( isNil "buildings_extension" ) then { buildings_extension = [] };
if ( isNil "buildings_overwrite" ) then { buildings_overwrite = false };
if ( buildings_overwrite ) then { buildings = buildings_extension; } else { buildings = buildings + buildings_extension; };

support_vehicles = [
	[Arsenal_typename,0,10,0],
	["Box_B_UAV_06_medical_F",5,5,0],
	["Land_TentDome_F",10,5,0],
	["Land_CanisterFuel_Red_F",0,5,1],
	["C_Offroad_01_repair_F",5,15,5],
	["C_Van_01_fuel_F",5,5,20],
	[Respawn_truck_typename,15,20,5],
	["B_Slingload_01_Repair_F",10,20,0],
	["B_Slingload_01_Fuel_F",0,20,30],
	["B_Slingload_01_Ammo_F",0,40,0],
	["B_Slingload_01_Medevac_F",10,30,0],
	["B_Truck_01_ammo_F",5,50,10],
	["B_Truck_01_Repair_F",10,30,10],
	["B_Truck_01_fuel_F",5,20,40],
  	["Box_NATO_Ammo_F",0,20,0],
  	["Box_NATO_WpsLaunch_F",0,50,0],
	[FOB_box_typename,50,500,50],
	[FOB_truck_typename,50,500,50],
	["B_APC_Tracked_01_CRV_F",10,2000,20],
	[ammobox_b_typename,0,round(300 / GRLIB_recycling_percentage),0],
	[ammobox_o_typename,0,round(300 / GRLIB_recycling_percentage),0],
	[ammobox_i_typename,0,round(300 / GRLIB_recycling_percentage),0],
	["Box_East_Wps_F",0,round(150 / GRLIB_recycling_percentage),0]
];
if ( isNil "support_vehicles_extension" ) then { support_vehicles_extension = [] };
if ( isNil "support_vehicles_overwrite" ) then { support_vehicles_overwrite = false };
if ( support_vehicles_overwrite ) then { support_vehicles = support_vehicles_extension; } else { support_vehicles = support_vehicles + support_vehicles_extension; };

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [ "B_Soldier_SL_F","B_Soldier_TL_F","B_Soldier_GL_F","B_soldier_AR_F","B_Soldier_GL_F","B_medic_F","B_Soldier_LAT_F","B_Soldier_F","B_Soldier_F" ]; };
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [ "B_Soldier_SL_F","B_Soldier_TL_F","B_Soldier_AR_F","B_HeavyGunner_F","B_medic_F","B_Soldier_GL_F","B_Soldier_LAT_F","B_Soldier_LAT_F","B_soldier_M_F","B_Sharpshooter_F" ]; };
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [ "B_Soldier_SL_F","B_soldier_AT_F","B_soldier_AT_F","B_soldier_AT_F","B_medic_F","B_soldier_F" ]; };
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [ "B_Soldier_SL_F","B_soldier_AA_F","B_soldier_AA_F","B_soldier_AA_F","B_medic_F","B_soldier_F" ]; };
if ( isNil "blufor_squad_recon" ) then { blufor_squad_recon = [] };
if ( count blufor_squad_recon == 0 ) then { blufor_squad_recon = [ "B_recon_TL_F","B_recon_F","B_recon_exp_F","B_recon_medic_F","B_recon_LAT_F","B_recon_LAT_F","B_recon_M_F","B_Recon_Sharpshooter_F","B_recon_F" ]; };
if ( isNil "blufor_squad_para" ) then { blufor_squad_para = [] };
if ( count blufor_squad_para == 0 ) then { blufor_squad_para = [ "B_soldier_PG_F","B_soldier_PG_F","B_soldier_PG_F","B_soldier_PG_F","B_soldier_PG_F","B_soldier_PG_F","B_soldier_PG_F","B_soldier_PG_F","B_soldier_PG_F","B_soldier_PG_F" ]; };
if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [ "B_Soldier_SL_F","B_Soldier_TL_F","B_Soldier_GL_F","B_soldier_AR_F","B_Soldier_GL_F","B_medic_F","B_Soldier_LAT_F","B_Soldier_F","B_Soldier_F"]; };


// All the UAVs must be declared here
uavs = [
	"B_UAV_01_F",
	"B_UAV_02_F",
	"B_T_UAV_03_F",
	"B_UAV_06_F",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F"
];
if ( isNil "uavs" ) then { uavs = [] };

elite_vehicles_extension = [
	"B_UGV_01_rcws_F",
	"B_MBT_01_TUSK_F",
	"B_MBT_01_arty_F",
	"I_MBT_03_cannon_F",
	"B_Heli_Attack_01_F",
	"B_UAV_02_F",
	"B_T_UAV_03_F",
	"B_Plane_CAS_01_F"
];
if ( isNil "elite_vehicles_extension" ) then { elite_vehicles_extension = [] }; elite_vehicles = [] + elite_vehicles_extension;
if ( isNil "ai_resupply_sources_extension" ) then { ai_resupply_sources_extension = [] };

// Everything the AI troups should be able to resupply from
ai_resupply_sources = [] + ai_resupply_sources_extension + [
	Arsenal_typename,
//	"Box_NATO_Ammo_F",
//	"Box_NATO_WpsLaunch_F",
	"B_Truck_01_ammo_F",
	"B_Slingload_01_Ammo_F",
	"B_APC_Tracked_01_CRV_F"
];

// Everything the AI troups should be able to healing from
ai_healing_sources = [
	Respawn_truck_typename,
	"Box_B_UAV_06_medical_F",
	"Land_MedicalTent_01_MTP_closed_F",
	"B_APC_Tracked_01_CRV_F"
];

if ( isNil "vehicle_repair_sources_extension" ) then { vehicle_repair_sources_extension = [] };
if ( isNil "vehicle_rearm_sources_extension" ) then { vehicle_rearm_sources_extension = [] };
if ( isNil "vehicle_refuel_sources_extension" ) then { vehicle_refuel_sources_extension = [] };

// Everything that can resupply other vehicles
vehicle_repair_sources = [] + vehicle_repair_sources_extension + [
	"B_APC_Tracked_01_CRV_F",
	"C_Offroad_01_repair_F",
	"B_Truck_01_Repair_F",
	"B_Slingload_01_Repair_F"
];
vehicle_rearm_sources = [] + vehicle_rearm_sources_extension + [
	"B_APC_Tracked_01_CRV_F",
	"B_Truck_01_ammo_F",
	"B_Slingload_01_Ammo_F"
];
vehicle_refuel_sources = [] + vehicle_refuel_sources_extension +  [
	"B_APC_Tracked_01_CRV_F",
	"B_Truck_01_fuel_F",
	"B_Slingload_01_Fuel_F"
];

squads = [
	[blufor_squad_inf_light,20,0,0],
	[blufor_squad_inf,30,0,0],
	[blufor_squad_at,20,25,0],
	[blufor_squad_aa,20,25,0],
	[blufor_squad_recon,25,0,0],
	[blufor_squad_para,20,0,0]
];

if ( isNil "opfor_sentry") then { opfor_sentry = "O_Soldier_lite_F"; };
if ( isNil "opfor_rifleman") then { opfor_rifleman = "O_Soldier_F"; };
if ( isNil "opfor_grenadier") then { opfor_grenadier = "O_Soldier_GL_F"; };
if ( isNil "opfor_squad_leader") then { opfor_squad_leader = "O_Soldier_SL_F"; };
if ( isNil "opfor_team_leader") then { opfor_team_leader = "O_Soldier_TL_F"; };
if ( isNil "opfor_marksman") then { opfor_marksman = "O_soldier_M_F"; };
if ( isNil "opfor_machinegunner") then { opfor_machinegunner = "O_Soldier_AR_F"; };
if ( isNil "opfor_heavygunner") then { opfor_heavygunner = "O_HeavyGunner_F"; };
if ( isNil "opfor_medic") then { opfor_medic = "O_medic_F"; };
if ( isNil "opfor_rpg") then { opfor_rpg = "O_Soldier_LAT_F"; };
if ( isNil "opfor_at") then { opfor_at = "O_Soldier_AT_F"; };
if ( isNil "opfor_aa") then { opfor_aa = "O_Soldier_AA_F"; };
if ( isNil "opfor_officer") then { opfor_officer = "O_officer_F"; };
if ( isNil "opfor_sharpshooter") then { opfor_sharpshooter = "O_Sharpshooter_F"; };
if ( isNil "opfor_sniper") then { opfor_sniper = "O_sniper_F"; };
if ( isNil "opfor_engineer") then { opfor_engineer = "O_engineer_F"; };
if ( isNil "opfor_paratrooper") then { opfor_paratrooper = "O_soldier_PG_F"; };
if ( isNil "opfor_mrap") then { opfor_mrap = "O_MRAP_02_F"; };
if ( isNil "opfor_mrap_armed") then { opfor_mrap_armed = "O_MRAP_02_gmg_F"; };
if ( isNil "opfor_transport_helo") then { opfor_transport_helo = "O_Heli_Transport_04_bench_F"; };
if ( isNil "opfor_transport_truck") then { opfor_transport_truck = "O_Truck_03_covered_F"; };
if ( isNil "opfor_fuel_truck") then { opfor_fuel_truck = "O_Truck_03_fuel_F"; };
if ( isNil "opfor_ammo_truck") then { opfor_ammo_truck = "O_Truck_03_ammo_F"; };
if ( isNil "opfor_fuel_container") then { opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F"; };
if ( isNil "opfor_ammo_container") then { opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F"; };
if ( isNil "opfor_flag") then { opfor_flag = "Flag_CSAT_F"; };

militia_squad = [
	"O_G_Soldier_SL_F",
	"O_G_Soldier_A_F",
	"O_G_Soldier_AR_F",
	"O_G_medic_F",
	"O_G_engineer_F",
	"O_G_Soldier_exp_F",
	"O_G_Soldier_GL_F",
	"O_G_Soldier_M_F",
	"O_G_Soldier_F",
	"O_G_Soldier_LAT_F",
	"O_G_Soldier_lite_F",
	"O_G_Sharpshooter_F",
	"O_G_Soldier_TL_F",
	"O_Soldier_AA_F",
	"O_Soldier_AT_F"
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

if ( isNil "militia_squad_extension" ) then { militia_squad_extension = [] };
if ( isNil "militia_squad_overwrite" ) then { militia_squad_overwrite = false };
if ( militia_squad_overwrite ) then { militia_squad = militia_squad_extension; } else { militia_squad = militia_squad + militia_squad_extension; };

militia_vehicles = [
	"O_G_Offroad_01_armed_F",
	"O_G_Offroad_01_AT_F",
	"I_C_Offroad_02_LMG_F",
	"O_G_Offroad_01_armed_F",
	"O_G_Offroad_01_AT_F",
	"I_C_Offroad_02_LMG_F"
];
if ( isNil "militia_vehicles_extension" ) then { militia_vehicles_extension = [] };
if ( isNil "militia_vehicles_overwrite" ) then { militia_vehicles_overwrite = false };
if ( militia_vehicles_overwrite ) then { militia_vehicles = militia_vehicles_extension; } else { militia_vehicles = militia_vehicles + militia_vehicles_extension; };

opfor_vehicles = [
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MBT_02_cannon_F",
	"O_MBT_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"O_MRAP_02_gmg_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_hmg_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F"
];
if ( isNil "opfor_vehicles_extension" ) then { opfor_vehicles_extension = [] };
if ( isNil "opfor_vehicles_overwrite" ) then { opfor_vehicles_overwrite = false };
if ( opfor_vehicles_overwrite ) then { opfor_vehicles = opfor_vehicles_extension; } else { opfor_vehicles = opfor_vehicles + opfor_vehicles_extension; };

opfor_vehicles_low_intensity = [
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F"
];
if ( isNil "opfor_vehicles_low_intensity_extension" ) then { opfor_vehicles_low_intensity_extension = [] };
if ( isNil "opfor_vehicles_low_intensity_overwrite" ) then { opfor_vehicles_low_intensity_overwrite = false };
if ( opfor_vehicles_low_intensity_overwrite ) then { opfor_vehicles_low_intensity = opfor_vehicles_low_intensity_extension; } else { opfor_vehicles_low_intensity = opfor_vehicles_low_intensity + opfor_vehicles_low_intensity_extension; };

opfor_battlegroup_vehicles = [
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_Truck_03_covered_F",
	"O_MBT_02_cannon_F",
	"O_MBT_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Light_02_F",
	"O_Heli_Transport_04_bench_F",
	"O_Truck_03_transport_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F"
];
if ( isNil "opfor_battlegroup_vehicles_extension" ) then { opfor_battlegroup_vehicles_extension = [] };
if ( isNil "opfor_battlegroup_vehicles_overwrite" ) then { opfor_battlegroup_vehicles_overwrite = false };
if ( opfor_battlegroup_vehicles_overwrite ) then { opfor_battlegroup_vehicles = opfor_battlegroup_vehicles_extension; } else { opfor_battlegroup_vehicles = opfor_battlegroup_vehicles + opfor_battlegroup_vehicles_extension; };

opfor_battlegroup_vehicles_low_intensity = [
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_Truck_03_covered_F",
	"O_Heli_Transport_04_bench_F",
	"O_Truck_03_transport_F"
];
if ( isNil "opfor_battlegroup_vehicles_low_intensity_extension" ) then { opfor_battlegroup_vehicles_low_intensity_extension = [] };
if ( isNil "opfor_battlegroup_vehicles_low_intensity_overwrite" ) then { opfor_battlegroup_vehicles_low_intensity_overwrite = false };
if ( opfor_battlegroup_vehicles_low_intensity_overwrite ) then { opfor_battlegroup_vehicles_low_intensity = opfor_battlegroup_vehicles_low_intensity_extension; } else { opfor_battlegroup_vehicles_low_intensity = opfor_battlegroup_vehicles_low_intensity + opfor_battlegroup_vehicles_low_intensity_extension; };

opfor_troup_transports = [
	"O_APC_Wheeled_02_rcws_F",
	"O_Truck_03_covered_F",
	"O_Heli_Transport_04_bench_F",
	"O_Truck_03_transport_F",
	"O_Heli_Light_02_F",
	"O_T_VTOL_02_infantry_F"
];
if ( isNil "opfor_troup_transports_extension" ) then { opfor_troup_transports_extension = [] };
if ( isNil "opfor_troup_transports_overwrite" ) then { opfor_troup_transports_overwrite = false };
if ( opfor_troup_transports_overwrite ) then { opfor_troup_transports = opfor_troup_transports_extension; } else { opfor_troup_transports = opfor_troup_transports + opfor_troup_transports_extension; };

opfor_choppers = [
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F",
	"O_Heli_Light_02_F",
	"O_Heli_Light_02_v2_F",
	"O_Heli_Transport_04_bench_F",
	"O_T_VTOL_02_infantry_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F",
	"O_Heli_Light_02_F",
	"O_Heli_Light_02_v2_F",
	"O_Heli_Transport_04_bench_F"
];
if ( isNil "opfor_choppers_extension" ) then { opfor_choppers_extension = [] };
if ( isNil "opfor_choppers_overwrite" ) then { opfor_choppers_overwrite = false };
if ( opfor_choppers_overwrite ) then { opfor_choppers = opfor_choppers_extension; } else { opfor_choppers = opfor_choppers + opfor_choppers_extension; };

opfor_air = [
	"O_Plane_CAS_02_F",
	"O_Plane_Fighter_02_F",
	"O_T_VTOL_02_vehicle_F"
];
if ( isNil "opfor_air_extension" ) then { opfor_air_extension = [] };
if ( isNil "opfor_air_overwrite" ) then { opfor_air_overwrite = false };
if ( opfor_air_overwrite ) then { opfor_air = opfor_air_extension; } else { opfor_air = opfor_air + opfor_air_extension; };

ind_recyclable = [
	["I_Truck_02_covered_F",0,round (20 / GRLIB_recycling_percentage),0],
	["I_Truck_02_transport_F",0,round (20 / GRLIB_recycling_percentage),0]
];

opfor_recyclable = [
	["O_G_Offroad_01_armed_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_G_Offroad_01_AT_F",0,round (20 / GRLIB_recycling_percentage),0],
	["I_C_Offroad_02_LMG_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_Truck_03_covered_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_Truck_03_transport_F",0,round (20 / GRLIB_recycling_percentage),0],
	["O_MRAP_02_hmg_F",0,round (50 / GRLIB_recycling_percentage),0],
	["O_MRAP_02_gmg_F",0,round (50 / GRLIB_recycling_percentage),0],
	["O_APC_Wheeled_02_rcws_F",0,round (100 / GRLIB_recycling_percentage),0],
	["O_APC_Tracked_02_cannon_F",0,round (200 / GRLIB_recycling_percentage),0],
	["O_APC_Tracked_02_AA_F",0,round (300 / GRLIB_recycling_percentage),0],
	["O_MBT_02_cannon_F",0,round (400 / GRLIB_recycling_percentage),0],
	["O_MBT_04_cannon_F",0,round (500 / GRLIB_recycling_percentage),0],
	["O_MBT_04_command_F",0,round (500 / GRLIB_recycling_percentage),0],
	["O_Heli_Attack_02_F",0,round (500 / GRLIB_recycling_percentage),0],
	["O_Heli_Attack_02_black_F",0,round (500 / GRLIB_recycling_percentage),0]
];

civilians = [
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
	"C_Man_casual_2_F",
	"C_Man_casual_4_F",
	"C_Man_casual_1_F",
	"C_Man_casual_3_F",
	"C_Man_casual_5_F",
	"C_journalist_F",
	"C_man_shorts_2_F",
	"C_man_w_worker_F",
	"C_Paramedic_01_base_F",
	"C_Man_UtilityWorker_01_F",
	"C_Orestes",
	"C_Nikos"
];
if ( isNil "civilians_extension" ) then { civilians_extension = [] };
if ( isNil "civilians_overwrite" ) then { civilians_overwrite = false };
if ( civilians_overwrite ) then { civilians = civilians_extension; } else { civilians = civilians + civilians_extension; };

civilian_vehicles = [
	"C_Hatchback_01_F",
	"C_Hatchback_01_sport_F",
	"C_Offroad_01_F",
	"C_Offroad_01_darkred_F",
	"C_Offroad_luxe_F",
	"C_Offroad_02_unarmed_F",
	"I_C_Offroad_02_unarmed_F",
	"SUV_01_base_black_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"C_Van_01_box_F",
	"C_Van_01_fuel_F",
	"C_Quadbike_01_F",
	"C_Van_02_transport_F",
	"C_Van_02_medevac_F",
	"C_Van_02_service_F",
	"B_GEN_Van_02_transport_F",
	"C_Truck_02_transport_F"
];
if ( isNil "civilian_vehicles_extension" ) then { civilian_vehicles_extension = [] };
if ( isNil "civilian_vehicles_overwrite" ) then { civilian_vehicles_overwrite = false };
if ( civilian_vehicles_overwrite ) then { civilian_vehicles = civilian_vehicles_extension; } else { civilian_vehicles = civilian_vehicles + civilian_vehicles_extension; };

box_transport_config = [
	[ "C_Offroad_01_F", -5, [0, -1.55, 0.2] ],
	[ "B_Truck_01_transport_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
	[ "B_Truck_01_covered_F", -6.5, [0, -0.4, 0.4], [0, -2.1, 0.4], [0, -3.8, 0.4] ],
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
if ( isNil "box_transport_config_extension" ) then { box_transport_config_extension = [] };
box_transport_config = [] + box_transport_config + box_transport_config_extension;

// Whitelist Vehicle (recycle)
GRLIB_vehicle_whitelist = [
	Arsenal_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	"Box_East_Wps_F",
	"Land_TentDome_F",
	"Land_CanisterFuel_Red_F",
	"Land_PierLadder_F",
	"Box_B_UAV_06_medical_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncWall4_F",
	"Land_BagBunker_Small_F",
	"Land_CncWall1_F",
	"Land_HBarrier_5_F",
	"O_Truck_03_covered_F",
	"O_Truck_03_transport_F",
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"O_APC_Wheeled_02_rcws_F",
	"O_APC_Tracked_02_cannon_F",
	"O_APC_Tracked_02_AA_F",
	"O_MBT_02_cannon_F",
	"O_MBT_04_cannon_F",
	"O_MBT_04_command_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F"
];
{GRLIB_vehicle_whitelist pushBack ( _x select 0 )} foreach (static_vehicles);

// Blacklist Vehicle (lock and paint)
GRLIB_vehicle_blacklist = [
	huron_typename,
	opfor_ammobox_transport,
	"ReammoBox_F",
	"Box_UAV_06_base_F",
	"B_Heli_Transport_01_F",
	"O_Heli_Light_02_unarmed_F",
	"O_Truck_03_transport_F",
	"O_Truck_03_covered_F",
	"O_Truck_03_ammo_F",
	"O_Truck_03_fuel_F",
	"O_Truck_03_medical_F"
];
{GRLIB_vehicle_blacklist pushBack ( _x select 0 )} foreach (support_vehicles);

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
opfor_squad_low_intensity = [opfor_team_leader,opfor_machinegunner,opfor_medic,opfor_rpg,opfor_rpg,opfor_sentry,opfor_sentry,opfor_sentry,opfor_sentry];
opfor_squad_8_standard = [opfor_squad_leader,opfor_team_leader,opfor_machinegunner,opfor_rpg,opfor_heavygunner,opfor_medic,opfor_marksman,opfor_grenadier,opfor_rpg];
opfor_squad_8_infkillers = [opfor_squad_leader,opfor_machinegunner,opfor_machinegunner,opfor_heavygunner,opfor_medic,opfor_marksman,opfor_sharpshooter,opfor_sniper,opfor_rpg];
opfor_squad_8_tankkillers = [opfor_squad_leader,opfor_medic,opfor_machinegunner,opfor_rpg,opfor_rpg,opfor_at,opfor_at,opfor_at];
opfor_squad_8_airkillers = [opfor_squad_leader,opfor_medic,opfor_machinegunner,opfor_rpg,opfor_rpg,opfor_aa,opfor_aa,opfor_aa];
all_resistance_troops = [] + militia_squad;
all_hostile_classnames = (land_vehicles_classnames + opfor_air + opfor_choppers + opfor_troup_transports + opfor_vehicles_low_intensity);
{ land_vehicles_classnames pushback (_x select 0); } foreach (heavy_vehicles + light_vehicles);
air_vehicles_classnames = [] + opfor_choppers;
{ air_vehicles_classnames pushback (_x select 0); } foreach air_vehicles;
markers_reset = [99999,99999,0];
zeropos = [0,0,0];
squads_names = [ localize "STR_LIGHT_RIFLE_SQUAD", localize "STR_RIFLE_SQUAD", localize "STR_AT_SQUAD", localize "STR_AA_SQUAD",  localize "STR_RECON_SQUAD", localize "STR_PARA_SQUAD" ];
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
	"Box_B_UAV_06_medical_F",
	"Land_TentDome_F",
	"Box_NATO_Ammo_F",
  	"Box_NATO_WpsLaunch_F",
	"Land_CanisterFuel_Red_F",
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
	"Land_ClutterCutter_large_F"
];
GRLIB_sar_wreck = "Land_Wreck_Heli_Attack_01_F";
GRLIB_sar_fire = "test_EmptyObjectForFireBig";
GRLIB_Ammobox = [
	Arsenal_typename,
	"Box_B_UAV_06_medical_F",
	"Box_NATO_Ammo_F",
	"Box_NATO_WpsLaunch_F",
	"Box_East_Wps_F",
	"mission_USLaunchers"
];