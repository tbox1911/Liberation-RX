diag_log "--- Liberation RX by pSiKO ---";
// [] call compileFinal preprocessFileLineNUmbers "build_info.sqf";
diag_log "--- Init start ---";
titleText ["Loading...","BLACK FADED", 100];

enableSaving [false, false];
disableMapIndicators [true,true,false,false];
setGroupIconsVisible [false,false];

abort_loading = false;
abort_loading_msg = "Unkwon Error";
GRLIB_ACE_enabled = false;
[] call compileFinal preprocessFileLineNUmbers "whitelist.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNUmbers "scripts\shared\fetch_params.sqf";

[] spawn VCM_fnc_VcomInit;

if (!abort_loading) then {
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\classnames.sqf";
	[] call compileFinal preprocessfilelinenumbers "scripts\shared\init_shared.sqf";
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\init_sectors.sqf";
	if (!GRLIB_ACE_enabled) then {[] execVM "R3F_LOG\init.sqf"};

		if (isServer) then {

		[] execVM "scripts\server\init_server.sqf";

		//Tkill with diag.
		if (isNil 'tk_init_allowed') then {tk_init_allowed = false};
		
		if (tk_init_allowed) then {
		["ace_unconscious", {
		params ["_unit", "_state"];
		
		if (isNil 'tk_active') then {tk_active = false};
		if ((tk_active) && (_state) && (isPlayer _unit)) then {[_state,_unit]execVM "MilSimUnited\tkill.sqf"}}] call CBA_fnc_addEventHandler;
		}
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


SNC_VehRestriction= true;

// MilSim United ===========================================================================
if (isNil "tkill_script") then {tkill_script = false};

if (tkill_script) then {
["B_Soldier_F", "InitPost", {
	params ["_vehicle"];
	_vehicle addEventHandler ["Dammaged", {
		params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
		if ( (isPlayer _shooter) && (_shooter != _unit) && (alive _unit) ) then {
			_msg = format ["Friendly fire from %1 to %2. Penalty: %3 rank and %4 ammo", name _shooter, name _unit, tkill_score, tkill_ammo];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			[getPlayerUID _shooter, tkill_score] remoteExec ["F_addPlayerScore", 2];
			[getPlayerUID _shooter, tkill_ammo] remoteExec ["F_addPlayerAmmo", 2];
			
		};
	}];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_medic_F", "InitPost", {
	params ["_vehicle"];
	_vehicle addEventHandler ["Dammaged", {
		params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
		if ( (isPlayer _shooter) && (_shooter != _unit) && (alive _unit) ) then {
			_msg = format ["Friendly fire from %1 to %2. Penalty: %3 rank and %4 ammo", name _shooter, name _unit, tkill_score, tkill_ammo];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			[getPlayerUID _shooter, tkill_score] remoteExec ["F_addPlayerScore", 2];
			[getPlayerUID _shooter, tkill_ammo] remoteExec ["F_addPlayerAmmo", 2];
		};
	}];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_GER_Operator_Medic", "InitPost", {
	params ["_vehicle"];
	_vehicle addEventHandler ["Dammaged", {
		params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];
		if ( (isPlayer _shooter) && (_shooter != _unit) && (alive _unit) ) then {
			_msg = format ["Friendly fire from %1 to %2. Penalty: %3 rank and %4 ammo", name _shooter, name _unit, tkill_score, tkill_ammo];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			[getPlayerUID _shooter, tkill_score] remoteExec ["F_addPlayerScore", 2];
			[getPlayerUID _shooter, tkill_ammo] remoteExec ["F_addPlayerAmmo", 2];
		};
	}];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;
};

["CargoNet_01_box_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,8] call ace_cargo_fnc_setSize;
	[_vehicle,4] call ace_cargo_fnc_setSpace;
	["ACE_Wheel", _vehicle] call ace_cargo_fnc_addCargoItem;
	["ACE_Track", _vehicle] call ace_cargo_fnc_addCargoItem;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable; 
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable; 
	_vehicle setVariable ["ACE_isRepairFacility",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_CargoNet_01_ammo_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,8] call ace_cargo_fnc_setSize;
	[_vehicle,4] call ace_cargo_fnc_setSpace;
	[_vehicle, 150000] call ace_rearm_fnc_makeSource;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CargoNet_01_barrels_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,8] call ace_cargo_fnc_setSize;
	[_vehicle,4] call ace_cargo_fnc_setSpace;
    [_vehicle, 15000] call ace_refuel_fnc_makeSource;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setCarryable;
	[_vehicle, true, [0, 1.5, 0], 0] call ace_dragging_fnc_setDraggable;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Land_MetalBarrel_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,4] call ace_cargo_fnc_setSize;
    [_vehicle, 3750] call ace_refuel_fnc_makeSource;
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
	_vehicle addAction	["Bereichsheilung",{ params ["_target", "_caller", "_actionId", "_arguments"]; [_caller,true] execVM "MilSimUnited\heal_aoe.sqf";},nil,1.5,false,true,"","true",5,false,"",""];
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



["BWA3_Multi_Fleck", "InitPost", {
    params ["_vehicle"];
	[_vehicle,2] call ace_cargo_fnc_setSpace;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["BWA3_WLP14_Flatbed_Oliv", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["BWA3_WLP14_Repair_Fleck", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["BWA3_WLP14_Ammo_Fleck", "InitPost", {
    params ["_vehicle"];
	[_vehicle,12] call ace_cargo_fnc_setSpace;
	_vehicle setVariable ["ACE_isRepairVehicle",1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;


// ACE Cargo definition

["rnt_mantis_radar", "InitPost", {
    params ["_vehicle"];
	[_vehicle, -1] call ace_cargo_fnc_setSize;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rnt_mantis_base", "InitPost", {
    params ["_vehicle"];
	[_vehicle, -1] call ace_cargo_fnc_setSize;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;


["CUP_B_CH47F_VIV_USA", "InitPost", {
    params ["_vehicle"];
	[_vehicle,24] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_CH47F_USA", "InitPost", {
    params ["_vehicle"];
	[_vehicle,24] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_MH47E_USA", "InitPost", {
    params ["_vehicle"];
	[_vehicle,24] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_CH53E_GER", "InitPost", {
    params ["_vehicle"];
	[_vehicle,30] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_CH53E_VIV_GER", "InitPost", {
    params ["_vehicle"];
	[_vehicle,30] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_MV22_USMC", "InitPost", {
    params ["_vehicle"];
	[_vehicle,40] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_MV22_VIV_USMC", "InitPost", {
    params ["_vehicle"];
	[_vehicle,40] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_MV22_USMC_RAMPGUN", "InitPost", {
    params ["_vehicle"];
	[_vehicle,40] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_T_VTOL_01_infantry_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,46] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_T_VTOL_01_vehicle_F", "InitPost", {
    params ["_vehicle"];
	[_vehicle,46] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["USAF_C130J_Cargo", "InitPost", {
    params ["_vehicle"];
	[_vehicle,50] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["USAF_C130J", "InitPost", {
    params ["_vehicle"];
	[_vehicle,40] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["USAF_C17", "InitPost", {
    params ["_vehicle"];
	[_vehicle,80] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;


// ACE Medical Vehicles


["CUP_B_FV432_GB_Ambulance", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["ffaa_et_lince_ambulancia", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["B_Truck_01_medical_F", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_LR_Ambulance_GB_D", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Redd_Tank_Fuchs_1A4_San_Tropentarn", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["ffaa_et_toa_ambulancia", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_UH60M_Unarmed_FFV_MEV_US", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_UH1Y_MEV_USMC", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_San", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["UK3CB_BAF_LandRover_Amb_FFR_Green_A", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_medical_medicClass", 1];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;





["O_Plane_Fighter_02_F", "initPost", {
   	params ["_vehicle"];
   	[
       	_vehicle,
       	["Su57_Style1", 1],
       	true
   	] call BIS_fnc_initvehicle;
   	_loadout_fighter = ["FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM7F_2_P_1rnd_M", "FIR_AIM7F_2_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M"];
   
   	{
       	vehicle _vehicle setPylonLoadout [_forEachindex, _x, true];
   	} forEach _loadout_fighter;

}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["O_Plane_CAS_02_Cluster_F", "initPost", {
   	params ["_vehicle"];
   	[
       	_vehicle,
       	["Su57_Style1", 1],
       	true
   	] call BIS_fnc_initvehicle;
   
   	_loadout_CAS = ["FIR_AIM120_P_1rnd_M", "CUP_PylonPod_1Rnd_R73_Vympel", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "FIR_AIM120_P_1rnd_M", "PylonRack_20Rnd_Rocket_03_HE_F", "CUP_PylonPod_1Rnd_R73_Vympel", "FIR_AIM120_P_1rnd_M"];
   
   	{
    	   vehicle _vehicle setPylonLoadout [_forEachindex, _x, true];
   	} forEach _loadout_CAS;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;



FIR_F16C = ["FIR_AIM120B_P_1rnd_M","FIR_AIM120_P_1rnd_M","FIR_AIM7F_2_P_1rnd_M","","FIR_GEPOD30_P_330rnd_M","FIR_SniperXR_HTS_P_1rnd_M",
"FIR_AIM9M_P_1rnd_M","FIR_AIM9X_P_1rnd_M","FIR_AIM132_P_1rnd_M","FIR_AGM88_P_1rnd_M","FIR_APKWS_P_19rnd_M","FIR_F16C_center_Fueltank_P_1rnd_M","FIR_APKWS_M282_P_7rnd_M","FIR_AGM65H_P_2rnd_M",
"FIR_AGM65D_P_2rnd_M","FIR_AGM65D_P_1rnd_M","FIR_AGM65H_P_2rnd_M","FIR_AGM65H_P_1rnd_M","FIR_AGM154C_P_1rnd_M","FIR_AGM65K_P_1rnd_M","FIR_AGM154A_P_1rnd_M",
"FIR_EGBU12_P_1rnd_M","FIR_EGBU12_P_2rnd_M","FIR_GBU10_PW1_P_1rnd_M","FIR_GBU10_P_1rnd_M",
"FIR_GBU12_P_2rnd_M","FIR_GBU12_P_1rnd_M","","","FIR_GBU24A_P_1rnd_M","FIR_GBU24A_BLU118_P_1rnd_M",
"FIR_GBU53_P_4rnd_M","FIR_F16C_Fueltank_P_1rnd_M","","","FIR_Zuni_P_8rnd_M","FIR_Hydra_M278_P_7rnd_M",
"FIR_CBU103_P_TripleRack_2rnd_M","FIR_CBU103_P_BRU57_2rnd_M","","","FIR_CBU105_P_BRU57_2rnd_M","FIR_CBU105_P_TripleRack_2rnd_M",
"FIR_AIM9L_P_1rnd_M","FIR_ACMI_CUBIC_P_1rnd_M","FIR_CBU87_P_1rnd_M","FIR_CBU97_P_1rnd_M","FIR_SniperXR_1_P_1rnd_M",
"FIR_Mk82_snakeye_P_1rnd_M","FIR_ACMI_TACTS_P_1rnd_M",
"FIR_Mk82_AIR_P_1rnd_M","FIR_CBU100_P_1rnd_M",
"FIR_AWW13_P_1rnd_M","FIR_Litening_P_1rnd_M","FIR_AGM65G_P_1rnd_M"];

["FIR_F16C", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist",FIR_F16C , true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;

ffaa_ea_ef18m =  ["PylonMissile_1Rnd_Missile_AA_04_F","FIR_AGM88_P_1rnd_M","FIR_AIM9X_LAU115_P_2rnd_M","PylonMissile_Missile_AMRAAM_C_x1","FIR_FA18_Fueltank_P_1rnd_M","FIR_AIM120_LAU115BA_P_2rnd_M","FIR_AIM120_LAU115_P_2rnd_M",
"FIR_AGM158B_P_1rnd_M","FIR_AGM123_P_1rnd_M","FIR_AGM65D_P_2rnd_M","FIR_AGM65H_P_2rnd_M",
"FIR_AGM84E_P_1rnd_M","PylonRack_Missile_AMRAAM_D_x2","","","","PylonRack_Missile_AMRAAM_C_x2","FIR_APKWS_M282_P_7rnd_M",
"FIR_GBU24A_P_1rnd_M","FIR_GBU12_P_2rnd_M","FIR_EGBU12_P_2rnd_M","FIR_APKWS_P_7rnd_M",
"CUP_PylonPod_2Rnd_AIM_120_AMRAAM_M","PylonRack_Missile_BIM9X_x1","FIR_AGM65D_P_2rnd_M","FIR_AIM120_LAU115_P_1rnd_M",
"FIR_AWW13_P_1rnd_M","PylonRack_Missile_AGM_02_x1",
"ffaa_ef18m_Fueltank_1rnd_M","FIR_AGM65D_P_1rnd_M","FIR_AGM65E_P_1rnd_M",
"FIR_AGM65E2_P_1rnd_M","FIR_AGM65F_P_1rnd_M","FIR_AGM65G_P_1rnd_M",
"FIR_AGM65H_P_1rnd_M","PylonMissile_Bomb_GBU12_x1","FIR_GBU16_Navy_P_1rnd_M",
"FIR_AGM154C_P_1rnd_M","FIR_AGM154A_P_1rnd_M"];

["ffaa_ea_ef18m", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", ffaa_ea_ef18m, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


I_Plane_Fighter_04_F = ["FIR_AIM9X_P_1rnd_M","FIR_IRIS_T_P_1rnd_M","FIR_AGM154A_P_1rnd_M",
"FIR_AGM154C_P_1rnd_M","FIR_GBU10_PW1_P_1rnd_M","PylonMissile_Bomb_GBU12_x1","FIR_AIM132_P_1rnd_M",
"FIR_AIM120_P_1rnd_M","FIR_GBU32_P_1rnd_M","FIR_GBU54_P_1rnd_M","FIR_Meteor_P_1rnd_M",
"FIR_AGM65H_P_1rnd_M","FIR_AGM65K_P_1rnd_M","FIR_AGM65D_P_1rnd_M","PylonRack_Missile_AGM_02_x1"];

["I_Plane_Fighter_04_F", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", I_Plane_Fighter_04_F, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


FIR_F15E = ["FIR_AIM9X_P_1rnd_M","FIR_AIM120B_P_1rnd_M","FIR_Mk82_GP_P_1rnd_M",
"FIR_Mk82_AIR_P_1rnd_M","FIR_AIM7F_2_P_1rnd_M","FIR_GBU12_P_1rnd_M","FIR_GBU38_P_1rnd_M",
"FIR_EGBU12_P_1rnd_M","FIR_GBU55_P_1rnd_M","FIR_GBU32_P_1rnd_M","FIR_AIM7_2_P_1rnd_M",
"FIR_GBU54_P_1rnd_M","FIR_GBU10_PW1_P_1rnd_M","FIR_GBU56_P_1rnd_M","FIR_AGM158B_P_1rnd_M",
"FIR_SniperXR_2_Tigereye_P_1rnd_M"];

["FIR_F15E", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist",FIR_F15E , true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;
	
	FIR_F35B_Standard =  ["FIR_Meteor_P_1rnd_M","FIR_Meteor_P_1rnd_M","FIR_AIM132_P_1rnd_M","FIR_AIM120_P_1rnd_M","","FIR_AIM120_LAU115_P_2rnd_M","FIR_AGM65H_P_1rnd_M","FIR_AGM154A_P_1rnd_M","FIR_AGM154C_P_1rnd_M","FIR_AIM9M_P_1rnd_M","FIR_Gunpod_Nomodel_P_1rnd_M",
"FIR_GBU12_Navy_P_1rnd_M","FIR_EGBU12_P_1rnd_M","","","","FIR_AGM88_P_1rnd_M","FIR_AIM9X_LAU115_P_2rnd_M","FIR_APKWS_M282_P_7rnd_M","FIR_APKWS_P_7rnd_M",
"FIR_GBU55_P_1rnd_M","FIR_GBU54_P_1rnd_M","","","","FIR_GBU55_Navy_P_1rnd_M","FIR_GBU10_P_1rnd_M","FIR_GBU12_Navy_P_2rnd_M","FIR_GBU12_P_1rnd_M","","FIR_Gunpod_Nomodel_P_1rnd_M",
"FIR_GBU32_P_1rnd_M","FIR_GBU32_P_1rnd_M","FIR_AIM120_P_1rnd_M","FIR_AIM120_P_1rnd_M","","","FIR_GBU53_P_4rnd_M","FIR_GBU31_BLU109_P_1rnd_M","FIR_AGM154C_P_1rnd_M"];


["FIR_F35B_Standard", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", FIR_F35B_Standard, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;



FIR_F22 =  
["FIR_AIM9M_P_1rnd_M","FIR_AIM120_P_1rnd_M","FIR_GBU53_P_4rnd_M","FIR_AIM9X_P_1rnd_M","FIR_GBU53_P_EWP_4rnd_M","FIR_F22_Fueltank_P_1rnd_M","FIR_AIM120_P_F22_Type1_2rnd_M",
"FIR_GBU55_P_1rnd_M","FIR_AIM120_P_F22_Type1_2rnd_M"];


["FIR_F22", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", FIR_F22, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;
	


B_Plane_Fighter_01_F = ["FIR_GBU12_P_1rnd_M","PylonRack_Missile_AMRAAM_D_x2","FIR_AGM123_P_1rnd_M",
"PylonRack_Missile_HARM_x1","FIR_AIM9X_P_1rnd_M","PylonMissile_Missile_BIM9X_x1","FIR_Meteor_P_1rnd_M",
"PylonMissile_Missile_AMRAAM_D_INT_x1","FIR_AIM120_P_1rnd_M","FIR_AIM120B_P_1rnd_M","FIR_AGM154C_P_1rnd_M",
"FIR_AGM154A_P_1rnd_M","FIR_AGM65L_P_1rnd_M","FIR_AGM65K_P_1rnd_M","FIR_AGM65H_P_1rnd_M","FIR_AGM65G_P_1rnd_M",
"PylonMissile_Missile_AMRAAM_D_INT_x1","FIR_AGM65E2_P_1rnd_M","PylonRack_Missile_AGM_02_x1","FIR_AGM65E2_P_1rnd_M",
"FIR_AGM123_P_1rnd_M"];

["B_Plane_Fighter_01_F", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", B_Plane_Fighter_01_F, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_A10_DYN_USA = ["CUP_PylonPod_1Rnd_AIM_9L_LAU_Sidewinder_M","FIR_GBU31_P_1rnd_M","FIR_AGM65D_P_1rnd_M",
"CUP_PylonPod_ALQ_131","FIR_Litening_std_P_1rnd_M","FIR_AGM65D_P_1rnd_M","FIR_GBU54_P_1rnd_M",
"CUP_PylonPod_1Rnd_AIM_9L_LAU_Sidewinder_M","CUP_PylonPod_1Rnd_AIM_9L_LAU_Sidewinder_M",
"PylonRack_1Rnd_Missile_AGM_02_F","FIR_AGM65D_P_1rnd_M","FIR_GBU12_P_2rnd_M",
"FIR_Litening_std_P_1rnd_M","FIR_GBU12_P_2rnd_M","FIR_AGM65D_P_1rnd_M",
"FIR_AGM65D_P_1rnd_M","CUP_PylonPod_1Rnd_AIM_9L_LAU_Sidewinder_M","FIR_AIM9X_P_2rnd_M",
"FIR_AGM65D_P_1rnd_M","FIR_GBU12_P_2rnd_M","CUP_PylonPod_ALQ_131",
"CUP_PylonPod_1Rnd_GBU12_M","FIR_GBU12_P_2rnd_M","FIR_AGM65D_P_1rnd_M",
"FIR_AIM9X_P_2rnd_M","FIR_AIM9X_P_1rnd_M","FIR_AGM65D_P_1rnd_M",
"FIR_AGM65D_P_1rnd_M","FIR_AGM65D_P_1rnd_M","FIR_AGM65D_P_1rnd_M",
"FIR_Litening_std_P_1rnd_M","FIR_AGM65D_P_1rnd_M","FIR_AGM65D_P_1rnd_M",
"FIR_AGM65D_P_1rnd_M","FIR_AGM65D_P_1rnd_M","FIR_AIM9X_P_1rnd_M",
"FIR_AIM9X_P_1rnd_M","CUP_PylonPod_1Rnd_Mk82_M","CUP_PylonPod_2Rnd_Mk82_M",
"CUP_PylonPod_2Rnd_Mk82_M","CUP_PylonPod_2Rnd_Mk82_M","CUP_PylonPod_1Rnd_Mk82_M",
"CUP_PylonPod_2Rnd_Mk82_M","CUP_PylonPod_2Rnd_Mk82_M","CUP_PylonPod_2Rnd_Mk82_M",
"CUP_PylonPod_1Rnd_Mk82_M","FIR_AIM9X_P_1rnd_M"];

["CUP_B_A10_DYN_USA", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_A10_DYN_USA, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


USAF_A10 = ["USAF_PylonRack_2Rnd_AIM9X_LAU105","USAF_PylonRack_1Rnd_ANAAQ28",
"USAF_PylonRack_2Rnd_AGM65D","USAF_PylonRack_1Rnd_GBU12","USAF_PylonRack_4Rnd_GBU39",
"USAF_PylonRack_1Rnd_GBU12","USAF_PylonRack_2Rnd_AGM65D","USAF_PylonRack_2Rnd_AIM9X_LAU105",
"USAF_PylonRack_2Rnd_AIM9X_LAU105","USAF_PylonRack_1Rnd_ANAAQ28","USAF_PylonRack_1Rnd_AGM65D",
"USAF_PylonRack_1Rnd_GBU12","USAF_PylonRack_1Rnd_GBU12","USAF_PylonRack_4Rnd_GBU39",
"USAF_PylonRack_1Rnd_GBU12","USAF_PylonRack_1Rnd_GBU12","USAF_PylonRack_1Rnd_AGM65D",
"USAF_PylonRack_4Rnd_GBU39","USAF_PylonRack_2Rnd_AIM9X_LAU105"];

["USAF_A10", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist",USAF_A10, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_MH60L_DAP_2x_US = ["CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2Rnd_AGM114L_Hellfire_II_M",
"FIR_Poniard_P_7rnd_M","CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_7Rnd_Rocket_FFAR_M","CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M"];

["CUP_B_MH60L_DAP_2x_US", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_MH60L_DAP_2x_US, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_MH60L_DAP_2x_USN =["CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2Rnd_AGM114L_Hellfire_II_M",
"FIR_Poniard_P_7rnd_M","CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_7Rnd_Rocket_FFAR_M","CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M"];

["CUP_B_MH60L_DAP_2x_USN", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_MH60L_DAP_2x_USN, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_MH60L_DAP_4x_USN =["CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2Rnd_AGM114L_Hellfire_II_M",
"FIR_Poniard_P_7rnd_M","CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_7Rnd_Rocket_FFAR_M","CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M"];

["CUP_B_MH60L_DAP_4x_USN", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_MH60L_DAP_4x_USN, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_MH60L_DAP_4x_US =["CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2Rnd_AGM114L_Hellfire_II_M",
"FIR_Poniard_P_7rnd_M","CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_7Rnd_Rocket_FFAR_M","CUP_PylonPod_1200Rnd_TE1_Red_Tracer_M621_20mm_HE_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_GAU19A_M","CUP_PylonPod_2000Rnd_TE5_Red_Tracer_762x51_M134A_M",
"CUP_PylonPod_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M"];

["CUP_B_MH60L_DAP_4x_US", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_MH60L_DAP_4x_US, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;



CUP_B_AH6M_USA = ["FIR_Hydra_WDU4_P_7rnd_M","FIR_Hydra_M282_P_7rnd_M","FIR_Hydra_M247_P_7rnd_M",
"FIR_Hydra_M261_P_7rnd_M","FIR_Hydra_M229_P_7rnd_M","FIR_APKWS_P_7rnd_M",
"CUP_PylonPod_7Rnd_Rocket_FFAR_M","CUP_PylonPod_7Rnd_Rocket_FFAR_M"];


["CUP_B_AH6M_USA", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_AH6M_USA, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


RHS_MELB_AH6M = ["rhs_mag_M229_7","rhs_mag_m134_pylon_3000","rhs_mag_m134_pylon_3000",
"rhs_mag_M151_7","rhs_mag_ATAS_2","rhs_mag_m134_pylon_3000","rhs_mag_m134_pylon_3000","rhs_mag_M151_7"];

["RHS_MELB_AH6M", "InitPost", {
    params ["_vehicle"];
	_vehicle setVariable ["ace_pylons_magazineWhitelist", RHS_MELB_AH6M, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


USAF_MQ9 = ["USAF_PylonRack_1Rnd_AGM114R","USAF_PylonRack_1Rnd_GBU54",
"USAF_PylonRack_7Rnd_APKWS","USAF_PylonRack_1Rnd_GBU38"];

["USAF_MQ9", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist",USAF_MQ9 , true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


UK3CB_BAF_MQ9_Reaper_DPMW = ["UK3CB_BAF_PylonRack_2Rnd_Hellfire_N","UK3CB_BAF_PylonRack_2Rnd_Hellfire_K",
"UK3CB_BAF_PylonMissile_1Rnd_GBU12"];

["UK3CB_BAF_MQ9_Reaper_DPMW", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist",UK3CB_BAF_MQ9_Reaper_DPMW , true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


ffaa_ea_reaper = ["PylonMissile_1Rnd_Missile_AA_04_F","CUP_PylonPod_1Rnd_GBU12_M",
"PylonRack_ffaa_2Rnd_hellfire","PylonMissile_1Rnd_AAA_missiles"];

["ffaa_ea_reaper", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", ffaa_ea_reaper, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


B_UAV_05_F =  ["PylonMissile_Missile_HARM_INT_x1","PylonMissile_Bomb_GBU12_x1","FIR_GBU32_Navy_P_1rnd_M",
"FIR_Mk83_AIR_Navy_P_1rnd_M"];

["B_UAV_05_F", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", B_UAV_05_F, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_AH64D_DL_USA = ["CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_4Rnd_AGM114L_Hellfire_II_M",
"CUP_PylonPod_4Rnd_AGM114L_Hellfire_II_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M","CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M","CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M",
"CUP_PylonPod_2Rnd_AGM114L_Hellfire_II_M","CUP_PylonPod_4Rnd_AGM114L_Hellfire_II_M",
"CUP_PylonPod_4Rnd_AGM114L_Hellfire_II_M","CUP_PylonPod_2Rnd_AGM114L_Hellfire_II_M",
"CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M","CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M"];

["CUP_B_AH64D_DL_USA", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist",CUP_B_AH64D_DL_USA , true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_AH1Z_Dynamic_USMC = ["CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M","CUP_PylonPod_2Rnd_AGM114K_Hellfire_II_M",
"CUP_PylonPod_2Rnd_AGM114K_Hellfire_II_M","CUP_PylonPod_2Rnd_AGM114K_Hellfire_II_M",
"CUP_PylonPod_2Rnd_AGM114K_Hellfire_II_M","CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M",
"CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M",
"CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M","FIR_Hydra_WDU4_P_7rnd_M",
"CUP_PylonPod_2Rnd_AGM114K_Hellfire_II_M","CUP_PylonPod_19Rnd_Rocket_FFAR_M",
"CUP_PylonPod_19Rnd_Rocket_FFAR_M","CUP_PylonPod_1Rnd_AIM_9L_Sidewinder_M"];

["CUP_B_AH1Z_Dynamic_USMC", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_AH1Z_Dynamic_USMC, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


JS_JC_FA18F = 
	[
	"FIR_AIM9X_P_1rnd_M","FIR_AIM9X_LAU115_P_1rnd_M",
	"FIR_AIM9X_P_2rnd_M","FIR_AIM9X_LAU115_P_2rnd_M","FIR_AIM120A_P_1rnd_M","FIR_AIM120B_P_1rnd_M","FIR_AIM120_P_1rnd_M",
	"FIR_AIM120B_LAU115_P_1rnd_M","FIR_AIM120_LAU115_P_1rnd_M","FIR_AIM120B_LAU115_P_2rnd_M",
	"FIR_AIM120B_LAU115BA_P_2rnd_M","FIR_AIM120_LAU115_P_2rnd_M","FIR_AIM120_LAU115BA_P_2rnd_M",
	"FIR_AIM7_2_P_1rnd_M","FIR_AIM7F_2_P_1rnd_M","FIR_GBU10_P_1rnd_M","FIR_GBU10_Navy_P_1rnd_M",
	"FIR_GBU24A_P_1rnd_M","FIR_GBU24B_P_1rnd_M","FIR_GBU24A_BLU109_P_1rnd_M",
	"FIR_GBU24B_BLU109_P_1rnd_M","FIR_GBU24EB_P_1rnd_M","FIR_GBU12_P_1rnd_M","FIR_GBU12_Navy_P_1rnd_M"
	,"FIR_GBU12_P_2rnd_M","FIR_GBU12_Navy_P_2rnd_M","FIR_GBU12_P_3rnd_M","FIR_GBU12_Navy_P_3rnd_M",
	"FIR_EGBU12_P_1rnd_M","FIR_EGBU12_P_2rnd_M","FIR_EGBU12_Navy_P_2rnd_M","FIR_EGBU12_P_3rnd_M",
	"FIR_GBU16_Navy_P_1rnd_M","FIR_GBU16_Navy_P_2rnd_M","FIR_GBU31_P_1rnd_M","FIR_GBU31_Navy_P_1rnd_M"
	,"FIR_GBU31_BLU109_P_1rnd_M","FIR_GBU56_P_1rnd_M","FIR_GBU56_Navy_P_1rnd_M","FIR_GBU32_P_1rnd_M",
	"FIR_GBU32_Navy_P_1rnd_M","FIR_GBU32_Navy_P_2rnd_M","FIR_GBU38_P_1rnd_M","FIR_GBU38_Navy_P_1rnd_M"
	,"FIR_GBU38_P_2rnd_M","FIR_GBU38_Navy_P_2rnd_M","FIR_GBU38_P_3rnd_M","FIR_GBU54_P_1rnd_M",
	"FIR_GBU54_P_2rnd_M","FIR_GBU54_Navy_P_2rnd_M","FIR_GBU54_P_3rnd_M",
	"FIR_AGM154A_P_1rnd_M","FIR_AGM154C_P_1rnd_M","FIR_KGGB_P_1rnd_M",
	"FIR_Mk82_GP_P_1rnd_M","FIR_Mk82_GP_Navy_P_1rnd_M","FIR_Mk82_GP_prox_P_1rnd_M",
	"FIR_Mk82_GP_Navy_prox_P_1rnd_M","FIR_Mk82_GP_Navy_P_2rnd_M","FIR_Mk82_GP_P_3rnd_M","FIR_Mk82_snakeye_P_1rnd_M",
	"FIR_Mk82_snakeye_Navy_P_1rnd_M","FIR_Mk82_snakeye_Navy_P_2rnd_M","FIR_Mk82_snakeye_P_3rnd_M","FIR_Mk83_GP_Navy_P_1rnd_M","FIR_Mk83_GP_Navy_P_2rnd_M",
	"FIR_Mk84_GP_P_1rnd_M","FIR_Mk84_GP_Navy_P_1rnd_M","FIR_CBU87_P_1rnd_M","FIR_CBU87_P_BRU57_2rnd_M"
	,"FIR_CBU87_P_TripleRack_2rnd_M","FIR_CBU100_P_1rnd_M","FIR_CBU100_P_TripleRack_2rnd_M",
	"FIR_CBU100_P_TripleRack_3rnd_M","FIR_CBU78_P_1rnd_M","FIR_CBU78_P_BRU57_2rnd_M",
	"FIR_CBU89_P_1rnd_M","FIR_CBU89_P_BRU57_2rnd_M","FIR_CBU89_P_TripleRack_2rnd_M",
	"FIR_CBU97_P_1rnd_M","FIR_CBU97_P_BRU57_2rnd_M","FIR_CBU97_P_TripleRack_2rnd_M",
	"FIR_CBU103_P_1rnd_M","FIR_CBU103_P_BRU57_2rnd_M","FIR_CBU103_P_TripleRack_2rnd_M",
	"FIR_CBU105_P_1rnd_M","FIR_CBU105_P_BRU57_2rnd_M","FIR_CBU105_P_TripleRack_2rnd_M",
	"FIR_PDU5B_P_1rnd_M","FIR_PDU5B_Custom1_P_1rnd_M","FIR_PDU5B_Custom2_P_1rnd_M",
	"FIR_PDU5B_Custom3_P_1rnd_M","FIR_AGM88_P_1rnd_M","FIR_AGM84E_P_1rnd_M","FIR_AGM84H_P_1rnd_M",
	"FIR_AGM84K_P_1rnd_M","FIR_AGM158B_P_1rnd_M","FIR_AGM65D_P_1rnd_M",
	"FIR_AGM65H_P_1rnd_M","FIR_AGM65F_P_1rnd_M","FIR_AGM65G_P_1rnd_M",
	"FIR_AGM65K_P_1rnd_M","FIR_AGM65E_P_1rnd_M","FIR_AGM65E2_P_1rnd_M","FIR_AGM65L_P_1rnd_M",
	"FIR_Hydra_P_7rnd_M","FIR_Hydra_LAU130_P_19rnd_M","FIR_Hydra_P_21rnd_M","FIR_Hydra_P_14rnd_M", 
	"FIR_Hydra_P_38rnd_M","FIR_CRV7_P_19rnd_M","FIR_Hydra_M229_P_7rnd_M","FIR_Hydra_M229_P_19rnd_M",
	"FIR_Hydra_M229_P_14rnd_M","FIR_Hydra_M229_P_38rnd_M","FIR_Hydra_M247_P_7rnd_M",
	"FIR_Hydra_M247_P_19rnd_M","FIR_Hydra_M247_P_14rnd_M","FIR_Hydra_M247_P_38rnd_M",
	"FIR_Hydra_M257_P_7rnd_M","FIR_Hydra_M261_P_7rnd_M","FIR_Hydra_M261_P_19rnd_M",
	"FIR_Hydra_M261_P_14rnd_M","FIR_Hydra_M261_P_38rnd_M","FIR_Hydra_M282_P_7rnd_M",
	"FIR_Hydra_M282_P_19rnd_M","FIR_Hydra_M282_P_14rnd_M","FIR_Hydra_M282_P_38rnd_M",
	"FIR_Hydra_WDU4_P_7rnd_M","FIR_Hydra_WDU4_P_19rnd_M","FIR_Hydra_WDU4_P_14rnd_M",
	"FIR_Hydra_WDU4_P_38rnd_M","FIR_Hydra_WP_P_7rnd_M","FIR_Hydra_WP_P_21rnd_M",
	"FIR_Hydra_M259_P_7rnd_M","FIR_Hydra_Smoke_P_7rnd_M","FIR_Hydra_Smoke_P_21rnd_M","FIR_Poniard_P_7rnd_M","FIR_Zuni_P_4rnd_M",
	"FIR_Zuni_P_8rnd_M","FIR_Zuni_Mk32_P_4rnd_M","FIR_Zuni_Mk32_P_8rnd_M","FIR_Zuni_Fairing_P_4rnd_M",
	"FIR_Zuni_Fairing_P_8rnd_M","FIR_Zuni_Fairing_Mk32_P_4rnd_M","FIR_Zuni_Fairing_Mk32_P_8rnd_M","FIR_ALQ99_P_1rnd_M",
	"FIR_ALQ99Hi_P_1rnd_M","FIR_ECMPod_P_1rnd_M","FIR_ALQ184_2_P_1rnd_M","FIR_Mk76_P_1rnd_M","FIR_Mk76_P_2rnd_M",
	"FIR_Mk76_P_3rnd_M","FIR_ATFLIR_2_P_1rnd_M","FIR_Litening_std_P_1rnd_M","FIR_SniperXR_2_P_1rnd_M",
	"FIR_AWW13_P_1rnd_M","js_jc_120Rnd_CMChaff_Magazine",
	"js_jc_120Rnd_CMFlare_Magazine","js_m_fa18_buddypod_x1","USAF_PylonRack_1Rnd_AGM65K","FIR_APKWS_M282_P_7rnd_M","FIR_APKWS_P_7rnd_M","js_m_fa18_wing_tank_x1",
	"rhs_mag_aim120","FIR_Meteor_P_1rnd_M","FIR_GBU10_PW1_P_1rnd_M","PylonMissile_Missile_HARM_x1","CUP_PylonPod_ALQ_131","USAF_PylonRack_1Rnd_AGM154C"
	];

["JS_JC_FA18F", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", JS_JC_FA18F, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;
	
	
	FIR_F18C =  ["FIR_AIM9X_P_1rnd_M","FIR_AIM120_LAU115_P_1rnd_M","FIR_AIM120_LAU115BA_P_2rnd_M","FIR_AIM7F_2_P_1rnd_M","FIR_FA18_Fueltank_P_1rnd_M",
"FIR_AIM7_2_P_1rnd_M","FIR_AIM132_P_1rnd_M","FIR_AIM9X_LAU115_P_2rnd_M","FIR_AIM9M_P_1rnd_M",
"FIR_IRIS_T_P_1rnd_M","FIR_AGM88_P_1rnd_M","FIR_APKWS_M282_P_7rnd_M","FIR_Litening_std_P_1rnd_M","FIR_AGM154A_P_1rnd_M","FIR_AGM154C_P_1rnd_M",
"FIR_AGM123_P_1rnd_M","FIR_AGM158B_P_1rnd_M","FIR_Nitehawk_P_1rnd_M","FIR_ASQ173LST_P_1rnd_M","FIR_AGM65D_P_1rnd_M","FIR_AGM65E_P_1rnd_M",
"FIR_AGM65H_P_1rnd_M","FIR_AGM65G_P_1rnd_M","FIR_SniperXR_SIDE_P_1rnd_M","FIR_AWW13_P_1rnd_M","","FIR_AGM65F_P_1rnd_M","FIR_AGM65E2_P_1rnd_M",
"FIR_AGM65K_P_1rnd_M","FIR_AGM65L_P_1rnd_M","FIR_AGM84D_P_1rnd_M","FIR_AGM84E_P_1rnd_M",
"FIR_GBU10_P_1rnd_M","FIR_EGBU12_P_2rnd_M","FIR_AGM84K_P_1rnd_M","FIR_AGM84H_P_1rnd_M",
"FIR_GBU12_Navy_P_2rnd_M","FIR_GBU16_Navy_P_2rnd_M","FIR_GBU24B_P_1rnd_M","FIR_GBU24EB_P_1rnd_M",
"FIR_CBU103_P_BRU57_2rnd_M","FIR_CBU105_P_BRU57_2rnd_M","FIR_GBU54_Navy_P_2rnd_M","FIR_gbu55_Navy_P_2rnd_M",
"FIR_AGM62_Walleye2ER_P_1rnd_M","FIR_AGM62_Walleye1ER_P_1rnd_M","FIR_AGM62_Walleye1_P_1rnd_M","FIR_Tiger2_P_1rnd_M"];


["FIR_F18C", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", FIR_F18C, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;



FIR_F18D =  
["FIR_AIM9X_P_1rnd_M","FIR_AIM120_LAU115_P_1rnd_M","FIR_AIM120_LAU115BA_P_2rnd_M","FIR_AIM7F_2_P_1rnd_M","FIR_FA18_Fueltank_P_1rnd_M","FIR_AIM7_2_P_1rnd_M","FIR_AIM132_P_1rnd_M","FIR_AIM9X_LAU115_P_2rnd_M","FIR_AIM9M_P_1rnd_M",
"FIR_IRIS_T_P_1rnd_M","FIR_AGM88_P_1rnd_M","FIR_APKWS_M282_P_7rnd_M","FIR_Litening_std_P_1rnd_M","FIR_AGM154A_P_1rnd_M","FIR_AGM154C_P_1rnd_M",
"FIR_AGM123_P_1rnd_M","FIR_AGM158B_P_1rnd_M","FIR_Nitehawk_P_1rnd_M","FIR_ASQ173LST_P_1rnd_M","FIR_AGM65D_P_1rnd_M","FIR_AGM65E_P_1rnd_M",
"FIR_AGM65H_P_1rnd_M","FIR_AGM65G_P_1rnd_M","FIR_SniperXR_SIDE_P_1rnd_M","FIR_AWW13_P_1rnd_M","","FIR_AGM65F_P_1rnd_M","FIR_AGM65E2_P_1rnd_M",
"FIR_AGM65K_P_1rnd_M","FIR_AGM65L_P_1rnd_M","FIR_AGM84D_P_1rnd_M","FIR_AGM84E_P_1rnd_M",
"FIR_GBU10_P_1rnd_M","FIR_EGBU12_P_2rnd_M","FIR_AGM84K_P_1rnd_M","FIR_AGM84H_P_1rnd_M",
"FIR_GBU12_Navy_P_2rnd_M","FIR_GBU16_Navy_P_2rnd_M","FIR_GBU24B_P_1rnd_M","FIR_GBU24EB_P_1rnd_M",
"FIR_CBU103_P_BRU57_2rnd_M","FIR_CBU105_P_BRU57_2rnd_M","FIR_GBU54_Navy_P_2rnd_M","FIR_gbu55_Navy_P_2rnd_M",
"FIR_AGM62_Walleye2ER_P_1rnd_M","FIR_AGM62_Walleye1ER_P_1rnd_M","FIR_AGM62_Walleye1_P_1rnd_M","FIR_Tiger2_P_1rnd_M"];


["FIR_F18D", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", FIR_F18D, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_GR9_DYN_GB = 
	["PylonMissile_1Rnd_Mk82_F","FIR_Mk82_snakeye_P_1rnd_M",
	"PylonMissile_1Rnd_Bomb_04_F","FIR_AIM9L_P_1rnd_M",
	"PylonWeapon_300Rnd_20mm_shells","PylonRack_7Rnd_Rocket_04_HE_F",
	"FIR_AIM9X_P_1rnd_M","CUP_PylonPod_ANAAQ_28","PylonRack_7Rnd_Rocket_04_AP_F"];

["CUP_B_GR9_DYN_GB", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_GR9_DYN_GB, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


	CUP_B_AV8B_DYN_USMC = 
	[
	"FIR_AIM9X_P_1rnd_M","FIR_AIM9X_LAU115_P_1rnd_M",
	"FIR_AIM9X_P_2rnd_M","FIR_AIM9X_LAU115_P_2rnd_M","FIR_AIM120A_P_1rnd_M","FIR_AIM120B_P_1rnd_M","FIR_AIM120_P_1rnd_M",
	"FIR_AIM120B_LAU115_P_1rnd_M","FIR_AIM120_LAU115_P_1rnd_M","FIR_AIM120B_LAU115_P_2rnd_M",
	"FIR_AIM120B_LAU115BA_P_2rnd_M","FIR_AIM120_LAU115_P_2rnd_M","FIR_AIM120_LAU115BA_P_2rnd_M",
	"FIR_AIM7_2_P_1rnd_M","FIR_AIM7F_2_P_1rnd_M","FIR_GBU10_P_1rnd_M","FIR_GBU10_Navy_P_1rnd_M",
	"FIR_GBU24A_P_1rnd_M","FIR_GBU24B_P_1rnd_M","FIR_GBU24A_BLU109_P_1rnd_M",
	"FIR_GBU24B_BLU109_P_1rnd_M","FIR_GBU24EB_P_1rnd_M","FIR_GBU12_P_1rnd_M","FIR_GBU12_Navy_P_1rnd_M"
	,"FIR_GBU12_P_2rnd_M","FIR_GBU12_Navy_P_2rnd_M","FIR_GBU12_P_3rnd_M","FIR_GBU12_Navy_P_3rnd_M",
	"FIR_EGBU12_P_1rnd_M","FIR_EGBU12_P_2rnd_M","FIR_EGBU12_Navy_P_2rnd_M","FIR_EGBU12_P_3rnd_M",
	"FIR_GBU16_Navy_P_1rnd_M","FIR_GBU16_Navy_P_2rnd_M","FIR_GBU31_P_1rnd_M","FIR_GBU31_Navy_P_1rnd_M"
	,"FIR_GBU31_BLU109_P_1rnd_M","FIR_GBU56_P_1rnd_M","FIR_GBU56_Navy_P_1rnd_M","FIR_GBU32_P_1rnd_M",
	"FIR_GBU32_Navy_P_1rnd_M","FIR_GBU32_Navy_P_2rnd_M","FIR_GBU38_P_1rnd_M","FIR_GBU38_Navy_P_1rnd_M"
	,"FIR_GBU38_P_2rnd_M","FIR_GBU38_Navy_P_2rnd_M","FIR_GBU38_P_3rnd_M","FIR_GBU54_P_1rnd_M",
	"FIR_GBU54_P_2rnd_M","FIR_GBU54_Navy_P_2rnd_M","FIR_GBU54_P_3rnd_M",
	"FIR_AGM154A_P_1rnd_M","FIR_AGM154C_P_1rnd_M","FIR_KGGB_P_1rnd_M",
	"FIR_Mk82_GP_P_1rnd_M","FIR_Mk82_GP_Navy_P_1rnd_M","FIR_Mk82_GP_prox_P_1rnd_M",
	"FIR_Mk82_GP_Navy_prox_P_1rnd_M","FIR_Mk82_GP_Navy_P_2rnd_M","FIR_Mk82_GP_P_3rnd_M","FIR_Mk82_snakeye_P_1rnd_M",
	"FIR_Mk82_snakeye_Navy_P_1rnd_M","FIR_Mk82_snakeye_Navy_P_2rnd_M","FIR_Mk82_snakeye_P_3rnd_M","FIR_Mk83_GP_Navy_P_1rnd_M","FIR_Mk83_GP_Navy_P_2rnd_M",
	"FIR_Mk84_GP_P_1rnd_M","FIR_Mk84_GP_Navy_P_1rnd_M","FIR_CBU87_P_1rnd_M","FIR_CBU87_P_BRU57_2rnd_M"
	,"FIR_CBU87_P_TripleRack_2rnd_M","FIR_CBU100_P_1rnd_M","FIR_CBU100_P_TripleRack_2rnd_M",
	"FIR_CBU100_P_TripleRack_3rnd_M","FIR_CBU78_P_1rnd_M","FIR_CBU78_P_BRU57_2rnd_M",
	"FIR_CBU89_P_1rnd_M","FIR_CBU89_P_BRU57_2rnd_M","FIR_CBU89_P_TripleRack_2rnd_M",
	"FIR_CBU97_P_1rnd_M","FIR_CBU97_P_BRU57_2rnd_M","FIR_CBU97_P_TripleRack_2rnd_M",
	"FIR_CBU103_P_1rnd_M","FIR_CBU103_P_BRU57_2rnd_M","FIR_CBU103_P_TripleRack_2rnd_M",
	"FIR_CBU105_P_1rnd_M","FIR_CBU105_P_BRU57_2rnd_M","FIR_CBU105_P_TripleRack_2rnd_M",
	"FIR_PDU5B_P_1rnd_M","FIR_PDU5B_Custom1_P_1rnd_M","FIR_PDU5B_Custom2_P_1rnd_M",
	"FIR_PDU5B_Custom3_P_1rnd_M","FIR_AGM88_P_1rnd_M","FIR_AGM84E_P_1rnd_M","FIR_AGM84H_P_1rnd_M",
	"FIR_AGM84K_P_1rnd_M","FIR_AGM158B_P_1rnd_M","FIR_AGM65D_P_1rnd_M",
	"FIR_AGM65H_P_1rnd_M","FIR_AGM65F_P_1rnd_M","FIR_AGM65G_P_1rnd_M",
	"FIR_AGM65K_P_1rnd_M","FIR_AGM65E_P_1rnd_M","FIR_AGM65E2_P_1rnd_M","FIR_AGM65L_P_1rnd_M",
	"FIR_Hydra_P_7rnd_M","FIR_Hydra_LAU130_P_19rnd_M","FIR_Hydra_P_21rnd_M","FIR_Hydra_P_14rnd_M", 
	"FIR_Hydra_P_38rnd_M","FIR_CRV7_P_19rnd_M","FIR_Hydra_M229_P_7rnd_M","FIR_Hydra_M229_P_19rnd_M",
	"FIR_Hydra_M229_P_14rnd_M","FIR_Hydra_M229_P_38rnd_M","FIR_Hydra_M247_P_7rnd_M",
	"FIR_Hydra_M247_P_19rnd_M","FIR_Hydra_M247_P_14rnd_M","FIR_Hydra_M247_P_38rnd_M",
	"FIR_Hydra_M257_P_7rnd_M","FIR_Hydra_M261_P_7rnd_M","FIR_Hydra_M261_P_19rnd_M",
	"FIR_Hydra_M261_P_14rnd_M","FIR_Hydra_M261_P_38rnd_M","FIR_Hydra_M282_P_7rnd_M",
	"FIR_Hydra_M282_P_19rnd_M","FIR_Hydra_M282_P_14rnd_M","FIR_Hydra_M282_P_38rnd_M",
	"FIR_Hydra_WDU4_P_7rnd_M","FIR_Hydra_WDU4_P_19rnd_M","FIR_Hydra_WDU4_P_14rnd_M",
	"FIR_Hydra_WDU4_P_38rnd_M","FIR_Hydra_WP_P_7rnd_M","FIR_Hydra_WP_P_21rnd_M",
	"FIR_Hydra_M259_P_7rnd_M","FIR_Hydra_Smoke_P_7rnd_M","FIR_Hydra_Smoke_P_21rnd_M","FIR_Poniard_P_7rnd_M","FIR_Zuni_P_4rnd_M",
	"FIR_Zuni_P_8rnd_M","FIR_Zuni_Mk32_P_4rnd_M","FIR_Zuni_Mk32_P_8rnd_M","FIR_Zuni_Fairing_P_4rnd_M",
	"FIR_Zuni_Fairing_P_8rnd_M","FIR_Zuni_Fairing_Mk32_P_4rnd_M","FIR_Zuni_Fairing_Mk32_P_8rnd_M","FIR_ALQ99_P_1rnd_M",
	"FIR_ALQ99Hi_P_1rnd_M","FIR_ECMPod_P_1rnd_M","FIR_ALQ184_2_P_1rnd_M","FIR_Mk76_P_1rnd_M","FIR_Mk76_P_2rnd_M",
	"FIR_Mk76_P_3rnd_M","FIR_ATFLIR_2_P_1rnd_M","FIR_Litening_std_P_1rnd_M","FIR_SniperXR_2_P_1rnd_M",
	"FIR_AWW13_P_1rnd_M","js_jc_120Rnd_CMChaff_Magazine",
	"js_jc_120Rnd_CMFlare_Magazine"
	];


["CUP_B_AV8B_DYN_USMC", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_AV8B_DYN_USMC, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;



ffaa_ar_harrier = 	[
	"FIR_AIM9X_P_1rnd_M","FIR_AIM9X_LAU115_P_1rnd_M",
	"FIR_AIM9X_P_2rnd_M","FIR_AIM9X_LAU115_P_2rnd_M","FIR_AIM120A_P_1rnd_M","FIR_AIM120B_P_1rnd_M","FIR_AIM120_P_1rnd_M",
	"FIR_AIM120B_LAU115_P_1rnd_M","FIR_AIM120_LAU115_P_1rnd_M","FIR_AIM120B_LAU115_P_2rnd_M",
	"FIR_AIM120B_LAU115BA_P_2rnd_M","FIR_AIM120_LAU115_P_2rnd_M","FIR_AIM120_LAU115BA_P_2rnd_M",
	"FIR_AIM7_2_P_1rnd_M","FIR_AIM7F_2_P_1rnd_M","FIR_GBU10_P_1rnd_M","FIR_GBU10_Navy_P_1rnd_M",
	"FIR_GBU24A_P_1rnd_M","FIR_GBU24B_P_1rnd_M","FIR_GBU24A_BLU109_P_1rnd_M",
	"FIR_GBU24B_BLU109_P_1rnd_M","FIR_GBU24EB_P_1rnd_M","FIR_GBU12_P_1rnd_M","FIR_GBU12_Navy_P_1rnd_M"
	,"FIR_GBU12_P_2rnd_M","FIR_GBU12_Navy_P_2rnd_M","FIR_GBU12_P_3rnd_M","FIR_GBU12_Navy_P_3rnd_M",
	"FIR_EGBU12_P_1rnd_M","FIR_EGBU12_P_2rnd_M","FIR_EGBU12_Navy_P_2rnd_M","FIR_EGBU12_P_3rnd_M",
	"FIR_GBU16_Navy_P_1rnd_M","FIR_GBU16_Navy_P_2rnd_M","FIR_GBU31_P_1rnd_M","FIR_GBU31_Navy_P_1rnd_M"
	,"FIR_GBU31_BLU109_P_1rnd_M","FIR_GBU56_P_1rnd_M","FIR_GBU56_Navy_P_1rnd_M","FIR_GBU32_P_1rnd_M",
	"FIR_GBU32_Navy_P_1rnd_M","FIR_GBU32_Navy_P_2rnd_M","FIR_GBU38_P_1rnd_M","FIR_GBU38_Navy_P_1rnd_M"
	,"FIR_GBU38_P_2rnd_M","FIR_GBU38_Navy_P_2rnd_M","FIR_GBU38_P_3rnd_M","FIR_GBU54_P_1rnd_M",
	"FIR_GBU54_P_2rnd_M","FIR_GBU54_Navy_P_2rnd_M","FIR_GBU54_P_3rnd_M",
	"FIR_AGM154A_P_1rnd_M","FIR_AGM154C_P_1rnd_M","FIR_KGGB_P_1rnd_M",
	"FIR_Mk82_GP_P_1rnd_M","FIR_Mk82_GP_Navy_P_1rnd_M","FIR_Mk82_GP_prox_P_1rnd_M",
	"FIR_Mk82_GP_Navy_prox_P_1rnd_M","FIR_Mk82_GP_Navy_P_2rnd_M","FIR_Mk82_GP_P_3rnd_M","FIR_Mk82_snakeye_P_1rnd_M",
	"FIR_Mk82_snakeye_Navy_P_1rnd_M","FIR_Mk82_snakeye_Navy_P_2rnd_M","FIR_Mk82_snakeye_P_3rnd_M","FIR_Mk83_GP_Navy_P_1rnd_M","FIR_Mk83_GP_Navy_P_2rnd_M",
	"FIR_Mk84_GP_P_1rnd_M","FIR_Mk84_GP_Navy_P_1rnd_M","FIR_CBU87_P_1rnd_M","FIR_CBU87_P_BRU57_2rnd_M"
	,"FIR_CBU87_P_TripleRack_2rnd_M","FIR_CBU100_P_1rnd_M","FIR_CBU100_P_TripleRack_2rnd_M",
	"FIR_CBU100_P_TripleRack_3rnd_M","FIR_CBU78_P_1rnd_M","FIR_CBU78_P_BRU57_2rnd_M",
	"FIR_CBU89_P_1rnd_M","FIR_CBU89_P_BRU57_2rnd_M","FIR_CBU89_P_TripleRack_2rnd_M",
	"FIR_CBU97_P_1rnd_M","FIR_CBU97_P_BRU57_2rnd_M","FIR_CBU97_P_TripleRack_2rnd_M",
	"FIR_CBU103_P_1rnd_M","FIR_CBU103_P_BRU57_2rnd_M","FIR_CBU103_P_TripleRack_2rnd_M",
	"FIR_CBU105_P_1rnd_M","FIR_CBU105_P_BRU57_2rnd_M","FIR_CBU105_P_TripleRack_2rnd_M",
	"FIR_PDU5B_P_1rnd_M","FIR_PDU5B_Custom1_P_1rnd_M","FIR_PDU5B_Custom2_P_1rnd_M",
	"FIR_PDU5B_Custom3_P_1rnd_M","FIR_AGM88_P_1rnd_M","FIR_AGM84E_P_1rnd_M","FIR_AGM84H_P_1rnd_M",
	"FIR_AGM84K_P_1rnd_M","FIR_AGM158B_P_1rnd_M","FIR_AGM65D_P_1rnd_M",
	"FIR_AGM65H_P_1rnd_M","FIR_AGM65F_P_1rnd_M","FIR_AGM65G_P_1rnd_M",
	"FIR_AGM65K_P_1rnd_M","FIR_AGM65E_P_1rnd_M","FIR_AGM65E2_P_1rnd_M","FIR_AGM65L_P_1rnd_M",
	"FIR_Hydra_P_7rnd_M","FIR_Hydra_LAU130_P_19rnd_M","FIR_Hydra_P_21rnd_M","FIR_Hydra_P_14rnd_M", 
	"FIR_Hydra_P_38rnd_M","FIR_CRV7_P_19rnd_M","FIR_Hydra_M229_P_7rnd_M","FIR_Hydra_M229_P_19rnd_M",
	"FIR_Hydra_M229_P_14rnd_M","FIR_Hydra_M229_P_38rnd_M","FIR_Hydra_M247_P_7rnd_M",
	"FIR_Hydra_M247_P_19rnd_M","FIR_Hydra_M247_P_14rnd_M","FIR_Hydra_M247_P_38rnd_M",
	"FIR_Hydra_M257_P_7rnd_M","FIR_Hydra_M261_P_7rnd_M","FIR_Hydra_M261_P_19rnd_M",
	"FIR_Hydra_M261_P_14rnd_M","FIR_Hydra_M261_P_38rnd_M","FIR_Hydra_M282_P_7rnd_M",
	"FIR_Hydra_M282_P_19rnd_M","FIR_Hydra_M282_P_14rnd_M","FIR_Hydra_M282_P_38rnd_M",
	"FIR_Hydra_WDU4_P_7rnd_M","FIR_Hydra_WDU4_P_19rnd_M","FIR_Hydra_WDU4_P_14rnd_M",
	"FIR_Hydra_WDU4_P_38rnd_M","FIR_Hydra_WP_P_7rnd_M","FIR_Hydra_WP_P_21rnd_M",
	"FIR_Hydra_M259_P_7rnd_M","FIR_Hydra_Smoke_P_7rnd_M","FIR_Hydra_Smoke_P_21rnd_M","FIR_Poniard_P_7rnd_M","FIR_Zuni_P_4rnd_M",
	"FIR_Zuni_P_8rnd_M","FIR_Zuni_Mk32_P_4rnd_M","FIR_Zuni_Mk32_P_8rnd_M","FIR_Zuni_Fairing_P_4rnd_M",
	"FIR_Zuni_Fairing_P_8rnd_M","FIR_Zuni_Fairing_Mk32_P_4rnd_M","FIR_Zuni_Fairing_Mk32_P_8rnd_M","FIR_ALQ99_P_1rnd_M",
	"FIR_ALQ99Hi_P_1rnd_M","FIR_ECMPod_P_1rnd_M","FIR_ALQ184_2_P_1rnd_M","FIR_Mk76_P_1rnd_M","FIR_Mk76_P_2rnd_M",
	"FIR_Mk76_P_3rnd_M","FIR_ATFLIR_2_P_1rnd_M","FIR_Litening_std_P_1rnd_M","FIR_SniperXR_2_P_1rnd_M",
	"FIR_AWW13_P_1rnd_M","js_jc_120Rnd_CMChaff_Magazine",
	"js_jc_120Rnd_CMFlare_Magazine"
	];

["ffaa_ar_harrier", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", ffaa_ar_harrier, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;



JS_JC_FA18E = 
	[
	"FIR_AIM9X_P_1rnd_M","FIR_AIM9X_LAU115_P_1rnd_M",
	"FIR_AIM9X_P_2rnd_M","FIR_AIM9X_LAU115_P_2rnd_M","FIR_AIM120A_P_1rnd_M","FIR_AIM120B_P_1rnd_M","FIR_AIM120_P_1rnd_M",
	"FIR_AIM120B_LAU115_P_1rnd_M","FIR_AIM120_LAU115_P_1rnd_M","FIR_AIM120B_LAU115_P_2rnd_M",
	"FIR_AIM120B_LAU115BA_P_2rnd_M","FIR_AIM120_LAU115_P_2rnd_M","FIR_AIM120_LAU115BA_P_2rnd_M",
	"FIR_AIM7_2_P_1rnd_M","FIR_AIM7F_2_P_1rnd_M","FIR_GBU10_P_1rnd_M","FIR_GBU10_Navy_P_1rnd_M",
	"FIR_GBU24A_P_1rnd_M","FIR_GBU24B_P_1rnd_M","FIR_GBU24A_BLU109_P_1rnd_M",
	"FIR_GBU24B_BLU109_P_1rnd_M","FIR_GBU24EB_P_1rnd_M","FIR_GBU12_P_1rnd_M","FIR_GBU12_Navy_P_1rnd_M"
	,"FIR_GBU12_P_2rnd_M","FIR_GBU12_Navy_P_2rnd_M","FIR_GBU12_P_3rnd_M","FIR_GBU12_Navy_P_3rnd_M",
	"FIR_EGBU12_P_1rnd_M","FIR_EGBU12_P_2rnd_M","FIR_EGBU12_Navy_P_2rnd_M","FIR_EGBU12_P_3rnd_M",
	"FIR_GBU16_Navy_P_1rnd_M","FIR_GBU16_Navy_P_2rnd_M","FIR_GBU31_P_1rnd_M","FIR_GBU31_Navy_P_1rnd_M"
	,"FIR_GBU31_BLU109_P_1rnd_M","FIR_GBU56_P_1rnd_M","FIR_GBU56_Navy_P_1rnd_M","FIR_GBU32_P_1rnd_M",
	"FIR_GBU32_Navy_P_1rnd_M","FIR_GBU32_Navy_P_2rnd_M","FIR_GBU38_P_1rnd_M","FIR_GBU38_Navy_P_1rnd_M"
	,"FIR_GBU38_P_2rnd_M","FIR_GBU38_Navy_P_2rnd_M","FIR_GBU38_P_3rnd_M","FIR_GBU54_P_1rnd_M",
	"FIR_GBU54_P_2rnd_M","FIR_GBU54_Navy_P_2rnd_M","FIR_GBU54_P_3rnd_M",
	"FIR_AGM154A_P_1rnd_M","FIR_AGM154C_P_1rnd_M","FIR_KGGB_P_1rnd_M",
	"FIR_Mk82_GP_P_1rnd_M","FIR_Mk82_GP_Navy_P_1rnd_M","FIR_Mk82_GP_prox_P_1rnd_M",
	"FIR_Mk82_GP_Navy_prox_P_1rnd_M","FIR_Mk82_GP_Navy_P_2rnd_M","FIR_Mk82_GP_P_3rnd_M","FIR_Mk82_snakeye_P_1rnd_M",
	"FIR_Mk82_snakeye_Navy_P_1rnd_M","FIR_Mk82_snakeye_Navy_P_2rnd_M","FIR_Mk82_snakeye_P_3rnd_M","FIR_Mk83_GP_Navy_P_1rnd_M","FIR_Mk83_GP_Navy_P_2rnd_M",
	"FIR_Mk84_GP_P_1rnd_M","FIR_Mk84_GP_Navy_P_1rnd_M","FIR_CBU87_P_1rnd_M","FIR_CBU87_P_BRU57_2rnd_M"
	,"FIR_CBU87_P_TripleRack_2rnd_M","FIR_CBU100_P_1rnd_M","FIR_CBU100_P_TripleRack_2rnd_M",
	"FIR_CBU100_P_TripleRack_3rnd_M","FIR_CBU78_P_1rnd_M","FIR_CBU78_P_BRU57_2rnd_M",
	"FIR_CBU89_P_1rnd_M","FIR_CBU89_P_BRU57_2rnd_M","FIR_CBU89_P_TripleRack_2rnd_M",
	"FIR_CBU97_P_1rnd_M","FIR_CBU97_P_BRU57_2rnd_M","FIR_CBU97_P_TripleRack_2rnd_M",
	"FIR_CBU103_P_1rnd_M","FIR_CBU103_P_BRU57_2rnd_M","FIR_CBU103_P_TripleRack_2rnd_M",
	"FIR_CBU105_P_1rnd_M","FIR_CBU105_P_BRU57_2rnd_M","FIR_CBU105_P_TripleRack_2rnd_M",
	"FIR_PDU5B_P_1rnd_M","FIR_PDU5B_Custom1_P_1rnd_M","FIR_PDU5B_Custom2_P_1rnd_M",
	"FIR_PDU5B_Custom3_P_1rnd_M","FIR_AGM88_P_1rnd_M","FIR_AGM84E_P_1rnd_M","FIR_AGM84H_P_1rnd_M",
	"FIR_AGM84K_P_1rnd_M","FIR_AGM158B_P_1rnd_M","FIR_AGM65D_P_1rnd_M",
	"FIR_AGM65H_P_1rnd_M","FIR_AGM65F_P_1rnd_M","FIR_AGM65G_P_1rnd_M",
	"FIR_AGM65K_P_1rnd_M","FIR_AGM65E_P_1rnd_M","FIR_AGM65E2_P_1rnd_M","FIR_AGM65L_P_1rnd_M",
	"FIR_Hydra_P_7rnd_M","FIR_Hydra_LAU130_P_19rnd_M","FIR_Hydra_P_21rnd_M","FIR_Hydra_P_14rnd_M", 
	"FIR_Hydra_P_38rnd_M","FIR_CRV7_P_19rnd_M","FIR_Hydra_M229_P_7rnd_M","FIR_Hydra_M229_P_19rnd_M",
	"FIR_Hydra_M229_P_14rnd_M","FIR_Hydra_M229_P_38rnd_M","FIR_Hydra_M247_P_7rnd_M",
	"FIR_Hydra_M247_P_19rnd_M","FIR_Hydra_M247_P_14rnd_M","FIR_Hydra_M247_P_38rnd_M",
	"FIR_Hydra_M257_P_7rnd_M","FIR_Hydra_M261_P_7rnd_M","FIR_Hydra_M261_P_19rnd_M",
	"FIR_Hydra_M261_P_14rnd_M","FIR_Hydra_M261_P_38rnd_M","FIR_Hydra_M282_P_7rnd_M",
	"FIR_Hydra_M282_P_19rnd_M","FIR_Hydra_M282_P_14rnd_M","FIR_Hydra_M282_P_38rnd_M",
	"FIR_Hydra_WDU4_P_7rnd_M","FIR_Hydra_WDU4_P_19rnd_M","FIR_Hydra_WDU4_P_14rnd_M",
	"FIR_Hydra_WDU4_P_38rnd_M","FIR_Hydra_WP_P_7rnd_M","FIR_Hydra_WP_P_21rnd_M",
	"FIR_Hydra_M259_P_7rnd_M","FIR_Hydra_Smoke_P_7rnd_M","FIR_Hydra_Smoke_P_21rnd_M","FIR_Poniard_P_7rnd_M","FIR_Zuni_P_4rnd_M",
	"FIR_Zuni_P_8rnd_M","FIR_Zuni_Mk32_P_4rnd_M","FIR_Zuni_Mk32_P_8rnd_M","FIR_Zuni_Fairing_P_4rnd_M",
	"FIR_Zuni_Fairing_P_8rnd_M","FIR_Zuni_Fairing_Mk32_P_4rnd_M","FIR_Zuni_Fairing_Mk32_P_8rnd_M","FIR_ALQ99_P_1rnd_M",
	"FIR_ALQ99Hi_P_1rnd_M","FIR_ECMPod_P_1rnd_M","FIR_ALQ184_2_P_1rnd_M","FIR_Mk76_P_1rnd_M","FIR_Mk76_P_2rnd_M",
	"FIR_Mk76_P_3rnd_M","FIR_ATFLIR_2_P_1rnd_M","FIR_Litening_std_P_1rnd_M","FIR_SniperXR_2_P_1rnd_M",
	"FIR_AWW13_P_1rnd_M","js_jc_120Rnd_CMChaff_Magazine",
	"js_jc_120Rnd_CMFlare_Magazine","js_m_fa18_buddypod_x1","USAF_PylonRack_1Rnd_AGM65K","FIR_APKWS_M282_P_7rnd_M","FIR_APKWS_P_7rnd_M","js_m_fa18_wing_tank_x1",
	"rhs_mag_aim120","FIR_Meteor_P_1rnd_M","FIR_GBU10_PW1_P_1rnd_M","PylonMissile_Missile_HARM_x1","CUP_PylonPod_ALQ_131","USAF_PylonRack_1Rnd_AGM154C"
	];

["JS_JC_FA18E", "InitPost", {
    params ["_vehicle"];
		private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};
	_vehicle setVariable ["ace_pylons_magazineWhitelist", JS_JC_FA18E, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;


CUP_B_F35B_BAF = ["CUP_PylonPod_1Rnd_AIM_9L_LAU_Sidewinder_M","FIR_Litening_std_P_1rnd_M","FIR_AGM65G_P_1rnd_M","FIR_GBU38_P_1rnd_M","PylonMissile_1Rnd_Bomb_04_F","CUP_PylonWeapon_220Rnd_TE1_Red_Tracer_GAU22_M","FIR_EGBU12_P_2rnd_M","FIR_EGBU12_P_2rnd_M","FIR_AIM9X_P_2rnd_M","CUP_PylonPod_ANAAQ_28","CUP_PylonPod_1Rnd_AIM_120_AMRAAM_M"];
CUP_B_F35B_USMC = CUP_B_F35B_BAF;

["CUP_B_F35B_BAF", "InitPost", {
    params ["_vehicle"];
	private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};

	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_F35B_BAF, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["CUP_B_F35B_USMC", "InitPost", {
    params ["_vehicle"];
	private _pylon = getPylonMagazines _vehicle;
	for "_i" from 1 to (count _pylon) do { 
 	_vehicle setPylonLoadout [_i, "", true]; 
};

	_vehicle setVariable ["ace_pylons_magazineWhitelist", CUP_B_F35B_USMC, true]}, nil, nil, true] call CBA_fnc_addClassEventHandler;




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

["rhsusf_CH53e_USMC_D_cargo", "InitPost", {
    params ["_vehicle"];
	[_vehicle,30] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhsusf_CH53e_USMC_D", "InitPost", {
    params ["_vehicle"];
	[_vehicle,30] call ace_cargo_fnc_setSpace;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["rhsusf_CH53E_USMC_GAU21_D", "InitPost", {
    params ["_vehicle"];
	[_vehicle,30] call ace_cargo_fnc_setSpace;
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
	[_vehicle,24] call ace_cargo_fnc_setSpace;
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

["I_LT_01_scout_F", "InitPost", {
    params ["_vehicle"];
	[
		_vehicle,
		["Indep_Olive",1], 
		["showTools",1,"showCamonetHull",0,"showBags",0,"showSLATHull",0]
	] call BIS_fnc_initVehicle;
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

["I_Plane_Fighter_04_F", "InitPost", {
    params ["_vehicle"];
	[
		_vehicle,
		["CamoGrey",1], 
		true
	] call BIS_fnc_initVehicle;
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
	["Helicopter", "CAN_SLING", "All"]
];
// ["Air", "CANT_SLING", "Tank"],

 //Tow
SA_MAX_TOWED_CARGO = 1;
SA_TOW_RULES_OVERRIDE =[
	["All", "CAN_TOW", "All"],
	["All", "CANT_TOW", "ReammoBox_F"],
	["Car", "CANT_TOW", "Tank"],
	["Air", "CANT_TOW", "Air"]
];

//[AiCacheDistance(players),TargetFPS(-1 for Auto),Debug,CarCacheDistance,AirCacheDistance,BoatCacheDistance]execvm "zbe_cache\main.sqf";
// if (isServer) then {[2000,-1,false,100,1000,100]execvm "zbe_cache\main.sqf"};


// MilSim United ===========================================================================





diag_log "--- Init stop ---";
