diag_log "--- Liberation RX by pSiKO ---";
[] call compileFinal preprocessFileLineNUmbers "build_info.sqf";
diag_log "--- Init start ---";
titleText ["Loading...","BLACK FADED", 100];

enableSaving [false, false];
disableMapIndicators [false,true,false,false];
setGroupIconsVisible [false,false];

abort_loading = false;
abort_loading_msg = "Unkwon Error";
GRLIB_ACE_enabled = false;
[] call compileFinal preprocessFileLineNUmbers "whitelist.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\fetch_params.sqf";

if (!abort_loading) then {
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames.sqf";
	[] call compileFinal preprocessfilelinenumbers "scripts\shared\init_shared.sqf";
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\init_sectors.sqf";
	if (!GRLIB_ACE_enabled) then {[] execVM "R3F_LOG\init.sqf"};

	if (isServer) then {
		[] execVM "scripts\server\init_server.sqf";
	};

	if (!isDedicated && !hasInterface && isMultiplayer) then {
		[] execVM "scripts\server\offloading\hc_manager.sqf";
	};
} else {
	GRLIB_init_server = false;
	publicVariable "GRLIB_init_server";
	publicVariable "abort_loading";
	publicVariable "abort_loading_msg";
};

if (!isDedicated && hasInterface) then {
	[] execVM "scripts\client\init_client.sqf";
} else {
	setViewDistance 1600;
	setTerrainGrid 50;
};




// MilSim United ===========================================================================

["CargoNet_01_box_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle,2] call ace_cargo_fnc_setSpace;
	["ACE_Wheel", _vehicle] call ace_cargo_fnc_addCargoItem;
	["ACE_Track", _vehicle] call ace_cargo_fnc_addCargoItem;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable; 
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable; 
	_vehicle setVariable ["ACE_isRepairFacility",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_CargoNet_01_ammo_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle, 150000] call ace_rearm_fnc_makeSource;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CargoNet_01_barrels_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
    [_vehicle, 15000] call ace_refuel_fnc_makeSource;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Box_NATO_AmmoVeh_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Box_East_AmmoVeh_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Box_IND_AmmoVeh_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Land_BarrelWater_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Land_MetalBarrel_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Land_FoodSacks_01_large_brown_idap_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_Slingload_01_Medevac_F", "InitPost", {
    params ["_vehicle"];
	clearItemCargoGlobal _vehicle;
	_vehicle addAction	["Endheilen",{ params ["_target", "_caller", "_actionId", "_arguments"]; [_caller,true] execVM "MilSimUnited\heal.sqf";},nil,1.5,false,true,"","true",5,false,"",""];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_Slingload_01_Ammo_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle, 1000000] call ace_rearm_fnc_makeSource;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhsusf_M977A4_AMMO_BKIT_usarmy_wd", "InitPost", {
    params ["_vehicle"];
	[_vehicle, 150000] call ace_rearm_fnc_makeSource;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhsusf_M977A4_AMMO_BKIT_usarmy_d", "InitPost", {
    params ["_vehicle"];
	[_vehicle, 150000] call ace_rearm_fnc_makeSource;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhs_kamaz5350_ammo_vmf", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	[_vehicle, 150000] call ace_rearm_fnc_makeSource;
    [_vehicle, 15000] call ace_refuel_fnc_makeSource;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhsusf_M1078A1P2_WD_flatbed_fmtv_usarmy", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhs_kamaz5350_open_msv", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["UK3CB_BAF_Husky_Passenger_HMG_Green_DPMW", "InitPost", {
    params ["_vehicle"];
	[_vehicle,4] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["RHS_MELB_MH6M", "InitPost", {
    params ["_vehicle"];
	[_vehicle,4] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["RHS_MELB_AH6M", "InitPost", {
    params ["_vehicle"];
	[_vehicle,4] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhsusf_M977A4_BKIT_M2_usarmy_wd", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_Heli_Transport_03_unarmed_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	[
		_vehicle,
		["Green",1], 
		true
	] call BIS_fnc_initVehicle;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["RHS_CH_47F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	[
		_vehicle,
		["Green",1], 
		true
	] call BIS_fnc_initVehicle;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["RHS_Mi8mt_vdv", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	[
		_vehicle,
		["Green",1], 
		true
	] call BIS_fnc_initVehicle;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["RHS_UH60M", "InitPost", {
    params ["_vehicle"];
	[_vehicle,4] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["RHS_Mi8MTV3_heavy_vdv", "InitPost", {
    params ["_vehicle"];
	[_vehicle,4] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["UK3CB_BAF_Merlin_HC3_CSAR_DPMW_RM", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["UK3CB_BAF_MAN_HX58_Cargo_Green_A_DPMW_RM", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_Boat_Transport_01_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,3] call ace_cargo_fnc_setSize;
	[_vehicle,3] call ace_cargo_fnc_setSpace;
	[_vehicle, true, [0, 3, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 3, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["I_C_Boat_Transport_02_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,4] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_Boat_Armed_01_minigun_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,4] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhsusf_mkvsoc", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["O_T_MBT_04_command_F", "InitPost", {
    params ["_vehicle"];
	[
	_vehicle,
		["Jungle",1], 
		["showCamonetHull",0,"showCamonetTurret",0]
	] call BIS_fnc_initVehicle;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhs_btr80a_msv", "InitPost", {
    params ["_vehicle"];
	_vehicle addEventHandler ["HandleDamage", {  
		private _unit = _this select 0;
		private _hitSelection = _this select 1;
		private _damage = _this select 2;
		if (_hitSelection isEqualTo "") then {(damage _unit) + (_damage * 0.04)} else {(_unit getHit _hitSelection) + (_damage * 0.04)};
	}];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["O_T_APC_Tracked_02_cannon_ghex_F", "InitPost", {
    params ["_vehicle"];
	_vehicle addEventHandler ["HandleDamage", {  
		private _damage = _this select 2;
		_damage = _damage * 1.25;
		_damage;
	}];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["I_LT_01_cannon_F", "InitPost", {
    params ["_vehicle"];
	_vehicle setObjectTextureGlobal [0,"A3\armor_f_tank\lt_01\data\lt_01_main_olive_co.paa"];
	_vehicle setObjectTextureGlobal [1,"A3\armor_f_tank\lt_01\data\lt_01_cannon_olive_co.paa"];
	_vehicle setObjectTextureGlobal [2,"A3\Armor_F\Data\camonet_aaf_digi_green_co.paa"];
	_vehicle setObjectTextureGlobal [3,"A3\armor_f\data\cage_olive_co.paa"];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["I_LT_01_AT_F", "InitPost", {
    params ["_vehicle"];
	_vehicle setObjectTextureGlobal [0,"A3\armor_f_tank\lt_01\data\lt_01_main_olive_co.paa"];
	_vehicle setObjectTextureGlobal [1,"A3\armor_f_tank\lt_01\data\lt_01_at_olive_co.paa"];
	_vehicle setObjectTextureGlobal [2,"A3\Armor_F\Data\camonet_aaf_digi_green_co.paa"];
	_vehicle setObjectTextureGlobal [3,"A3\armor_f\data\cage_olive_co.paa"];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["I_LT_01_AA_F", "InitPost", {
    params ["_vehicle"];
	_vehicle setObjectTextureGlobal [0,"A3\armor_f_tank\lt_01\data\lt_01_main_olive_co.paa"];
	_vehicle setObjectTextureGlobal [1,"A3\armor_f_tank\lt_01\data\lt_01_at_olive_co.paa"];
	_vehicle setObjectTextureGlobal [2,"A3\Armor_F\Data\camonet_aaf_digi_green_co.paa"];
	_vehicle setObjectTextureGlobal [3,"A3\armor_f\data\cage_olive_co.paa"];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Box_NATO_Equip_F", "InitPost", {
    params ["_vehicle"];
	clearItemCargoGlobal _vehicle;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;


["rhsusf_socom_marsoc_sarc", "InitPost", {
	params ["_vehicle"];
	if (!local _vehicle) exitWith {};
	
	_vehicle setSpeaker "NoVoice";
	_vehicle setUnitTrait ["Medic",true];
	_vehicle setUnitTrait ["Engineer",true];
	_vehicle setUnitTrait ["explosiveSpecialist",true];
	_vehicle setVariable ["ACE_medical_medicClass", 1];
	_vehicle setVariable ["ACE_isEngineer", 1];
	_vehicle setUnitAbility 2;
	_vehicle setVariable ["ACE_CanSwitchUnits", true];
	
	removeHeadgear _vehicle;
	removeBackpack _vehicle;
	
	_vehicle addPrimaryWeaponItem "rhsusf_acc_rotex5_grey";

	_vehicle addBackpack "B_Kitbag_cbr";
	for "_i" from 1 to 4 do {_vehicle addItemToBackpack "ACE_tourniquet";};
	for "_i" from 1 to 2 do {_vehicle addItemToBackpack "ACE_splint";};
	for "_i" from 1 to 20 do {_vehicle addItemToBackpack "ACE_packingBandage";};
	for "_i" from 1 to 10 do {_vehicle addItemToBackpack "ACE_salineIV";};
	for "_i" from 1 to 10 do {_vehicle addItemToBackpack "ACE_epinephrine";};
	_vehicle addItemToBackpack "ACE_surgicalKit";
	_vehicle addHeadgear "rhsusf_mich_bare_norotos_arc_alt_headset";
	
	_vehicle linkItem "NVGoggles_OPFOR";
}, nil, nil, true] call CBA_fnc_addClassEventHandler;


["BWA3_Medic_Fleck", "InitPost", {
	params ["_vehicle"];
	if (!local _vehicle) exitWith {};
	
	_vehicle setSpeaker "NoVoice";
	_vehicle setUnitTrait ["Medic",true];
	_vehicle setUnitTrait ["Engineer",true];
	_vehicle setUnitTrait ["explosiveSpecialist",true];
	_vehicle setVariable ["ACE_medical_medicClass", 1];
	_vehicle setVariable ["ACE_isEngineer", 1];
	_vehicle setUnitAbility 2;
	_vehicle setVariable ["ACE_CanSwitchUnits", true];
	
	_vehicle addPrimaryWeaponItem "rhsusf_acc_rotex5_grey";
	
	removeHeadgear _vehicle;
	for "_i" from 1 to 4 do {_vehicle addItemToBackpack "ACE_tourniquet";};
	for "_i" from 1 to 2 do {_vehicle addItemToBackpack "ACE_splint";};
	for "_i" from 1 to 20 do {_vehicle addItemToBackpack "ACE_packingBandage";};
	for "_i" from 1 to 10 do {_vehicle addItemToBackpack "ACE_salineIV";};
	for "_i" from 1 to 10 do {_vehicle addItemToBackpack "ACE_epinephrine";};
	_vehicle addItemToBackpack "ACE_surgicalKit";
	_vehicle addHeadgear "Helmet_SF_flecktarn";
}, nil, nil, true] call CBA_fnc_addClassEventHandler;


["rhs_msv_emr_medic", "InitPost", {
	params ["_vehicle"];
	if (!local _vehicle) exitWith {};
	
	_vehicle setSpeaker "NoVoice";
	_vehicle setUnitTrait ["Medic",true];
	_vehicle setUnitTrait ["Engineer",true];
	_vehicle setUnitTrait ["explosiveSpecialist",true];
	_vehicle setVariable ["ACE_medical_medicClass", 1];
	_vehicle setVariable ["ACE_isEngineer", 1];
	_vehicle setUnitAbility 2;
	_vehicle setVariable ["ACE_CanSwitchUnits", true];
	
	_vehicle addPrimaryWeaponItem "rhs_acc_dtk4short";
	
	_vehicle addVest "rhs_6b45_rifleman";
	for "_i" from 1 to 5 do {_vehicle addItemToVest "rhs_30Rnd_545x39_7N10_AK";};
	_vehicle addItemToVest "rhs_mag_rgn";
	
	removeBackpack _vehicle;
	_vehicle addBackpack "rhs_rk_sht_30_emr_medic";
	for "_i" from 1 to 4 do {_vehicle addItemToBackpack "ACE_tourniquet";};
	for "_i" from 1 to 2 do {_vehicle addItemToBackpack "ACE_splint";};
	for "_i" from 1 to 20 do {_vehicle addItemToBackpack "ACE_packingBandage";};
	for "_i" from 1 to 10 do {_vehicle addItemToBackpack "ACE_salineIV";};
	for "_i" from 1 to 10 do {_vehicle addItemToBackpack "ACE_epinephrine";};
	_vehicle addItemToBackpack "ACE_surgicalKit";
	
	_vehicle linkItem "NVGoggles_OPFOR";
}, nil, nil, true] call CBA_fnc_addClassEventHandler;


// Advanced Singloading
ASL_SLING_RULES_OVERRIDE = [ 
	["Air", "CAN_SLING", "All"]
];
// ["Air", "CANT_SLING", "Tank"],

// Advanced Towing
SA_MAX_TOWED_CARGO = 1;
SA_TOW_RULES_OVERRIDE =[
	["All", "CAN_TOW", "All"]
];
// ["Car", "CANT_TOW", "Tank"],
// ["Air", "CANT_TOW", "Air"]


//[AiCacheDistance(players),TargetFPS(-1 for Auto),Debug,CarCacheDistance,AirCacheDistance,BoatCacheDistance]execvm "zbe_cache\main.sqf";
// if (isServer) then {[2000,-1,false,100,1000,100]execvm "zbe_cache\main.sqf"};


// MilSim United ===========================================================================





diag_log "--- Init stop ---";
