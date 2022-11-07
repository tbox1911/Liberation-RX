// *** FRIENDLIES ***
GRLIB_side_friendly = EAST;

// 3CB ChDKZ (Chernarussian Movement of the Red Star)
// Requ. Mods: RHS,3CB

huron_typename = "UK3CB_CHD_O_Mi8";
FOB_typename = "Land_Cargo_HQ_V1_F";
Respawn_truck_typename = "UK3CB_CHD_O_Ural";
//FOB_box_typename = "B_Slingload_01_Cargo_F";
//FOB_truck_typename = "B_Truck_01_box_F";
pilot_classname = "UK3CB_CHD_O_HELI_PILOT";
crewman_classname = "UK3CB_CHD_O_CREW";
A3W_BoxWps = "UK3CB_RPK_Equipbox_Opfor";  	 //"rhs_weapon_crate";


chimera_vehicle_overide = [
  ["B_Heli_Light_01_F", "UK3CB_CHD_O_LR_Closed"],	// Landrover
  ["B_Heli_Transport_01_F", "O_Heli_Light_02_unarmed_F"]  // Orca
];


// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["UK3CB_CHD_O_RIF_1",1,10,0,0],
	["UK3CB_CHD_O_MD",1,20,0,0],
	["UK3CB_CHD_O_ENG",1,25,0,0],
	["UK3CB_CHD_O_GL",1,25,0,GRLIB_perm_inf],
	["UK3CB_CHD_O_MK",1,25,0,GRLIB_perm_inf],
	["UK3CB_CHD_O_SNI",1,30,0,GRLIB_perm_inf],
	["UK3CB_CHD_O_MG",1,35,0,GRLIB_perm_log],
	["UK3CB_CHD_O_AT",1,40,0,GRLIB_perm_log],
	["UK3CB_CHD_O_AA",1,50,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];


// Chernarus Communist Militia
resistance_squad = [
	"UK3CB_CCM_O_AT",
	"UK3CB_CCM_O_AT_ASST",
	"UK3CB_CCM_O_COM",
	"UK3CB_CCM_O_AR",
	"UK3CB_CCM_O_DEM",
	"UK3CB_CCM_O_ENG",
	"UK3CB_CCM_O_MK",
	"UK3CB_CCM_O_MD",
	"UK3CB_CCM_O_OFF",
	"UK3CB_CCM_O_RIF_1",
	"UK3CB_CCM_O_RIF_2",
	"UK3CB_CCM_O_RIF_LITE",
	"UK3CB_CCM_O_RIF_BOLT",
	"UK3CB_CCM_O_SNI",
	"UK3CB_CCM_O_SPOT",
	"UK3CB_CCM_O_TL",
	"UK3CB_CCM_O_SL"
];


light_vehicles = [
	["UK3CB_CHD_O_LR_Closed",1,50,5,0],
	["UK3CB_CHD_O_LR_M2",1,150,5,GRLIB_perm_log],
	["UK3CB_CHD_O_LR_AGS30",1,200,5,GRLIB_perm_log],
	["UK3CB_CHD_O_BRDM2_HQ",2,300,10,0],
	["UK3CB_CHD_O_BRDM2",2,350,10,0],
	["UK3CB_CHD_O_BRDM2_ATGM",2,380,10,GRLIB_perm_inf],
	["UK3CB_CHD_O_BTR70",2,400,15,GRLIB_perm_inf],
	["UK3CB_CHD_O_Small_Boat_Open",2,250,10,0],
	["UK3CB_CHD_O_Fishing_Boat_DSHKM",2,300,10,GRLIB_perm_log],
	["UK3CB_CHD_O_Fishing_Boat_SPG9",2,400,10,GRLIB_perm_log]
];

heavy_vehicles = [
	["UK3CB_CHD_O_BMD1PK",5,400,15,GRLIB_perm_tank],
	["UK3CB_CHD_O_BMD1P",5,450,15,GRLIB_perm_tank],
	["UK3CB_CHD_O_BMD1",5,500,15,GRLIB_perm_tank],
	["UK3CB_CHD_O_BRM1K",5,550,15,GRLIB_perm_tank],
	// Ari und AA
	["UK3CB_CHD_O_MTLB_ZU23",10,600,20,GRLIB_perm_max],
	["UK3CB_CHD_O_ZsuTank",10,650,20,GRLIB_perm_max],
	["UK3CB_CHD_O_2S1",10,700,20,GRLIB_perm_max],
	// Tanks
	["UK3CB_CHD_O_T55",20,800,25,GRLIB_perm_max],
	["UK3CB_CHD_O_T72B",20,1000,30,GRLIB_perm_max]
];


air_vehicles = [
	["UK3CB_CHD_O_Mi8AMT",20,750,20,GRLIB_perm_air],
	["UK3CB_CHD_O_Mi8AMTSh",20,900,20,GRLIB_perm_air],
	["UK3CB_CHD_O_Antonov_AN2_Armed_Bombs",20,1000,25,GRLIB_perm_air],
	["UK3CB_CHD_O_Antonov_AN2_Armed_Rockets",20,1100,25,GRLIB_perm_air],
	["UK3CB_CHD_O_Su25SM",25,1400,30,GRLIB_perm_max],
	["UK3CB_CHD_O_Su25SM_CAS",25,1500,30,GRLIB_perm_max],
	["UK3CB_CHD_O_Su25SM_Cluster",25,1600,30,GRLIB_perm_max]
];

blufor_air = [
	"UK3CB_CHD_O_Mi8AMT",
	"UK3CB_CHD_O_Mi8",
	"UK3CB_CHD_O_Mi8AMTSh",
	"UK3CB_CHD_O_Antonov_AN2",
	"UK3CB_CHD_O_Antonov_AN2_Armed_Bombs",
	"UK3CB_CHD_O_Antonov_AN2_Armed",
	"UK3CB_CHD_O_Antonov_AN2_Armed_Rockets",
	"UK3CB_CHD_O_Su25SM",
	"UK3CB_CHD_O_Su25SM_CAS",
	"UK3CB_CHD_O_Su25SM_Cluster",
	"UK3CB_CHD_O_Su25SM_KH29"
];



boats_west = [
	"UK3CB_CHD_O_Fishing_Boat",
	"UK3CB_CHD_O_Fishing_Boat_DSHKM",
	"UK3CB_CHD_O_Fishing_Boat_SPG9",
	"UK3CB_CHD_O_Fishing_Boat_VIV_FFV",
	"UK3CB_CHD_O_Fishing_Boat_Zu23_front",
	"UK3CB_CHD_O_Fishing_Boat_Zu23",
	"UK3CB_CHD_O_Small_Boat_Closed",
	"UK3CB_CHD_O_Small_Boat_Open",
	"UK3CB_CHD_O_Small_Boat_Wood"
];


static_vehicles = [
	["UK3CB_CHD_O_DSHKM",0,150,0,GRLIB_perm_log],
	["UK3CB_CHD_O_AGS",0,200,0,GRLIB_perm_log],
	["UK3CB_CHD_O_Igla_AA_pod",0,300,0,GRLIB_perm_log],
	["UK3CB_CHD_O_2b14_82mm",0,350,0,GRLIB_perm_tank],
	["UK3CB_CHD_O_SPG9",0,400,0,GRLIB_perm_tank],
	["UK3CB_CHD_O_ZU23",0,450,0,GRLIB_perm_max],
	["UK3CB_CHD_O_D30",0,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***

static_vehicles_AI = [
	"UK3CB_CHD_O_DSHKM",
	"UK3CB_CHD_O_KORD_high",
	"UK3CB_CHD_O_ZU23",
	"UK3CB_CHD_O_SPG9",
	"UK3CB_CHD_O_Igla_AA_pod"
];


support_vehicles_west = [
	["UK3CB_CHD_O_Kamaz_Ammo",5,200,10,GRLIB_perm_inf],
	["UK3CB_CHD_O_Kamaz_Fuel",5,200,10,GRLIB_perm_inf],
	["UK3CB_CHD_O_Kamaz_Repair",5,200,10,GRLIB_perm_inf],
	["UK3CB_CHD_O_Gaz66_Med",5,200,10,GRLIB_perm_inf]
];


buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_inf],
	["Flag_CHD_Red_Star",0,0,0,0]
];

blufor_squad_inf_light = [
	"UK3CB_CHD_O_TL",
	"UK3CB_CHD_O_RIF_1",
	"UK3CB_CHD_O_MD",
	"UK3CB_CHD_O_MK"
];

blufor_squad_inf = [
	"UK3CB_CHD_O_TL",
	"UK3CB_CHD_O_RIF_1",
	"UK3CB_CHD_O_MD",
	"UK3CB_CHD_O_RIF_2",
	"UK3CB_CHD_O_MK",
	"UK3CB_CHD_O_MG",
	"UK3CB_CHD_O_AR",
	"UK3CB_CHD_O_ENG"
];

blufor_squad_at = [
	"UK3CB_CHD_O_SL",
	"UK3CB_CHD_O_RIF_1",
	"UK3CB_CHD_O_MD",
	"UK3CB_CHD_O_AT",
	"UK3CB_CHD_O_AT",
	"UK3CB_CHD_O_AT_ASST",
	"UK3CB_CHD_O_AR"
];

blufor_squad_aa = [
	"UK3CB_CHD_O_SL",
	"UK3CB_CHD_O_RIF_1",
	"UK3CB_CHD_O_MD",
	"UK3CB_CHD_O_AR",
	"UK3CB_CHD_O_AA",
	"UK3CB_CHD_O_AA",
	"UK3CB_CHD_O_AA_ASST"
];

blufor_squad_mix = [
	"UK3CB_CHD_O_SL",
	"UK3CB_CHD_O_RIF_1",
	"UK3CB_CHD_O_MD",
	"UK3CB_CHD_O_ENG",
	"UK3CB_CHD_O_MG",
	"UK3CB_CHD_O_AT",
	"UK3CB_CHD_O_AA",
	"UK3CB_CHD_O_GL"
];

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,450,0,GRLIB_perm_max],
	[blufor_squad_at,25,500,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,30,750,0,GRLIB_perm_max]
];

// bis hier her

// All the UAVs must be declared here
uavs = [
	"rhs_pchela1t_vvsc"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
	"UK3CB_CHD_O_Kamaz_Repair",
	"UK3CB_CHD_O_Kamaz_Fuel"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"UK3CB_CHD_O_Gaz66_Med"
];

vehicle_rearm_sources_west = [
	"UK3CB_CHD_O_Kamaz_Ammo","UK3CB_CHD_O_Kamaz_Fuel"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];

GRLIB_AirDrop_1 = [		// cost = 50 Unarmed Offroad
	"UK3CB_CHD_O_Hilux_Closed"
];

GRLIB_AirDrop_2 = [		// cost 100 Armed Offroader
	"UK3CB_CHD_O_Hilux_Dshkm"
];

GRLIB_AirDrop_3 = [		// cost 200 MRAPs (Mine Resistant Ambush Protected Vehicle)
	"UK3CB_CHD_O_BRDM2"
];

GRLIB_AirDrop_4 = [		// cost 300 Large Truck
	"UK3CB_CHD_O_Kamaz_Covered"
];

GRLIB_AirDrop_5 = [		// cost 750 APC (Armoured personnel carrier)
	"UK3CB_CHD_O_BTR60"
];


GRLIB_AirDrop_6 = [		// cost 250 Boat
	"UK3CB_CHD_O_Small_Boat_Open"
];



