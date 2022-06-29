params ["_item"];
if (isNil "_item") exitWith { false };

private _ret = true; 

if (GRLIB_blacklisted_from_arsenal find _item >= 0) then {
	_ret = false;
} else {
	{ 
		if (_item find _x >= 0) exitWith { _ret = false	}; 
	} foreach GRLIB_blacklisted_from_arsenal;
};

_ret; 
