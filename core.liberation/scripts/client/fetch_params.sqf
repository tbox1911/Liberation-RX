//--- LRX Client Misson Parameters ----------------------------------------
diag_log "--- LRX: Loading client settings ---";

// Edit Mission settings
call compileFinal preprocessFileLineNumbers "scripts\client\ui\settings_menu.sqf";

// Mission Parameter constant
[] call compileFinal preprocessFileLineNumbers "mission_params.sqf";

if (!GRLIB_ParamsInitialized) then {
	waitUntil { sleep 1; !isNil "GRLIB_LRX_params" };

	[] execVM "scripts\client\commander\open_params.sqf";
	waitUntil { sleep 1; GRLIB_ParamsInitialized };
};

waitUntil { sleep 1; !isNil "GRLIB_LRX_server_params_loaded" };
diag_log "--- LRX: Client settings loaded ---";