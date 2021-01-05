params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitPartIndex", "_instigator"];

// private _msg = format ["DBG: unit:%1 side:%2 source:%3 --  new damage:%4 old damage:%5", _unit, side group _unit, _source, _damage, damage _unit];
// diag_log _msg;

if (!(isNull _instigator)) then {
	_source = _instigator;
} else {
	if (!(_source isKindOf "CAManBase")) then {
		_source = effectiveCommander _source;
	};
};

private _ret = _damage;
private _isAlerted = _unit getVariable ["GRLIB_isAlerted", 0];
private _veh_unit = vehicle _unit;
private _veh_killer = vehicle _killer;

if (isPlayer _source && side group _unit == GRLIB_side_friendly && _unit != _source  && _veh_unit != _veh_killer && _isAlerted == 0 ) then {
	_unit setVariable ["GRLIB_isAlerted", 1, true];
	gamelogic globalChat (format ["%1 - %2 Watch your fire !! ", localize "STR_FRIENDLY_FIRE", name _source]);
	[_source, -5] remoteExec ["addScore", 2];
	[_unit] spawn { sleep 3;(_this select 0) setVariable ["GRLIB_isAlerted", 0, true] };
	_isAlerted = 1;
};

if (_isAlerted == 1) then {
	_ret = (damage _unit) min 0.86;
};

_ret;