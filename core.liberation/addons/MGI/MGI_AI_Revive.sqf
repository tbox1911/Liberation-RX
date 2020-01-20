//original at : https://forums.bohemia.net/forums/topic/207522-ai-revive-heal-script-spmp/
//heavily modified by pSiKO

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

if (isDedicated) exitWith {};

waituntil {!isNull player && GRLIB_player_spawned};
waituntil {!isNil {player getVariable ["GRLIB_Rank", nil]}};

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
  _unit setVariable ["MGI_isUnconscious",false];
  _unit setVariable ["MGI_myMedic", nil];
  _unit setVariable ["MGI_busy", nil];
  _unit setVariable ["MGI_heal", nil];
  _unit setVariable ["MGI_healed", nil];
  _unit setVariable [format["Bros_%1",MGI_Grp_ID], true];
};

MGI_fn_Revive = {
  params ["_react", "_bleedOut","_AiRevive"];
  MGI_react = _react;
  MGI_BleedOut = _bleedOut;
  MGI_AiRevive = _AiRevive;

    while {true} do {
      MGI_bros = allUnits select {(_x getVariable [format["Bros_%1",MGI_Grp_ID],nil])};
      {
        if (!isplayer _x) then {
          if (isnil {_x getVariable "passEH"}) then {
            _x setVariable ["passEH", true];
            _x call MGI_fn_EHDamage;
          };

          _isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf _x >> "attendant");
          if ( _isMedic == 1 &&
               vehicle _x == _x &&
               (behaviour _x) != "COMBAT" &&
               lifeState _x != 'incapacitated' &&
               isNil {_x getVariable 'MGI_busy'} &&
               isNil {_x getVariable 'MGI_heal'}
          ) then { [_x] spawn MGI_fn_checkWounded };

          if (group player != group _x &&
              isNil {_x getVariable 'MGI_busy'} &&
              (count (units group player) < GRLIB_max_squad_size+GRLIB_squad_size_bonus)
          ) then { [ _x ] joinSilent group player };
        };
        sleep 0.5;
      } forEach MGI_bros;
      sleep 10;
    };
};

[20,300,true] spawn MGI_fn_Revive;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- AI Revive Initialized --------";

/*
react = 20;
bleedOut = 300;
ReviveForAI = true;
bros = "";
*/
