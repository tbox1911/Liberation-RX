// PAR Manage AI

while {true} do {
    PAR_AI_bros = ((units player) + (units GRLIB_side_civilian)) select {!isplayer _x && alive _x && (_x getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1", PAR_Grp_ID]};
    if (count PAR_AI_bros > 0 ) then {
        {
            // Set EH
            //[_x] call PAR_fn_AI_Damage_EH;

            // Medic can heal
            _isMedic = [_x] call PAR_is_medic;
            _hasMedikit = [_x] call PAR_has_medikit;
            if ( _isMedic && _hasMedikit &&
                vehicle _x == _x &&
                (behaviour _x) != "COMBAT" &&
                lifeState _x != 'INCAPACITATED' &&
                isNil {_x getVariable 'PAR_busy'} &&
                isNil {_x getVariable 'PAR_heal'}
                ) then {
                [_x] spawn PAR_fn_checkWounded;
            };

            // AI stop doing shit !
            if ( leader group player != player &&
                lifeState player == 'INCAPACITATED' &&
                lifeState _x != 'INCAPACITATED' &&
                isNil {_x getVariable 'PAR_busy'} &&
                isNil {_x getVariable 'PAR_heal'}
            ) then {
                if (_x distance2D player <= 600) then {
                    doStop _x;
                    unassignVehicle _x;
                    [_x] orderGetIn false;
                    if (!isnull objectParent _x) then {
                        doGetOut _x;
                        sleep 3;
                    };
                    _x doMove (getPos player);
                } else {doStop _x};
            };

            // Blood trail
            if (damage _x > 0.6 && vehicle _x == _x) then {
                private _spray = createVehicle ["BloodSpray_01_New_F", getPos _x, [], 0, "CAN_COLLIDE"];
                _spray spawn {sleep (10 + floor(random 5)); deleteVehicle _this};
            };

            // AI level UP
            private _ai_score = _x getVariable ["PAR_AI_score", nil];
            private _ai_skill = skill _x;
            if (!isNil "_ai_score") then {
                if (_ai_score <= 0 && _ai_skill < 0.85) then {
                    private _ai_rank = GRLIB_rank_level select (GRLIB_rank_level find (rank _x)) + 1;
                    _x setSkill (_ai_skill + 0.05);
                    _x setUnitRank _ai_rank;
                    _msg = format ["%1 was promoted to the rank of %2 !", name _x, _ai_rank];
                    [_x, _msg] call PAR_fn_globalchat;
                    _x setVariable ["PAR_AI_score", ((GRLIB_rank_level find (rank _x)) + 1) * 5, true];
                };
            };
            sleep 0.3;
        } forEach PAR_AI_bros;
    };
    sleep 5;
};
