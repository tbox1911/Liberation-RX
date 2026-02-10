params ["_unit"];

if (isNull objectParent _unit && !([_unit] call PAR_is_wounded)) then {
	_is_medic = [_unit] call PAR_is_medic;
	_has_medikit = [_unit] call PAR_has_medikit;
	if (_is_medic && _has_medikit) then {
		if (damage _unit >= 0.1) then {
			if (isNull objectParent _unit && !(surfaceIsWater (getPos _unit))) then {
				[_unit] spawn {
					params ["_unit"];
					_unit setVariable ["PAR_healing", _unit];
					_unit action ["HealSoldierSelf", _unit];
					sleep 5;
					_unit setVariable ["PAR_healing", nil];
					_unit setDamage 0;
				};
			};
		} else {
			_wnded_list = (PAR_AI_bros + [player]) select {
				(_x distance2D _unit) < 30 &&
				!(surfaceIsWater (getPos _x)) &&
				isNull objectParent _x &&
				damage _x >= 0.1 &&
				!([_x] call PAR_is_wounded) &&
				isNil {_x getVariable "PAR_busy"} &&
				isNil {_x getVariable "PAR_healing"}
			};
			if (count _wnded_list > 0) then {
				[_unit, _wnded_list] spawn {
					params ["_unit", "_wnded_list"];
					private _wnded = (_wnded_list select 0);
					_wnded setVariable ["PAR_healing", _unit];
					_unit action ["HealSoldier", _wnded];
					sleep 20;  // or wnded damage == 0
					if (_unit distance2D _wnded <= 6) then { _wnded setDamage 0 };
					_wnded setVariable ["PAR_healing", nil];
				};
			};
		};
	};
};
