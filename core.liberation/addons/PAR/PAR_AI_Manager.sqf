// PAR Manage AI

private _comm_id1 = 0;
private ["_unit", "_is_medic", "_has_medikit", "_wnded_list", "_wnded", "_have_priso"];

while {true} do {
	waitUntil { sleep 1; count (units player) > 1 };
	//PAR_AI_bros = ((units player) + (units GRLIB_side_civilian)) select {!isPlayer _x && alive _x && (_x getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1", PAR_Grp_ID]};
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

			// AI Rating
			if (rating _unit <= 3000) then { _unit addRating 7500 };

			// AI stop doing shit !
			if (([player] call PAR_is_wounded) && (leader (group player) != player) && isNil {_unit getVariable "PAR_busy"}) then {
				doStop _unit;
			};

			// AI revive
			if (PAR_ai_revive_max > 0) then {
				// Medic Auto Heal units
				if (PAR_revive != 0 && behaviour player in ["SAFE", "AWARE"]) then {
					[_unit] call PAR_fn_heal;
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
			sleep 0.2;
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

	sleep 5;
};
