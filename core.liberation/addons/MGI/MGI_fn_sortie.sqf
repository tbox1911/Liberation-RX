params ['_wnded','_medic','_timer'];
//diag_log format ["DBG_fn_sortie WNDED:%1 MEDIC:%2 TIMER:%3", name _wnded, name _medic,_timer];
if (_wnded == _medic) exitWith {};
if (lifeState _wnded == 'incapacitated' && diag_tickTime < _timer + MGI_BleedOut) then {

if (!isPlayer _medic) then {
    gamelogic globalChat format["%1, %2 is healing you now...", name _wnded, name _medic];
    _medic setDir (_medic getDir _wnded);
    //_medic removeitem 'FirstAidKit';
    if (stance _medic == 'PRONE') then {
      _medic playMove 'ainvppnemstpslaywrfldnon_medicother';
    } else {
      _medic playMove 'ainvpknlmstpslaywrfldnon_medicother';
    };
    sleep 6;
  };

  if (lifeState _medic != 'incapacitated' && alive _medic) then {
    _wnded setUnconscious false;
    _wnded allowFleeing 0;
    _wnded doFollow player;
    _isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf _medic >> "attendant");
    if (_isMedic == 1 && "Medikit" in backpackItems _medic) then {
			_wnded setDamage 0;
		} else {
			_wnded setDamage 0.25;
		};
    _wnded selectWeapon primaryWeapon _wnded;
    sleep 0.5;
    if (isPlayer _wnded) then {
      player setVariable ['FAR_isUnconscious',0,true];
      group _wnded selectLeader player;
    } else {
      {
        if (["Heal Bros",(_wnded actionParams _x) select 0] call bis_fnc_inString) then {
          [ _wnded,_x] call BIS_fnc_holdActionRemove;
        };
      } count (actionIDs _wnded);
      _wnded playMoveNow "amovpknlmstpsraswrfldnon";
      _wnded setSpeedMode (speedMode group player);
    };
    [_wnded] spawn {
        params ["_unit"];
        uIsleep 10;   //time to recover
        _unit setCaptive false;
        _unit setVariable ["MGI_isUnconscious",false];
        _unit allowDamage true;
    };
    if (round (getPosASL _wnded select 2) <= -1) then {_wnded switchmove ""};
    if (round (getPosASL _medic select 2) <= -1) then {_medic switchmove ""};
  };
};
sleep 2;
_medic call MGI_fn_medicRelease;
_wnded setVariable ['MGI_myMedic', nil];

if (lifeState _wnded == 'incapacitated' && diag_tickTime > _timer + MGI_BleedOut) then {
  _wnded call MGI_fn_death;
};
