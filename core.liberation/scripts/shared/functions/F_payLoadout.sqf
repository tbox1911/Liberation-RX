params ["_unit"];

private _price = [_unit] call F_loadoutPrice;
private _oldprice = _unit getVariable ["GREUH_stuff_price", _price];

if (_price > _oldprice) then {
	if (!([_price - _oldprice] call F_pay)) then {
		_unit setUnitLoadout [GRLIB_backup_loadout, true];
		_price = _oldprice;
	};
};
_unit setVariable ["GREUH_stuff_price", _price, true];