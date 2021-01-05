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

PAR_fn_AI_Damage_EH = {
  params ["_unit"];
  _unit addEventHandler ["HandleDamage", damage_manager_EH ];
  _unit addEventHandler ["HandleDamage", {
      params ["_unit","","_dam"];
      _veh = objectParent _unit;
      if (!(isNull _veh) && round(damage _veh) > 0.8) then {[_veh, _unit, true] spawn PAR_fn_eject};

      if (!(_unit getVariable ["PAR_wounded",false]) && (_dam >= 0.86)) then {
        if (!(isNull _veh)) then {[_veh, _unit] spawn PAR_fn_eject};
        _unit allowDamage false;
        _unit setVariable ["PAR_wounded", true];
        _unit setUnconscious true;
        _unit setVariable ["PAR_BleedOutTimer", round(time + PAR_BleedOut), true];
        [_unit] spawn PAR_fn_unconscious;
      };
      _dam min 0.86;
  }];
  _unit removeAllMPEventHandlers "MPKilled";
  _unit addMPEventHandler ["MPKilled", {_this spawn PAR_Player_MPKilled}];
  _unit setVariable ["PAR_wounded",false];
  _unit setVariable ["PAR_myMedic", nil];
  _unit setVariable ["PAR_busy", nil];
  _unit setVariable ["PAR_heal", nil];
  _unit setVariable ["PAR_healed", nil];
};

PAR_AI_Manager = {
  while {true} do {
    private _bros = (units player) select {!isplayer _x && (_x getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1",PAR_Grp_ID]};
    if (count _bros > 0 ) then {
      {
        // Set EH
        if (isNil {_x getVariable "passEH"}) then {
          _x setVariable ["passEH", true];
          _x call PAR_fn_AI_Damage_EH;
        };

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

        // Blood trail
        if (damage _x > 0.6 && vehicle _x == _x) then {
          private _spray = createVehicle ["BloodSpray_01_New_F", getPos _x, [], 0, "CAN_COLLIDE"];
          [_spray] spawn {sleep (7 + random 5); deleteVehicle (_this select 0)};
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

PAR_Player_Init = {
	// Clear event handler before adding it
	player removeAllEventHandlers "HandleDamage";
	player addEventHandler ["HandleDamage", PAR_HandleDamage_EH];
	player removeAllMPEventHandlers "MPKilled";
	player addMPEventHandler ["MPKilled", {_this spawn PAR_Player_MPKilled}];
	player setVariable ["GREUH_isUnconscious", 0, true];
	player setVariable ["PAR_isUnconscious", 0, true];
	player setVariable ["PAR_isDragged", 0, true];
	player setVariable ["ace_sys_wounds_uncon", false];
	player setVariable ["PAR_Grp_ID",format["Bros_%1", PAR_Grp_ID], true];
	player setVariable ["PAR_myMedic", nil];
	player setVariable ["PAR_busy", nil];
	player setVariable ["AirCoolDown", 0, true];
	if (!GRLIB_fatigue ) then { player enableStamina false };
	player setCustomAimCoef 0.35;
	player setUnitRecoilCoefficient 0.6;
	player setCaptive false;
	player setMass 10;
	PAR_isDragging = false;
	[player] spawn player_EVH;
};

PAR_is_medic = {
	params ["_unit"];
	private _ret = false;

	if ( getNumber (configfile >> "CfgVehicles" >> typeOf _unit >> "attendant") == 1 ) then {
		_ret = true;
	};
	_ret
};

PAR_has_medikit = {
	params ["_unit"];
	private _ret = false;

	if ( (PAR_Medikit in (vest _unit)) || (PAR_Medikit in (items _unit)) || (PAR_Medikit in (backpackItems _unit)) ) then {
		_ret = true;
	};
	_ret
};

PAR_HandleDamage_EH = {
	params [ "_unit", "_selectionName", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex" ];

	private _veh_unit = vehicle _unit;
	private _veh_killer = vehicle _killer;
	private _max_damage = 0.86;

	// TK Protect
	private _isProtected = _unit getVariable ["PAR_isProtected", 0];
	private _isUnconscious = _unit getVariable ["PAR_isUnconscious", 0];

	if (_isProtected == 0 && _isUnconscious == 0 && isPlayer _killer && _killer != _unit && _veh_unit != _veh_killer && BTC_vip find (name _killer) == -1) then {
		_unit setVariable ["PAR_isProtected", 1, true];
		PAR_tkMessage = [_unit, _killer];
		publicVariable "PAR_tkMessage";
		["PAR_tkMessage", [_unit, _killer]] call PAR_public_EH;
		BTC_tk_PVEH = [name _killer];
		publicVariable "BTC_tk_PVEH";
		[_unit] spawn { sleep 3;(_this select 0) setVariable ["PAR_isProtected", 0, true] };
		_isProtected = 1;
	};

	if (_isProtected == 1) then {
		_max_damage = 0;
	};

	private _isUnconscious = _unit getVariable ["PAR_isUnconscious", 0];
	if (_isProtected == 0 && _isUnconscious == 0 && (_amountOfDamage >= 0.86)) then {
		closedialog 0;
		_unit setVariable ["PAR_isUnconscious", 1, true];
		_unit setCaptive true;
		_unit allowDamage false;
		_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_BleedOut), true];
		[_unit, _killer] spawn PAR_Player_Unconscious;
	};

	_amountOfDamage min _max_damage;
};

PAR_Player_Unconscious = {
	params [ "_unit", "_killer" ];

	// Death message
	if (PAR_EnableDeathMessages && !isNil "_killer" && _killer != _unit) then
	{
		PAR_deathMessage = [_unit, _killer];
		publicVariable "PAR_deathMessage";
		["PAR_deathMessage", [_unit, _killer]] call PAR_public_EH;
	};

	// Eject unit if inside vehicle
	private _veh_unit = vehicle _unit;
	if (_veh_unit != _unit) then {[_veh_unit, _unit] spawn PAR_fn_eject};

	[] call R3F_LOG_FNCT_objet_relacher;

	_random_medic_message = floor (random 3);
	_medic_message = "";
	switch (_random_medic_message) do {
		case 0 : { _medic_message = localize "STR_PAR_Need_Medic1"; };
		case 1 : { _medic_message = localize "STR_PAR_Need_Medic2"; };
		case 2 : { _medic_message = localize "STR_PAR_Need_Medic3"; };
	};
	[_medic_message] remoteExec ["sidechat", -2];

	disableUserInput false;
	disableUserInput true;
	disableUserInput false;

	// PAR AI Revive Call
	_unit setVariable ["GREUH_isUnconscious", 1, true];
	_unit setUnconscious true;
	_unit setVariable ["PAR_wounded", true];

	// Mute Radio
	5 fadeRadio 0;

	// Dog barf
	_my_dog = player getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", player] };

	_unit switchMove "";
	[_unit] spawn PAR_fn_unconscious;

	while { !isNull _unit && alive _unit && _unit getVariable ["PAR_isUnconscious", 0] == 1 } do {
		_bleedOut = player getVariable ["PAR_BleedOutTimer", 0];
		hintSilent format[localize "STR_BLEEDOUT_MESSAGE" + "\n", round (_bleedOut - time)];
		public_bleedout_message = format [localize "STR_BLEEDOUT_MESSAGE", round (_bleedOut - time)];
		public_bleedout_timer = round (_bleedOut - time);
		sleep 0.5;
	};

	if (alive _unit && _unit getVariable ["PAR_isUnconscious", 0] == 0) then {
		// Player got revived
		_unit playMove "amovppnemstpsraswrfldnon";
		_unit playMove "";

		// Clear the "medic nearby" hint
		hintSilent "";

		// Unmute Radio
		5 fadeRadio 1;

		// Unmute ACRE
		if (isPlayer _unit) then {
			_unit setVariable ["ace_sys_wounds_uncon", false];
		};

		// Dog stop
		if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", nil] };
	};
};

PAR_public_EH = {
  private ["_timeout", "_action", "_msg"];
	if(count _this < 2) exitWith {};

	_EH  = _this select 0;
	_target = _this select 1;

	// PAR_deathMessage
	if (_EH == "PAR_deathMessage") then
	{
		_killed = _target select 0;
		_killer = _target select 1;
		if (isPlayer _killed) then
		{
			if (isNull _killer) then {
				gamelogic globalChat (format ["%1 was injured for an unknown reason", name _killed] );
			} else {
				gamelogic globalChat (format ["%1 was injured by %2", name _killed, name _killer] );
			}
		};
	};

	// PAR_tkMessage
	if (_EH == "PAR_tkMessage") then
	{
		_killed = _target select 0;
		_killer = _target select 1;

		if (isPlayer _killer && isPlayer _killed ) then
		{
			gamelogic globalChat (format ["%1 has committed TK on %2",name _killer, name _killed]);
		};
	};
};
