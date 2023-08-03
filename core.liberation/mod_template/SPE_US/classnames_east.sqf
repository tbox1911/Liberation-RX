// *** BADDIES ***
GRLIB_side_enemy = INDEPENDENT;
GRLIB_east_modder = "Z@Warrior";

// All class MUST be defined !

opfor_sentry = "SPE_US_Rifleman";
opfor_rifleman = "SPE_US_Assist_SquadLead";
opfor_grenadier = "SPE_US_Grenadier";
opfor_squad_leader = "SPE_US_SquadLead";
opfor_team_leader = "SPE_US_Second_Lieutenant";
opfor_marksman = "SPE_US_Flamethrower_Operator";
opfor_machinegunner = "SPE_US_HMGunner";
opfor_heavygunner = "SPE_US_Autorifleman";
opfor_medic = "SPE_US_Medic";
opfor_rpg = "SPE_US_AT_Soldier";
opfor_at = "SPE_US_AT_Soldier";
opfor_aa = "SPE_US_Autorifleman";
opfor_officer = "SPE_US_Captain";
opfor_sharpshooter = "SPE_US_Sniper";
opfor_sniper = "SPE_US_Sniper";
opfor_spotter = "SPE_US_Sniper";
opfor_engineer = "SPE_US_Engineer";
opfor_paratrooper = "SPE_US_Rangers_grenadier";
opfor_mrap = "SPE_US_M3_Halftrack_Unarmed_Open";
opfor_mrap_hmg = "SPE_US_M3_Halftrack";
opfor_mrap_gmg = "SPE_US_M3_Halftrack";
opfor_transport_helo = "SPE_P47";		// no Helo
opfor_transport_truck = "SPE_US_M3_Halftrack_Unarmed";
opfor_fuel_truck = "SPE_US_M3_Halftrack_Fuel";
opfor_ammo_truck = "SPE_US_M3_Halftrack_Ammo";
opfor_fuel_container = "B_Slingload_01_Fuel_F";
opfor_ammo_container = "B_Slingload_01_Ammo_F";
opfor_flag = "SPE_FlagCarrier_USA";
opfor_house = "Land_SPE_Barn_Thatch_02";
opfor_patrol = "Land_SPE_Barn_Thatch_02";
opfor_hq = "Land_SPE_House_Thatch_03";

// Additional Airplanes from Secret Weapons
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  opfor_transport_helo = ["sab_sw_b17"];
};

militia_squad = [
	"SPE_US_Rangers_rifleman",
	"SPE_US_Rangers_captain",
	"SPE_US_Rangers_grenadier",
	"SPE_US_Rangers_SquadLead",
	"SPE_US_Rangers_second_lieutenant",
	"SPE_US_Rangers_medic",
	"SPE_US_Rangers_radioman",
	"SPE_US_Rangers_HMGunner",
	"SPE_US_Rangers_AT_soldier",
	"SPE_US_Rangers_Rifleman_AmmoBearer",
	"SPE_US_Rangers_Assist_SquadLead",
	"SPE_US_Rangers_first_lieutenant"
];

militia_loadout_overide = [
];

divers_squad = [
	"I_diver_F",
	"I_diver_F",
	"I_diver_F",
	"I_diver_F"
];

militia_vehicles = [
	"SPE_US_M3_Halftrack_Unarmed_Open",
	"SPE_US_M3_Halftrack",
	"SPE_US_M3_Halftrack",
	"SPE_US_M3_Halftrack",
	"SPE_US_M16_Halftrack",
	"SPE_M4A0_75_Early"
];

opfor_boats = [
	"I_G_Boat_Transport_01_F"
];

opfor_vehicles = [
	"SPE_US_M16_Halftrack",
	"SPE_US_M3_Halftrack_Unarmed_Open",
	"SPE_US_M3_Halftrack",
	"SPE_US_M3_Halftrack_Unarmed",
	"SPE_M10_DLV",
	"SPE_M18_Hellcat_DLV",
	"SPE_M4A0_75_Early_DLV",
	"SPE_M4A0_75_DLV",
	"SPE_M4A1_76_DLV",
	"SPE_M4A1_75_DLV",
	"SPE_M4A1_T34_Calliope_Direct_DLV",
	"SPE_M4A1_T34_Calliope_DLV"
];

opfor_vehicles_low_intensity = [
	"SPE_US_M16_Halftrack",
	"SPE_US_M3_Halftrack",
	"SPE_US_M3_Halftrack_Unarmed_Open",
	"SPE_M4A0_75_Early_DLV",
	"SPE_M10_DLV"
];

opfor_battlegroup_vehicles = [
	"SPE_US_M16_Halftrack",
	"SPE_US_M3_Halftrack",
	"SPE_US_M3_Halftrack_Unarmed_Open",
	"SPE_M4A0_75_Early_DLV",
	"SPE_M10_DLV",
	"SPE_M4A1_T34_Calliope_Direct_DLV",
	"SPE_M4A1_T34_Calliope_DLV",
	"SPE_M4A1_75_DLV",
	"SPE_M4A0_75_Early_DLV",
	"SPE_M18_Hellcat_DLV",
	"SPE_US_M3_Halftrack_Repair",
	"SPE_US_M3_Halftrack_Ammo"
];

opfor_battlegroup_vehicles_low_intensity = [
	"SPE_US_M16_Halftrack",
	"SPE_US_M3_Halftrack",
	"SPE_US_M3_Halftrack_Unarmed_Open",
	"SPE_M4A0_75_Early_DLV",
	"SPE_M10_DLV",
	"SPE_M4A1_75_DLV",
	"SPE_M18_Hellcat_DLV"
];

opfor_troup_transports_truck = [
	"SPE_US_M3_Halftrack_Unarmed_Open",
	"SPE_US_M3_Halftrack_Unarmed"
];

opfor_troup_transports_heli = [
	"SPE_P47"
];

// Additional Airplanes from Secret Weapons
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
  opfor_troup_transports_heli = ["sab_sw_b17"];
};

opfor_air = [
	"SPE_P47"
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
	opfor_air pushBack "sab_fl_f4u";
	opfor_air pushBack "sab_fl_p51d";
	opfor_air pushBack "sab_fl_sbd";
};

// Additional Airplanes from Secret Weapons (requ. Flying Legends)
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
	opfor_air pushBack "sab_sw_p38";
	opfor_air pushBack "sab_sw_p40";
	opfor_air pushBack "sab_sw_a26";
	opfor_air pushBack "sab_sw_tbf";
	opfor_air pushBack "sab_sw_b17";
};

opfor_statics = [
	"SPE_57mm_M1",
	"SPE_M1_81",
	"SPE_M1919_M2",
	"SPE_M45_Quadmount",
	"SPE_M1919_M2_Trench_Deployed"
];


opfor_recyclable = [
	["SPE_57mm_M1",0,round (20 / GRLIB_recycling_percentage),0],
	["SPE_M1_81",0,round (30 / GRLIB_recycling_percentage),0],
	["SPE_M1919_M2",0,round (30 / GRLIB_recycling_percentage),0],
	["SPE_M1919_M2_Trench_Deployed",0,round (30 / GRLIB_recycling_percentage),0],
	["SPE_M1919A6_Bipod",0,round (45 / GRLIB_recycling_percentage),0],
	["SPE_M45_Quadmount",0,round (50 / GRLIB_recycling_percentage),0],
	//
	["I_C_Boat_Transport_01_F",1,round (12 / GRLIB_recycling_percentage),3],
	//
	["SPE_US_M16_Halftrack",2,round (40 / GRLIB_recycling_percentage),4],
	["SPE_US_M3_Halftrack_Ambulance",2,round (50 / GRLIB_recycling_percentage),4],
	["SPE_US_M3_Halftrack_Ammo",2,round (60 / GRLIB_recycling_percentage),4],
	["SPE_US_M3_Halftrack_Repair",4,round (150 / GRLIB_recycling_percentage),4],
	["SPE_US_M3_Halftrack_Fuel",2,round (25 / GRLIB_recycling_percentage),4],
	["SPE_US_M3_Halftrack_Unarmed",2,round (35 / GRLIB_recycling_percentage),4],
	["SPE_US_M3_Halftrack_Unarmed_Open",2,round (60 / GRLIB_recycling_percentage),4],
	["SPE_US_M3_Halftrack",2,round (50 / GRLIB_recycling_percentage),4],
	//
	["SPE_M10",3,round (50 / GRLIB_recycling_percentage),6],
	["SPE_M18_Hellcat",3,round (75 / GRLIB_recycling_percentage),6],
	["SPE_M4A0_75_Early",3,round (75 / GRLIB_recycling_percentage),6],
	["SPE_M4A0_75",3,round (75 / GRLIB_recycling_percentage),6],
	["SPE_M4A1_76",5,round (125 / GRLIB_recycling_percentage),15],
	["SPE_M4A1_75",5,round (125 / GRLIB_recycling_percentage),15],
	["SPE_M4A1_T34_Calliope_Direct",7,round (250 / GRLIB_recycling_percentage),20],
	["SPE_M4A1_T34_Calliope",7,round (250 / GRLIB_recycling_percentage),20],
	//
	["SPE_P47",6,round (250 / GRLIB_recycling_percentage),14]
];

// Additional Airplanes from Mod Flying Legends
if (isClass(configFile >> "CfgPatches" >> "sab_flyinglegends")) then {
    opfor_recyclable pushBack ["sab_fl_f4u",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_fl_p51d",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_fl_sbd",10,round (200 / GRLIB_recycling_percentage),15];
};

// Additional Airplanes from Mod Secret Weapons
if (isClass(configFile >> "CfgPatches" >> "sab_sw_a26")) then {
    opfor_recyclable pushBack ["sab_sw_p38",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_sw_p40",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_sw_a26",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_sw_tbf",10,round (200 / GRLIB_recycling_percentage),15];
    opfor_recyclable pushBack ["sab_sw_b17",10,round (200 / GRLIB_recycling_percentage),15];
};
