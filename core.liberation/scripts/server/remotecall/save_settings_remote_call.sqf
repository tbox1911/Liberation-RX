if (!isServer && hasInterface) exitWith {};

params ["_params"];

profileNamespace setVariable [GRLIB_paramsV2_save_key, _params];
saveProfileNamespace;
GRLIB_LRX_params = _params;
publicVariable "GRLIB_LRX_params";
GRLIB_ParamsInitialized = true;
publicVariable "GRLIB_ParamsInitialized";

diag_log format ["--- LRX: Save settings to %1",  GRLIB_paramsV2_save_key];
