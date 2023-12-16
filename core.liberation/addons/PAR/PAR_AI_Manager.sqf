// PAR Manage AI

private _comm_id1 = 0;
private ["_unit", "_is_medic", "_has_medikit", "_wnded_list", "_wnded", "_have_priso"];

while {true} do {
    PAR_AI_bros = ((units player) + (units GRLIB_side_civilian)) select {!isplayer _x && alive _x && (_x getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1", PAR_Grp_ID]};
    if (count PAR_AI_bros > 0 ) then {
        {
            _unit = _x;
            // Set PAR EventHandler
            //[_x] spawn PAR_fn_AI_Damage_EH;

            if (GRLIB_revive != 0) then {

                // Medic can heal auto
                _wnded_list = (units player) select {
                    (_x distance2D _unit) < 30 &&
                    !(surfaceIsWater (getPos _x)) &&
                    isNull objectParent _x &&
                    damage _x >= 0.1 &&
                    behaviour _x != "COMBAT" &&
                    isNil {_x getVariable 'PAR_busy'} &&
                    isNil {_x getVariable 'PAR_healed'}
                };

                if (count _wnded_list > 0) then {
                    _is_medic = [_unit] call PAR_is_medic;
                    _has_medikit = [_unit] call PAR_has_medikit;
                	_wnded = _wnded_list select 0;
                    if (_is_medic && _has_medikit &&
                        isNull objectParent _unit &&
                        (behaviour _unit) != "COMBAT" &&
                        (currentCommand _unit != "STOP") &&
                        lifeState _unit != 'INCAPACITATED' &&
                        isNil {_unit getVariable 'PAR_busy'} &&
                        isNil {_unit getVariable 'PAR_heal'}
                    ) then {
                        [_unit, _wnded] spawn PAR_fn_heal;
                    };
                };

                // AI stop doing shit !
                if ( leader group player != player &&
                    lifeState player == 'INCAPACITATED' &&
                    lifeState _unit != 'INCAPACITATED' &&
                    isNil {_unit getVariable 'PAR_busy'} &&
                    isNil {_unit getVariable 'PAR_heal'}
                ) then {
                    if (currentCommand _unit != "STOP") then {
                        doStop _unit;
                        if (_unit distance2D player <= 500) then {
                            unassignVehicle _unit;
                            [_unit] orderGetIn false;
                            if (!isnull objectParent _unit) then {
                                doGetOut _unit;
                                sleep 3;
                            };
                            _unit doMove (getPos player);
                            [_unit] doFollow (leader group player);;
                        };
                    };
                };
            };

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
                    _msg = format ["%1 was promoted to the rank of %2 !", name _unit, _ai_rank];
                    [_unit, _msg] call PAR_fn_globalchat;
                    _unit setVariable ["PAR_AI_score", ((GRLIB_rank_level find (rank _unit)) + 1) * 5, true];
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

    sleep 5;
};
