diag_log "--- Liberation RX by pSiKO ---";
if ((isServer || isDedicated) && !isNil "GRLIB_init_server") exitWith { diag_log "--- LRX Error: Mission restart too fast!" };

titleText ["","BLACK FADED", 100];
disableUserInput true;

[] call compileFinal preprocessFileLineNumbers "build_info.sqf";
diag_log "--- Init start ---";

profileNamespace setVariable ["BIS_SupportDevelopment", nil];
enableSaving [false, false];
disableMapIndicators [false,true,false,false];
setGroupIconsVisible [false,false];

abort_loading = false;
abort_loading_msg = "Unkwon Error";
GRLIB_ACE_enabled = false;

[] call compileFinal preprocessFileLineNumbers "whitelist.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\shared\liberation_functions.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\shared\fetch_params.sqf";
[] call compileFinal preprocessFileLineNumbers "scripts\shared\classnames.sqf";

if (!abort_loading) then {
	[] call compileFinal preprocessFileLineNumbers "scripts\shared\init_shared.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\shared\init_sectors.sqf";
	[] call compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\setupMissionArrays.sqf";
	[] spawn compileFinal preprocessFileLineNumbers "addons\VAM\RPT_init.sqf";

	if (GRLIB_ACE_enabled) then {
		[] call compileFinal preprocessFileLineNumbers "scripts\shared\init_ace.sqf";
	} else {
		[] call compileFinal preprocessFileLineNumbers "R3F_LOG\init.sqf";
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
		disableUserInput false;
		publicVariable "GRLIB_init_server";
		publicVariable "abort_loading";
		publicVariable "abort_loading_msg";
		diag_log "--- LRX Startup Error ---";
		diag_log abort_loading_msg;
	};
};

if (!isDedicated && hasInterface) then {
	[] spawn compileFinal preprocessFileLineNumbers "scripts\client\init_client.sqf";
};

diag_log "--- Init stop ---";
