params ["_key"];
private _value = 0;
_defaultHash = LRX_Mission_Params get _key;
if (!isNil "_defaultHash") then {
	_value = (GRLIB_LRX_params getOrDefault[_key, +_defaultHash]) get GRLIB_PARAM_ValueKey;
};

_value;