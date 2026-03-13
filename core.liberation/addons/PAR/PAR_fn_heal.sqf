params ["_unit"];

if (isNull objectParent _unit && !([_unit] call PAR_is_wounded)) then {
	_is_medic = [_unit] call PAR_is_medic;
	_has_medikit = [_unit] call PAR_has_medikit;
	if (_is_medic && _has_medikit) then {
		if (damage _unit >= 0.1) then {
			if (isNull objectParent _unit && !(surfaceIsWater (getPos _unit))) then {
				_unit setVariable ["PAR_healing", _unit];
				_unit switchMove "AinvPknlMstpSlayWnonDnon_medic";
				_unit playMoveNow "AinvPknlMstpSlayWnonDnon_medic";
				sleep 5;
				_unit setVariable ["PAR_healing", nil];
				if ([_unit] call PAR_is_wounded) exitWith {};
				_unit setDamage 0;
			};
		} else {
			private _wnded_list = (PAR_AI_bros + [player]) select {
				(_x distance2D _unit) < 30 &&
				!(surfaceIsWater (getPos _x)) &&
				isNull objectParent _x &&
				round(speed _x) <= 1 &&
				(damage _x) >= 0.1 &&
				!([_x] call PAR_is_wounded) &&
				isNil {_x getVariable "PAR_busy"} &&
				isNil {_x getVariable "PAR_healing"}
			};
			if (count _wnded_list > 0) then {
				private _wnded = (_wnded_list select 0);
				_unit doMove (getPosATL _wnded);
				sleep 10;
				if ([_unit] call PAR_is_wounded) exitWith {};
				if (_unit distance2D _wnded <= 6) then {
					if ([_wnded] call PAR_is_wounded) exitWith {};
					_wnded setVariable ["PAR_healing", _unit];
					_unit setDir (_unit getDir _wnded);
					_unit switchMove "AinvPknlMstpSlayWrflDnon_medicOther";
					_unit playMoveNow "AinvPknlMstpSlayWrflDnon_medicOther";
					sleep 6;
					_wnded setVariable ["PAR_healing", nil];
					if (_unit distance2D _wnded > 6 || ([_wnded] call PAR_is_wounded) || ([_unit] call PAR_is_wounded)) exitWith {};
					_wnded setDamage 0;
				};
			};
		};
	};
};
