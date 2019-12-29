// This file allows you to add content to the mission without conflict issues after each update of the original classnames.sqf
// If you want more modifications to be supported by this file, let's discuss it on the forums.



// *** SUPPORT STUFF ***

// Setting a value here will overwrite the original value found from the mission. Do that if you're doing a total conversion.
// Each of these should be unique, the same classnames for different purposes may cause various unpredictable issues with player actions. Or not. Just don't try.
FOB_typename = nil;						// Default "Land_Cargo_HQ_V1_F";
FOB_box_typename = nil;					// Default "B_Slingload_01_Cargo_F";
FOB_truck_typename = nil;				// Default "B_Truck_01_box_F";
Arsenal_typename = nil;					// Default "B_supplyCrate_F";
Respawn_truck_typename = nil;			// Default "B_Truck_01_medical_F";
huron_typename = nil;					// Default "B_Heli_Transport_03_unarmed_F";
ammobox_b_typename = nil;				// Default "Box_NATO_AmmoVeh_F";
ammobox_o_typename = nil;				// Default "Box_East_AmmoVeh_F";
ammobox_i_typename = nil;				// Default "Box_IND_AmmoVeh_F";
opfor_ammobox_transport = nil;			// Default "O_Truck_03_transport_F";    // Make sure this thing can transport ammo boxes (see box_transport_config down below) otherwise things will break
commander_classname = nil;				// Default "B_officer_F"
crewman_classname = nil;				// Default "B_crew_F";
pilot_classname = nil;					// Default "B_Helipilot_F";





// *** FRIENDLIES ***

// Each array below represents one page of the build menu
// Format : [ "classname", manpower, ammo, fuel ]
// Example : [ "B_APC_Tracked_01_AA_F", 0, 40, 15 ],

// If overwrite is set to true, then the extension list will entirely replace the original list defined in classnames.sqf. Otherwise it will be appended to it.
// Useful for total conversions to RHS and such, without having to alter the original file.
infantry_units_overwrite = false;
infantry_units_extension = [
];

light_vehicles_overwrite = false;
light_vehicles_extension = [
];

heavy_vehicles_overwrite = false;
heavy_vehicles_extension = [
];

air_vehicles_overwrite = false;
air_vehicles_extension = [
];

static_vehicles_overwrite = false;
static_vehicles_extension = [
];

buildings_overwrite = false;
buildings_extension = [
];

support_vehicles_overwrite = false;		// If you're going to overwrite this, make sure you have at least Arsenal_typename, Respawn_truck_typename, FOB_box_typename and FOB_truck_typename in there
support_vehicles_extension = [
];

// All the UAVs must be declared here, otherwise there shall be UAV controlling issues. Namely: you won't be able to control them.
uavs = [
];

// Pre-made squads for the commander build menu. These shouldn't exceed 10 members.
// Light infantry squad
blufor_squad_inf_light = [
];

// Heavy infantry squad
blufor_squad_inf = [
];

// AT specialists squad
blufor_squad_at = [
];

// AA specialists squad
blufor_squad_aa = [
];

// Force recon squad
blufor_squad_recon = [
];

// Paratroopers squad
blufor_squad_para = [
];


// *** BADDIES ***

// All OPFOR infantry. Defining a value here will replace the default value from the original mission.
opfor_sentry = nil;
opfor_rifleman = nil;
opfor_grenadier = nil;
opfor_squad_leader = nil;
opfor_team_leader = nil;
opfor_marksman = nil;
opfor_machinegunner = nil;
opfor_heavygunner = nil;
opfor_medic = nil;
opfor_rpg = nil;
opfor_at = nil;
opfor_aa = nil;
opfor_officer = nil;
opfor_sharpshooter = nil;
opfor_sniper = nil;
opfor_engineer = nil;
opfor_paratrooper = nil;

// OPFOR Vehicles to be used in secondary objectives
opfor_mrap = nil;
opfor_mrap_armed = nil;
opfor_transport_helo = nil;
opfor_transport_truck = nil;
opfor_fuel_truck = nil;
opfor_ammo_truck = nil;
opfor_fuel_container = nil;
opfor_ammo_container = nil;
opfor_flag = nil;

// Militia infantry. Soldier classnames the game will pick from randomly
militia_squad_overwrite = false;
militia_squad_extension = [
];

// Militia vehicles to choose from
militia_vehicles_overwrite = false;
militia_vehicles_extension = [
];

// All the vehicles that can spawn as sector defenders and patrols
opfor_vehicles_overwrite = false;
opfor_vehicles_extension = [
];

// Same with lighter choices to be used  when the alert level is low
opfor_vehicles_low_intensity_overwrite = false;
opfor_vehicles_low_intensity_extension = [
];

// All the vehicles that can spawn as battlegroup members
opfor_battlegroup_vehicles_overwrite = false;
opfor_battlegroup_vehicles_extension = [
];

// Same with lighter choices to be used  when the alert level is low
opfor_battlegroup_vehicles_low_intensity_overwrite = false;
opfor_battlegroup_vehicles_low_intensity_extension = [
];

// All the vehicles that can spawn as battlegroup members (see above) and also hold 8 soldiers as passengers.
// If something in here can't hold all 8 soldiers then buggy behaviours may occur
opfor_troup_transports_overwrite = false;
opfor_troup_transports_extension = [
];

// Battlegroup members that will need to spawn in flight. Should be only helos but, who knows
opfor_choppers_overwrite = false;
opfor_choppers_extension = [
];

// Opfor military aircrafts
opfor_air_overwrite = false;
opfor_air_extension = [
];


// Other stuff

// civilians
civilians_overwrite = false;
civilians_extension = [
];

// civilian vehicles
civilian_vehicles_overwrite = false;
civilian_vehicles_extension = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_extension = [
];

// Everything that can resupply other vehicles
vehicle_repair_sources_extension = [
];
vehicle_rearm_sources_extension = [
];
vehicle_refuel_sources_extension = [
];

// Elite vehicles that should be unlocked through military base capture.
elite_vehicles_extension = [
];

// Configuration for ammo boxes transport
// First entry: classname
// Second entry: how far behind the vehicle the boxes should be unloaded
// Following entries: attachTo position for each box, the number of boxes that can be loaded is derived from the number of entries
box_transport_config_extension = [
	[ "greuh_eh101_gr", -6.5, [0,	4.2,	-1.45], [0,	2.5,	-1.45], [0,	0.8, -1.45], [0,	-0.9, -1.45] ]
];

//Blacklist
#include "addons\LARs\liberationBlacklist.sqf"