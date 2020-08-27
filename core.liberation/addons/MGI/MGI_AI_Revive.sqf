//original at : https://forums.bohemia.net/forums/topic/207522-ai-revive-heal-script-spmp/
//heavily modified by pSiKO
if (isDedicated) exitWith {};

MGI_fn_medic = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_medic.sqf";
MGI_fn_medicRelease = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_medicRelease.sqf";
MGI_fn_medicRecall = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_medicRecall.sqf";
MGI_fn_checkMedic = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_checkMedic.sqf";
MGI_fn_911 = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_911.sqf";
MGI_fn_sortie = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_sortie.sqf";
MGI_fn_death = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_death.sqf";
MGI_fn_unconscious = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_unconscious.sqf";
MGI_fn_eject = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_eject.sqf";
MGI_fn_checkWounded = compileFinal preprocessFileLineNumbers "addons\MGI\MGI_fn_checkWounded.sqf";

MGI_fn_EHDamage = {
  params ["_unit"];
  _unit addEventHandler ["handleDamage", {
      params ["_unit","","_dam"];
      _veh = objectParent _unit;
      if (!(isNull _veh) && round(damage _veh) > 0.8) then {[_veh, _unit] spawn MGI_fn_eject};

      if (!(_unit getVariable ["MGI_isUnconscious",false]) && (_dam >= 0.86)) then {
        if (!(isNull _veh)) then {[_veh, _unit] spawn MGI_fn_eject};
        _unit allowDamage false;
        _unit setVariable ["MGI_isUnconscious", true];
        _unit setUnconscious true;
        [_unit] spawn MGI_fn_unconscious;
      };
      _dam min 0.86;
  }];
  _unit removeAllMPEventHandlers "MPKilled";
  _unit addMPEventHandler ["MPKilled", FAR_Player_MPKilled];
  _unit setVariable ["MGI_soliders",true,true];
  _unit setVariable ["MGI_isUnconscious",false];
  _unit setVariable ["MGI_myMedic", nil];
  _unit setVariable ["MGI_busy", nil];
  _unit setVariable ["MGI_heal", nil];
  _unit setVariable ["MGI_healed", nil];
};

MGI_fn_Revive = {
  MGI_BleedOut = 300;

    while {true} do {
    private _bros = allUnits select {(_x getVariable ["MGI_Grp_ID","0"]) == (player getVariable ["MGI_Grp_ID","1"])};
    if (count _bros > 1 ) then {
      {
        // Only for AI
        if (!isplayer _x) then {
          // AI rejoin
          if ( !(_x in units group player) && isNil {_x getVariable 'MGI_busy'} && lifeState _x != 'incapacitated' ) then {
            if ( count (units group player) < (GRLIB_squad_size + GRLIB_squad_size_bonus) ) then { [_x] joinSilent my_group };
          };

          // Set EH
          if (isnil {_x getVariable "passEH"}) then {
            _x setVariable ["passEH", true];
            _x call MGI_fn_EHDamage;
          };

          // Medic can heal
          _isMedic = [_x] call FAR_is_medic;
          _hasMedikit = [_x] call FAR_has_medikit;
          if ( _isMedic && _hasMedikit &&
              vehicle _x == _x &&
              (behaviour _x) != "COMBAT" &&
              lifeState _x != 'incapacitated' &&
              isNil {_x getVariable 'MGI_busy'} &&
              isNil {_x getVariable 'MGI_heal'}
             ) then { [_x] spawn MGI_fn_checkWounded };

          // AI stop doing shit !
          if ( leader group player != player &&
               lifeState player == 'incapacitated' &&
               _x distance2D player <= 500 &&
               isNil {_x getVariable 'MGI_busy'} &&
               isNil {_x getVariable 'MGI_heal'}
              ) then {
                doStop _x;
                unassignVehicle _x;
                [_x] orderGetIn false;
                if (!isnull objectParent _x) then {
                  doGetOut _x;
                  sleep 3;
                };
                _x doMove (getPos player);
          };
        };
        sleep 0.1;
      } forEach _bros;
    };
    sleep 5;
  };

};

MGI_fn_globalchat = {
  params ["_speaker", "_msg"];
  if ((_speaker getVariable ["MGI_Grp_ID","0"]) == (player getVariable ["MGI_Grp_ID","1"])) then {
    gamelogic globalChat _msg;
  };
};
waituntil {!isNull player && GRLIB_player_spawned};
waituntil {!isNil {player getVariable ["GRLIB_Rank", nil]}};

[] spawn MGI_fn_Revive;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- AI Revive Initialized --------";

/*
react = 20;
bleedOut = 300;
ReviveForAI = true;
bros = "";
*/
