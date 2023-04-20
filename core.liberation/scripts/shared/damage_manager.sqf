params ["_unit", "_selection", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];

if (isNull _unit) exitWith {0};
if (!(isNull _instigator)) then {
	_killer = _instigator;
} else {
	if (!(_killer isKindOf "CAManBase")) then {
		_killer = effectiveCommander _killer;
	};
};

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
private _ret = _damage;
<<<<<<< HEAD
private _veh_unit = vehicle _unit;
private _veh_killer = vehicle _killer;
private _isAlerted = _killer getVariable ["GRLIB_isAlerted", 0];

if (isPlayer _killer && side group _unit == GRLIB_side_friendly && _unit != _killer && _veh_unit != _veh_killer && _isAlerted == 0) then {
	_killer setVariable ["GRLIB_isAlerted", 1, true];
	gamelogic globalChat (format ["%1 - %2 Watch your fire !! ", localize "STR_FRIENDLY_FIRE", name _killer]);
	[_killer, -5] remoteExec ["addScore", 2];
	[_killer] spawn { sleep 3;(_this select 0) setVariable ["GRLIB_isAlerted", 0, true] };
=======
private _isAlerted = _unit getVariable ["GRLIB_isAlerted", 0];
private _veh_unit = vehicle _unit;
private _veh_killer = vehicle _killer;

if (isPlayer _source && side group _unit == GRLIB_side_friendly && _unit != _source  && _veh_unit != _veh_killer && _isAlerted == 0 ) then {
	_unit setVariable ["GRLIB_isAlerted", 1, true];
	gamelogic globalChat (format ["%1 - %2 Watch your fire !! ", localize "STR_FRIENDLY_FIRE", name _source]);
	[_source, -5] remoteExec ["addScore", 2];
	[_unit] spawn { sleep 3;(_this select 0) setVariable ["GRLIB_isAlerted", 0, true] };
>>>>>>> 3e11c31c (add instigator)
	_isAlerted = 1;
=======
=======
private _veh_unit = vehicle _unit;
// Eject
if (_veh_unit != _unit && damage _veh_unit > 0.8) then {[_veh_unit, _unit, true] spawn PAR_fn_eject};

>>>>>>> d14c2092 (fix eject)
=======
>>>>>>> d8a0a01f (1)
private _ret = _amountOfDamage;
if (!isNull _killer && _unit != _killer) then {
	private _veh_unit = vehicle _unit;
	private _veh_killer = vehicle _killer;

	// Friendly fires penalty AI
	if (isPlayer _killer && !(isPlayer _unit) && side group _unit == GRLIB_side_friendly && _unit != _killer && _veh_unit != _veh_killer && lifeState _unit != "INCAPACITATED" && _amountOfDamage > 0.15 ) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			private _msg = format ["%1 - %2 Watch your fire !! ", localize "STR_FRIENDLY_FIRE", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			[_killer, -5] remoteExec ["addScore", 2];
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
		};
		if (GRLIB_revive != 0) then { _ret = _amountOfDamage min 0.86 };
	};

	// OpFor in vehicle
	if (isPlayer _killer && side group _unit == GRLIB_side_enemy && _unit != _killer && _veh_unit != _unit && _veh_killer == _killer && round (_killer distance2D _unit) <= 2) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			private _msg = format ["%1 Stop Cheating !!", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", owner _killer];
			(group _unit) reveal _killer;
			(gunner _veh_unit) doTarget _killer;
			_veh_unit fireAtTarget [_killer];
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
		};
		_ret = 0;
	};
<<<<<<< HEAD
>>>>>>> 116adc5b (HandleDamage rewrite)
=======

	// Static AI
	if ( typeOf _unit in static_vehicles_AI ) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			_ret = damage _unit + (_amountOfDamage min 0.15);
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
		} else {
			_ret = damage _unit;
		};
	};
>>>>>>> 23851faa (static ai damage manager)
};
_ret;