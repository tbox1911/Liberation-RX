params [ "_unit", [ "_sector", "" ] ];

_unit setUnitPos "UP";
_unit disableAI "MOVE";

private _move_is_disabled = true;
private _resume_movement = false;
private _target = objNull;
private _hostilecount = 0;

while { _move_is_disabled && local _unit && alive _unit && !(captive _unit) } do {
	_hostilecount = { alive _x && _x distance2D (getPosATL _unit) < 50 } count (units GRLIB_side_friendly);

	if ( _hostilecount > 0 || ( damage _unit > 0.25 ) || _sector in blufor_sectors ) then {
		_resume_movement = true;
	};

	if ( _resume_movement ) then {
		if ( _move_is_disabled ) then {
			_move_is_disabled = false;
			_unit enableAI "MOVE";
			_unit setUnitPos "AUTO";
			_unit switchMove "AmovPercMwlkSrasWrflDf";
			_unit playMoveNow "AmovPercMwlkSrasWrflDf";
			(group _unit) setCombatMode "RED";
			(group _unit) setCombatBehaviour "COMBAT";
		};
	};

	if ( _move_is_disabled ) then {
		_target = assignedTarget _unit;
		if(!(isnull _target)) then {
			_vd2 = (getPosASL _target) vectorDiff (getpos _unit);
			_newdir2 = (_vd2 select 0) atan2 (_vd2 select 1);
			if (_newdir2 < 0) then {_dir = 360 + _newdir2 };
			_unit setdir (_newdir2);
		};
	};

	sleep 3;
};
