params ["_unit", "_selection", "_damage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];

// private _msg = format ["DBG: unit:%1 side:%2 source:%3 --  new damage:%4 old damage:%5", _unit, side group _unit, _killer, _damage, damage _unit];
// diag_log _msg;

if (!(isNull _instigator)) then {
	_killer = _instigator;
} else {
	if (!(_killer isKindOf "CAManBase")) then {
		_killer = effectiveCommander _killer;
	};
};

private _ret = _damage;
private _veh_unit = vehicle _unit;
private _veh_killer = vehicle _killer;
private _isAlerted = _killer getVariable ["GRLIB_isAlerted", 0];

if (isPlayer _killer && side group _unit == GRLIB_side_friendly && _unit != _killer && _veh_unit != _veh_killer && _isAlerted == 0) then {
	_killer setVariable ["GRLIB_isAlerted", 1, true];
	gamelogic globalChat (format ["%1 - %2 Watch your fire !! ", localize "STR_FRIENDLY_FIRE", name _killer]);
	[_killer, -5] remoteExec ["addScore", 2];
	[_killer] spawn { sleep 3;(_this select 0) setVariable ["GRLIB_isAlerted", 0, true] };
	_isAlerted = 1;
};

if (isPlayer _killer && side group _unit == GRLIB_side_enemy && _unit != _killer && _veh_unit != _unit && _veh_killer == _killer && round (_killer distance2D _unit) <= 2 && _isAlerted == 0) then {
	_killer setVariable ["GRLIB_isAlerted", 1, true];
	gamelogic globalChat (format ["Stop cheating %1!! ", name _killer]);
	(group _unit) reveal _killer;
	(gunner _veh_unit) doTarget _killer;
	_veh_unit fireAtTarget [_killer];
	[_killer] spawn { sleep 3;(_this select 0) setVariable ["GRLIB_isAlerted", 0, true] };
	_isAlerted = 1;
};

if (_isAlerted == 1) then {
	_ret = (damage _unit) min 0.86;
};

_ret;