params ["_item"];
if (isNil "_item") exitWith { false };
if (_item == "") exitWith { true };
if (GRLIB_filter_arsenal in [0, 4]) exitWith { true };

// Magazines
if (isClass (configFile >> "CFGMagazines" >> _item)) exitWith { true };

// TFAR Radio
if (GRLIB_TFR_enabled && (["TF_", _item] call F_startsWith)) exitWith { true };
if (GRLIB_TFR_enabled && (["TFAR_", _item] call F_startsWith)) exitWith { true };

private _ret = true;
if (GRLIB_blacklisted_from_arsenal find _item >= 0) then {
	_ret = false;
} else {
	{ if (_item find _x >= 0) exitWith { _ret = false } } foreach GRLIB_blacklisted_from_arsenal;
};

if (_ret && LRX_arsenal_init_done) then {
	if (GRLIB_filter_arsenal == 2) then {
		if !(_item in GRLIB_whitelisted_from_arsenal) then { _ret = false };
	};

	if (GRLIB_filter_arsenal == 3) then {
		if !(_item in GRLIB_whitelisted_from_arsenal || ([_item, GRLIB_MOD_signature] call F_startsWithMultiple)) then { _ret = false };
	};
};

_ret;
