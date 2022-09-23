params ["_item"];
if (isNil "_item") exitWith { false };

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
		if !(_item in GRLIB_whitelisted_from_arsenal || [_item] call F_belongToMod) then { _ret = false };        
	};
};

_ret; 
