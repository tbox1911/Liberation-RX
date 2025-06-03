diag_log "--- Liberation RX by pSiKO ---";
if ((isServer || isDedicated) && !isNil "GRLIB_init_server") exitWith { diag_log "--- LRX Error: Mission restart too fast!" };

disableUserInput true;
titleText ["","BLACK FADED", 100];
0 fadeSound 0;
sleep 5;
if (!isServer && isMultiplayer && count (entities "HeadlessClient_F") > 0) then {
	titleText ["Waiting for Headless client....","BLACK FADED", 100];
	sleep 10;
};

diag_log "--- Init start ---";
titleText ["-- Liberation RX --","BLACK FADED", 100];

[] call compileFinal preprocessFileLineNumbers "build_info.sqf";
diag_log format ["LRX version %1 - build version: %2 build date: %3", localize "STR_MISSION_VERSION", GRLIB_build_version, GRLIB_build_date]; 

profileNamespace setVariable ["BIS_SupportDevelopment", nil];
enableSaving [false, false];
disableMapIndicators [false,true,false,false];
setGroupIconsVisible [false,false];

abort_loading = false;
abort_loading_msg = "Unkwon Error";
GRLIB_ACE_enabled = false;
//GRLIB_LRX_debug = true;

private _path = "\userconfig\whitelist.sqf";
if (fileExists _path) then {
	[] call compileFinal preprocessFile _path;
} else {
	[] call compileFinal preprocessFileLineNumbers "whitelist.sqf";
};

[] call compileFinal preprocessFileLineNumbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\shared\fetch_params.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\shared\classnames.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\server\sector\init_sectors.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\setupMissionArrays.sqf";
sleep 2;

if (!isDedicated && hasInterface) then {
	[] spawn compileFinal preprocessFileLineNumbers "scripts\client\init_client.sqf";
};

if (!abort_loading) then {
	[] call compileFinal preprocessFileLineNumbers "scripts\shared\init_shared.sqf";
	[] spawn compileFinal preprocessFileLineNumbers "addons\VAM\RPT_init.sqf";

	if (GRLIB_ACE_enabled) then {
		[] spawn compileFinal preprocessFileLineNumbers "scripts\shared\init_ace.sqf";
	} else {
		[] spawn compileFinal preprocessFileLineNumbers "R3F_LOG\init.sqf";
	};

	if (isServer) then {
		[] spawn compileFinal preprocessFileLineNumbers "scripts\server\init_server.sqf";
	};

	if (!isDedicated && !hasInterface && isMultiplayer) then {
		[] spawn compileFinal preprocessFileLineNumbers "scripts\server\offloading\hc_manager.sqf";
	};
} else {
	if (isServer) then {
		GRLIB_init_server = false;
		publicVariable "GRLIB_init_server";
		publicVariable "abort_loading";
		publicVariable "abort_loading_msg";
		diag_log "--- LRX Startup Error ---";
		diag_log abort_loading_msg;
	};
};

diag_log "--- Init stop ---";
