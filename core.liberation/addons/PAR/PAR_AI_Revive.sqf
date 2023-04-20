/*
     pSiKO AI Revive - v2.04 - SP/MP - AI

Author:

	[AKH] pSiKO

Description:

	give ablitty to ai to revive player or other ai
  unit sharing the same PAR_Grp_ID revive each others

Instructions:

	ExecVM from initclient.sqf or init.sqf in your mission directory.

Based on: AI REVIVE HEAL SCRIPT SP/MP by Pierre MGI

  at : https://forums.bohemia.net/forums/topic/207522-ai-revive-heal-script-spmp/

_________________________________________________________________________*/

if (isDedicated) exitWith {};
// Seconds until unconscious unit bleeds out and dies.
if (isNil "PAR_BleedOut") then {PAR_BleedOut = 300};
// Extra time when Revive
if (isNil "PAR_BleedOutExtra") then {PAR_BleedOutExtra = 60};

PAR_fn_medic = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_medic.sqf";
PAR_fn_medicRelease = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_medicRelease.sqf";
PAR_fn_medicRecall = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_medicRecall.sqf";
PAR_fn_checkMedic = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_checkMedic.sqf";
PAR_fn_911 = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_911.sqf";
PAR_fn_sortie = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_sortie.sqf";
PAR_fn_death = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_death.sqf";
PAR_fn_unconscious = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_unconscious.sqf";
PAR_fn_eject = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_eject.sqf";
PAR_fn_checkWounded = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_checkWounded.sqf";

PAR_fn_EHDamage = {
  params ["_unit"];
  _unit addEventHandler ["handleDamage", {
      params ["_unit","","_dam"];
      _veh = objectParent _unit;
      if (!(isNull _veh) && round(damage _veh) > 0.8) then {[_veh, _unit] spawn PAR_fn_eject};

      if (!(_unit getVariable ["PAR_isUnconscious",false]) && (_dam >= 0.86)) then {
        if (!(isNull _veh)) then {[_veh, _unit] spawn PAR_fn_eject};
        _unit allowDamage false;
        _unit setVariable ["PAR_isUnconscious", true];
        _unit setUnconscious true;
        _unit setVariable ["PAR_BleedOutTimer", round(time + PAR_BleedOut), true];
        [_unit] spawn PAR_fn_unconscious;
      };
      _dam min 0.86;
  }];
  _unit removeAllMPEventHandlers "MPKilled";
  _unit addMPEventHandler ["MPKilled", FAR_Player_MPKilled];
  _unit setVariable ["PAR_soliders",true,true];
  _unit setVariable ["PAR_isUnconscious",false];
  _unit setVariable ["PAR_myMedic", nil];
  _unit setVariable ["PAR_busy", nil];
  _unit setVariable ["PAR_heal", nil];
  _unit setVariable ["PAR_healed", nil];
};

PAR_fn_Revive = {
  while {true} do {
    private _bros = (units player) select {!isplayer _x && (_x getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1",PAR_Grp_ID]};
    if (count _bros > 0 ) then {
      {
        // Set EH
        if (isNil {_x getVariable "passEH"}) then {
          _x setVariable ["passEH", true];
          _x call PAR_fn_EHDamage;
        };

        // Medic can heal
        _isMedic = [_x] call FAR_is_medic;
        _hasMedikit = [_x] call FAR_has_medikit;
        if ( _isMedic && _hasMedikit &&
            vehicle _x == _x &&
            (behaviour _x) != "COMBAT" &&
            lifeState _x != 'incapacitated' &&
            isNil {_x getVariable 'PAR_busy'} &&
            isNil {_x getVariable 'PAR_heal'}
            ) then {
               [_x] spawn PAR_fn_checkWounded;
        };

        // AI stop doing shit !
        if ( leader group player != player &&
              lifeState player == 'incapacitated' &&
              _x distance2D player <= 500 &&
              isNil {_x getVariable 'PAR_busy'} &&
              isNil {_x getVariable 'PAR_heal'}
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

        sleep 0.3;
      } forEach _bros;
    };
    sleep 5;
  };
};

PAR_fn_globalchat = {
  params ["_speaker", "_msg"];
  if (!(local _speaker)) exitWith {};
  if ((_speaker getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1",PAR_Grp_ID] || isPlayer _speaker) then {
    gamelogic globalChat _msg;
  };
};

waituntil {!isNull player && GRLIB_player_spawned};
waituntil {!isNil {player getVariable ["GRLIB_Rank", nil]}};

[] spawn PAR_fn_Revive;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- PAR Revive Initialized --------";
