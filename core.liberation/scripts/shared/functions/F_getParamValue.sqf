params ["_key"];
private _ret = 0;

private _defaultHash = LRX_Mission_Params get _key;
if (!isNil "_defaultHash") then {
	_ret = (GRLIB_LRX_params getOrDefault[_key, +_defaultHash]) get GRLIB_PARAM_ValueKey;
};
_ret;