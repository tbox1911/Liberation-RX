params ["_unit"];
private ["_price", "_oldprice" ];

_price = [_unit] call F_loadoutPrice;
_oldprice = _unit getVariable ["GREUH_stuff_price", _price];

_hs_hint = format['_price: %1', _price];
[_hs_hint, 'hs_MPhint'] call BIS_fnc_mp;

/*
if (_price > _oldprice) then {
	if (!([_price - _oldprice] call F_pay)) then {
		[_unit, GRLIB_backup_loadout] call F_setLoadout;
		_price = _oldprice;
	};
};
[_price - _oldprice] call F_pay;
*/


_unit setVariable ["GREUH_stuff_price", _price];