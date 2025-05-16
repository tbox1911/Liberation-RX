params ["_key"];
(GRLIB_LRX_params getOrDefault [_key, +(LRX_Mission_Params getOrDefault [_key, createHashMap])]) getOrDefault [GRLIB_PARAM_ValueKey,0];