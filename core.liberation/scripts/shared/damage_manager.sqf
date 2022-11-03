params ["_unit", "_selection", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];

if (isNull _unit) exitWith {0};
if (!(isNull _instigator)) then {
	if (isNull (getAssignedCuratorLogic _instigator)) then {
	   	_killer = _instigator;
	};
} else {
	if (!(_killer isKindOf "CAManBase")) then {
		_killer = effectiveCommander _killer;
	};
};

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

	// Static AI
	if ( typeOf _unit in static_vehicles_AI ) then {
		if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
			_ret = damage _unit + (_amountOfDamage min 0.15);
			_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
		} else {
			_ret = damage _unit;
		};
	};
};

if (isPlayer _unit && GRLIB_ACE_medical_enabled) then {
	if !(_unit getVariable ["ACE_isUnconscious", false]) then {
		_unit setVariable ["GREUH_isUnconscious", 1, true];
		_unit setVariable ["PAR_isUnconscious", 1, true];
		_unit switchMove "AinjPpneMstpSnonWrflDnon";  // lay down
		_unit playMoveNow "AinjPpneMstpSnonWrflDnon";
	};
	//  else {
	// 	_unit setVariable ["GREUH_isUnconscious", 0, true];
	// 	_unit setVariable ["PAR_isUnconscious", 0, true];
	// 	_unit playMove "amovppnemstpsraswrfldnon";
	// 	_unit playMove "";
	// };
	_ret = _amountOfDamage min 0.86 
};

_ret;
