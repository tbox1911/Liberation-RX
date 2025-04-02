// PAR Manage AI

private _comm_id1 = 0;
private ["_unit", "_is_medic", "_has_medikit", "_wnded_list", "_wnded", "_have_priso"];

while {true} do {
	waitUntil { sleep 1; count (units player) > 1 };
	//PAR_AI_bros = ((units player) + (units GRLIB_side_civilian)) select {!isPlayer _x && alive _x && (_x getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1", PAR_Grp_ID]};
	PAR_AI_bros = PAR_AI_bros select { alive _x };
	if (count PAR_AI_bros > 0) then {
		{
			_unit = _x;

			// Blood trail
			if (damage _unit > 0.6 && isNull objectParent _unit && !(surfaceIsWater (getPos _unit))) then {
				private _spray = createVehicle ["BloodSpray_01_New_F", getPos _unit, [], 0, "CAN_COLLIDE"];
				_spray spawn {sleep (10 + floor(random 5)); deleteVehicle _this};
			};

			// AI level UP
			private _ai_score = _unit getVariable ["PAR_AI_score", nil];
			private _ai_skill = skill _unit;
			if (!isNil "_ai_score") then {
				if (_ai_score <= 0 && _ai_skill < 0.85) then {
					private _ai_rank = GRLIB_rank_level select (GRLIB_rank_level find (rank _unit)) + 1;
					_unit setSkill (_ai_skill + 0.05);
					_unit setUnitRank _ai_rank;
					_msg = format [localize "STR_PAR_PROMOTION_MESSAGE", name _unit, _ai_rank];
					[_unit, _msg] call PAR_fn_globalchat;
					_unit setVariable ["PAR_AI_score", ((GRLIB_rank_level find (rank _unit)) + 1) * 5, true];
				};
			};

			// AI stop doing shit !
			private _not_leader = !(leader (group player) == player);
			if (([player] call PAR_is_wounded) && _not_leader) then {
				if (_unit distance2D player <= 500) then {
					unassignVehicle _unit;
					[_unit] orderGetIn false;
					if !(isNull objectParent _unit) then {
						if !("turret" in (assignedVehicleRole _unit)) then {
							[_unit, false] spawn F_ejectUnit;
						};
					};
				};
			};

			// AI revive
			if (PAR_AI_reviveMax > 0) then {
				// Auto heal units
				if (PAR_revive != 0 && behaviour player in ["SAFE", "AWARE"] && isNull objectParent _unit) then {
					if ([_unit] call PAR_is_wounded) exitWith {};
					_is_medic = [_unit] call PAR_is_medic;
					_has_medikit = [_unit] call PAR_has_medikit;
					_not_busy = _unit getVariable "PAR_busy";
					_not_healing = _unit getVariable "PAR_heal";
					if (isNil "_not_busy" && isNil "_not_healing" && _is_medic && _has_medikit) then {
						_wnded_list = PAR_AI_bros + [player] select {
							(_x distance2D _unit) < 30 &&
							!(surfaceIsWater (getPos _x)) &&
							isNull objectParent _x &&
							damage _x >= 0.1 &&
							!([_x] call PAR_is_wounded) &&
							isNil {_x getVariable "PAR_busy"} &&
							isNil {_x getVariable "PAR_heal"}
						};

						// go heal
						if (count _wnded_list > 0) then {
							_wnded = _wnded_list select 0;
							[_unit, _wnded] spawn PAR_fn_heal;
							sleep 2;
						};
					};
				};

				// AI medical status
				private _msg = "";
				private _cur_revive = ([_unit] call PAR_revive_cur);
				private _timer = _unit getVariable ["PAR_revive_msg_timer", 0];
				private _history = _unit getVariable ["PAR_revive_history", []];
				if (count _history > 0) then {
					private _first = _history select 0;
					if (time >= _first) then {
						_history deleteAt 0;
						_unit setVariable ["PAR_revive_history", _history];
						_msg = format [localize "STR_PAR_REVIVE_RESTORED", name _unit, _cur_revive];
						_timer = 0;
					} else {
						private _near_medical = (count (nearestObjects [_unit, [medic_heal_typename, a3w_heal_tent], 12]) > 0);
						if (_near_medical) then {
							_history set [0, (_first - 60)];
							_unit setVariable ["PAR_revive_history", _history];
							if (_unit distance2D player < 30) then {
								_msg = format [localize "STR_PAR_HEALING_FASTER", name _unit];
								_timer = 0;
							};
						};
					};
				};

				if (_msg == "") then {
					if (_cur_revive <= 3) then {
						_msg = format [localize "STR_PAR_NEED_MEDICAL_SUPPORT", name _unit];
						_timer = 0;
					};
					if (_cur_revive == 0) then {
						_msg = format [localize "STR_PAR_CRITICAL_NO_REVIVE", name _unit];
						_timer = 0;
					};
				};
				if (time > _timer && _msg != "") then {
					[_unit, _msg] call PAR_fn_globalchat;
					_unit setVariable ["PAR_revive_msg_timer", round (time + (3 * 60))];
				};
			};
			sleep 0.3;
		} forEach PAR_AI_bros;
	};

	_have_priso = { !(isNil {_x getVariable "GRLIB_is_prisoner"}) } count (units player);
	if (_have_priso > 0) then {
		if (_comm_id1 == 0) then {
			_comm_id1 = [player,"LRX_Abandon",nil,nil,""] call BIS_fnc_addCommMenuItem;
		};
	} else {
		if (_comm_id1 != 0) then {
			[player, _comm_id1] call BIS_fnc_removeCommMenuItem;
			_comm_id1 = 0;
		};
	};

	sleep 10;
};
