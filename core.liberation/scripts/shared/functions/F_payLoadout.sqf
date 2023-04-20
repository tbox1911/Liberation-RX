params ["_unit"];
private ["_price", "_oldprice", "_cost", "_ammo_collected"];

waitUntil {!isNil {_unit getVariable ["GREUH_ammo_count", nil]}};

_price = [_unit] call F_loadoutPrice;
_oldprice = _unit getVariable ["GREUH_stuff_price", _price];

if (_price > _oldprice) then {
	_ammo_collected = _unit getVariable ["GREUH_ammo_count",0];
	_cost = (_price - _oldprice);
	if (_ammo_collected < _cost) then {
		hint format ["No Enought Ammo !!\nLoadout Price: %1\nYour Ammo: %2", _cost, _ammo_collected];
		[_unit, GRLIB_backup_loadout] call F_setLoadout;
	} else {
		_unit setVariable ["GREUH_ammo_count", (_ammo_collected - _cost), true];
		_unit setVariable ["GREUH_stuff_price", _price];
		playSound "rearm";
		hintSilent format ["You pay: %1\nThank you !", _cost];
		gamelogic globalChat format ["You pay: %1, Thank you !", _cost];
	};
};
