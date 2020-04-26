// Farooq's Revive 1.5

// Seconds until unconscious unit bleeds out and dies. Set to 0 to disable.
FAR_BleedOut = 300;
// Enable teamkill notifications
FAR_EnableDeathMessages = true;
// If enabled, unconscious units will not be able to use ACRE radio, hear other people or use proximity chat
FAR_MuteACRE = false;
/*
	0 = Only medics can revive
	1 = All units can revive
	2 = Same as 1 but a medikit is required to revive
*/
FAR_ReviveMode = ( GRLIB_revive - 1 );
//------------------------------------------//
#define SCRIPT_VERSION "1.5"
FAR_isDragging = false;
FAR_isDragging_EH = [];
FAR_deathMessage = [];
FAR_tkMessage = [];
FAR_Debugging = true;

call compile preprocessFile "addons\TKP\tk_init.sqf";
call compile preprocessFile "addons\FAR\FAR_funcs.sqf";
if (isDedicated) exitWith {};

FAR_Player_MPKilled = {
	params ["_unit"];
	_pos = getPosATL _unit;
	_isplayer = player == _unit;
	removeAllWeapons _unit;
	deleteVehicle _unit;

	if (_isplayer) then {
		if ( _pos distance2D lhd >= 1000 && _pos distance2D ([] call F_getNearestFob) >= GRLIB_sector_size ) then {
			_unit setPos zeropos;
			_grave = ["Land_Grave_rocks_F", "Land_Grave_forest_F", "Land_Grave_dirt_F"] call BIS_fnc_selectRandom;
			createVehicle [_grave, _pos, [], 0, "CAN_COLLIDE"];
		};
	};
};

FAR_Player_Init = {
	// Clear event handler before adding it
	player removeAllEventHandlers "HandleDamage";
	player addEventHandler ["HandleDamage", FAR_HandleDamage_EH];
	player removeAllMPEventHandlers "MPKilled";
	player addMPEventHandler ["MPKilled", FAR_Player_MPKilled];
	player setVariable ["GREUH_isUnconscious", 0, true];
	player setVariable ["FAR_isUnconscious", 0, true];
	player setVariable ["FAR_isStabilized", 0, true];
	player setVariable ["FAR_isDragged", 0, true];
	player setVariable ["ace_sys_wounds_uncon", false];
	player setVariable [format["Bros_%1", MGI_Grp_ID], true];
	player setVariable ["MGI_soliders",true,true];
	player setVariable ["MGI_isUnconscious", false];
	player setVariable ["MGI_myMedic", nil];
	player setVariable ["MGI_busy", nil];
	player setVariable ["AirCoolDown", 0, true];
	if ( !GRLIB_fatigue ) then {
		player enableStamina false;
	};
	player setCustomAimCoef 0.35;
	player setUnitRecoilCoefficient 0.6;
	player setCaptive false;
	player setMass 10;
	FAR_isDragging = false;
	[] spawn FAR_Player_Actions;
	[player] spawn player_EVH;
};

////////////////////////////////////////////////
// Player Initialization
////////////////////////////////////////////////
waituntil {sleep 1;!isNull player};
waitUntil {sleep 1;GRLIB_player_spawned};

// Public event handlers
"FAR_isDragging_EH" addPublicVariableEventHandler FAR_public_EH;
"FAR_deathMessage" addPublicVariableEventHandler FAR_public_EH;
"FAR_tkMessage" addPublicVariableEventHandler FAR_public_EH;
"BTC_tk_PVEH" addPublicVariableEventHandler BTC_fnc_tk_PVEH;
[] spawn FAR_Player_Init;

if (FAR_MuteACRE) then {[] spawn FAR_Mute_ACRE};

// Event Handlers
player addEventHandler ["Respawn", {[] spawn FAR_Player_Init}];

// Cache player's side
FAR_PlayerSide = side player;

private _uid = getPlayerUID player;
if (isNil {BTC_logic getVariable _uid}) then {
	BTC_logic setVariable [_uid,0,true];
	BTC_teamkiller = 0;
} else {
	BTC_teamkiller = BTC_logic getVariable _uid;
	if (BTC_teamkiller > BTC_tk_last_warning) then {[] spawn BTC_Teamkill;}
};

// Drag & Carry animation fix
[] spawn {
	while {true} do
	{
		if (animationState player == "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon" || animationState player == "helper_switchtocarryrfl" || animationState player == "AcinPknlMstpSrasWrflDnon") then
		{
			if (FAR_isDragging) then {
				player switchMove "AcinPknlMstpSrasWrflDnon";
			} else {
				player switchMove "amovpknlmstpsraswrfldnon";
			};
		};
		sleep 3;
	}
};

FAR_Mute_ACRE = {
	waitUntil {
		if (alive player) then {
			if ((player getVariable["ace_sys_wounds_uncon", false])) then {
				private["_saveVolume"];
				_saveVolume = acre_sys_core_globalVolume;
				player setVariable ["acre_sys_core_isDisabled", true, true];
				waitUntil {
					acre_sys_core_globalVolume = 0;
					if (!(player getVariable["acre_sys_core_isDisabled", false])) then {
						player setVariable ["acre_sys_core_isDisabled", true, true];
						[true] call acre_api_fnc_setSpectator;
					};
					!(player getVariable["ace_sys_wounds_uncon", false]);
				};
				if ((player getVariable["acre_sys_core_isDisabled", false])) then {
					player setVariable ["acre_sys_core_isDisabled", false, true];
					[false] call acre_api_fnc_setSpectator;
				};
				acre_sys_core_globalVolume = _saveVolume;
			};
		} else {
			waitUntil { alive player };
		};
		sleep 0.25;
		false
	};
};

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- TK Protect Initialized --------";
systemChat "-------- FAR Revive Initialized --------";
