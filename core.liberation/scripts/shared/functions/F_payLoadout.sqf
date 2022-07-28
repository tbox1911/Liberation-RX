params ["_unit"];
private ["_price", "_oldprice" ];

if (_price > _oldprice) then {
	if (!([_price - _oldprice] call F_pay)) then {
		[_unit, GRLIB_backup_loadout] call F_setLoadout;
		_price = _oldprice;
	};
};