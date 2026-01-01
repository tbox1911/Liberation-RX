//--- LRX Client Misson Parameters ----------------------------------------
diag_log "--- LRX: Loading client settings ---";

// Edit Mission settings
call compileFinal preprocessFileLineNumbers "scripts\client\ui\settings_menu.sqf";

// Mission Parameter constant
[] call compileFinal preprocessFileLineNumbers "mission_params.sqf";

waitUntil { sleep 1; !isNil "GRLIB_LRX_params" };
if (!GRLIB_ParamsInitialized) then {
	[] execVM "scripts\client\commander\open_params.sqf";
	waitUntil { sleep 1; GRLIB_ParamsInitialized };
};

// LRX Selectable
if (!isServer) then { [] call F_readParamsLRX };

// PAR Revive
PAR_revive = ["PAR_Revive"] call lrx_getParamValue;
PAR_ai_revive_max = ["PAR_AI_Revive"] call lrx_getParamValue;
PAR_bleedout = ["PAR_BleedOut"] call lrx_getParamValue;
PAR_grave = ["PAR_Grave"] call lrx_getParamValue;

// Disable PAR/Fatigue if ACE Medical is present
if (GRLIB_ACE_medical_enabled) then { PAR_revive = 0; GRLIB_fatigue = 1 };

waitUntil { sleep 1; !isNil "GRLIB_LRX_server_params_loaded" };
diag_log "--- LRX: Client settings loaded ---";