params ["_param"];
private _ret = [_param, ["PARAM ERROR !!"], [0]];

private _hash = LRX_Mission_Params get _param;
if (!isNil "_hash") then {
	_ret = [_hash get GRLIB_PARAM_NameKey, _hash get GRLIB_PARAM_OptionLabelKey, _hash get GRLIB_PARAM_OptionValuesKey];
};
_ret;