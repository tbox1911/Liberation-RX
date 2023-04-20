params ["_unit", "_selection", "_damage", "_source" ];

// private _msg = format ["DBG: unit:%1 side:%2 source:%3 --  new damage:%4 old damage:%5", _unit, side group _unit, _source, _damage, damage _unit];
// diag_log _msg;

private _ret = _damage;

if (isPlayer _source && side group _unit == GRLIB_side_friendly && _unit != _source) then {
	gamelogic globalChat (format ["%1 - %2 Watch your fire !! ", localize "STR_FRIENDLY_FIRE", name _source]);
	_ret = damage _unit;
};

_ret;