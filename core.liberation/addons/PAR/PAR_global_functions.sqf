PAR_fn_Killed = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_Killed.sqf";
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
PAR_fn_globalchat = {
  params ["_speaker", "_msg"];
  if (isDedicated) exitWith {};
  if (!(local _speaker)) exitWith {};
  if ((_speaker getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1",PAR_Grp_ID] || isPlayer _speaker) then {
    gamelogic globalChat _msg;
  };
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

	if ( PAR_AidKit in (items _unit) || PAR_Medikit in (items _unit) ) then {
		_ret = true;
	};
	_ret
};
PAR_public_EH = {
	params ["_EH", "_target"];
	private _killed = _target select 0;
	private _killer = _target select 1;

	// PAR_deathMessage
	if (_EH == "PAR_deathMessage") then {
		if (isPlayer _killed) then {
			if (isNull _killer) then {
				gamelogic globalChat (format ["%1 was injured for an unknown reason", name _killed]);
			} else {
				gamelogic globalChat (format ["%1 was injured by %2", name _killed, name _killer]);
			};
		};
	};

	// PAR_tkMessage
	if (_EH == "PAR_tkMessage") then {
		if (isPlayer _killer && isPlayer _killed ) then {
			gamelogic globalChat (format ["%1 has committed TK on %2",name _killer, name _killed]);
		};
	};
};
PAR_unit_eject = {
	params ["_veh", "_unit"];
	if (isNull _unit || !alive _unit) exitWith {};
	unAssignVehicle _unit;
	_unit allowDamage false;
	moveOut _unit;
	_unit setPos (getPosATL _veh vectorAdd [([[-15,0,15], 2] call F_getRND), ([[-15,0,15], 2] call F_getRND), 0]);
	if (round(getPosATL _unit select 2) > 20) then {
		_para = createVehicle ['Steerable_Parachute_F', (getPosATL _unit),[],0,'none'];
		_unit moveInDriver _para;
		sleep 1;
		if (isnull driver (_para)) then {deleteVehicle _para};
	};
	sleep 3;
	_unit allowDamage true;
};
PAR_show_marker = {
	_mk1 = createMarker [format ["PAR_marker_%1", name player], position player];
	_mk1 setMarkerType "loc_Hospital"; 
	_mk1 setMarkerColor "ColorRed"; 
	_mk1 setMarkerText format ["%1 Injured", name player];
};
PAR_del_marker = {
	deletemarker format ["PAR_marker_%1", name player];
};

// AI Section
PAR_fn_AI_Damage_EH = {
	params ["_unit"];
	_unit removeAllEventHandlers "HandleDamage";
	_unit addEventHandler ["HandleDamage", { _this call damage_manager_EH }];

	if (GRLIB_revive != 0) then {
		_unit addEventHandler ["HandleDamage", {
			params ["_unit","","_dam"];
			_veh = objectParent _unit;
			if (!(isNull _veh) && damage _veh > 0.8) then {[_veh, _unit, true] spawn PAR_fn_eject};

			private _isNotWounded = !(_unit getVariable ["PAR_wounded", false]);
			if (_isNotWounded && _dam >= 0.86) then {
				if (!(isNull _veh)) then {[_veh, _unit] spawn PAR_fn_eject};
				_unit allowDamage false;
				_unit setVariable ["PAR_wounded", true];
				_unit setUnconscious true;
				_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_BleedOut), true];
				[_unit] spawn PAR_fn_unconscious;
			};
			_dam min 0.86;
		}];
	};
	_unit removeAllEventHandlers "Killed";
	_unit addEventHandler ["Killed", {_this spawn PAR_fn_Killed}];
	_unit removeAllMPEventHandlers "MPKilled";
	_unit addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_unit setVariable ["PAR_wounded", false];
	_unit setVariable ["PAR_myMedic", nil];
	_unit setVariable ["PAR_busy", nil];
	_unit setVariable ["PAR_heal", nil];
	_unit setVariable ["PAR_healed", nil];
	_unit setVariable ["PAR_AI_score", 5, true];
	[_unit] spawn player_EVH;
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
      } forEach _bros;
    };
    sleep 5;
  };
};

// Player Section
PAR_Player_Init = {
	// Clear event handler before adding it
	player removeAllEventHandlers "HandleDamage";
	player addEventHandler ["HandleDamage", { _this call damage_manager_EH }];
	if (GRLIB_revive != 0) then {
		player addEventHandler ["HandleDamage", { _this call PAR_HandleDamage_EH }];
	};
	player removeAllMPEventHandlers "MPKilled";
	player addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	player setVariable ["GREUH_isUnconscious", 0, true];
	player setVariable ["PAR_isUnconscious", 0, true];
	player setVariable ["PAR_wounded", false];
	player setVariable ["PAR_isDragged", 0, true];
	player setVariable ["ace_sys_wounds_uncon", false];
	player setVariable ["PAR_Grp_ID",format["Bros_%1", PAR_Grp_ID], true];
	player setVariable ["PAR_myMedic", nil];
	player setVariable ["PAR_busy", nil];
	if (!GRLIB_fatigue ) then { player enableStamina false };
	if (GRLIB_opfor_english) then {player setSpeaker "Male01ENG"};
	player setCustomAimCoef 0.35;
	player setUnitRecoilCoefficient 0.6;
	player setCaptive false;
	player setMass 10;
	PAR_isDragging = false;
	[player] spawn player_EVH;
	[player] call AR_Add_Player_Actions;
	1 fadeSound 1;
	1 fadeRadio 1;
	NRE_EarplugsActive = 0;
	hintSilent "";
};

PAR_HandleDamage_EH = {
	params ["_unit", "_selectionName", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];
	if (isNull _unit) exitWith {0};
	if (!(isNull _instigator)) then {
		_killer = _instigator;
	} else {
		if (!(_killer isKindOf "CAManBase")) then {
			_killer = effectiveCommander _killer;
		};
	};

	_veh = objectParent _unit;
	if (!(isNull _veh) && damage _veh > 0.8) then {[_veh, _unit, true] spawn PAR_fn_eject};

	private _isNotWounded = !(_unit getVariable ["PAR_wounded", false]);

	if (GRLIB_tk_mode != 2) then {
		// TK Protect
		private _veh_unit = vehicle _unit;
		private _veh_killer = vehicle _killer;
		if ( _isNotWounded && isPlayer _killer && _killer != _unit && _veh_unit != _veh_killer && LRX_tk_vip find (name _killer) == -1) then {
			if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
				["PAR_tkMessage", [_unit, _killer]] remoteExec ["PAR_public_EH", 0];
				[_unit, _killer] remoteExec ["LRX_tk_check", 0];
				_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
			};
			_amountOfDamage = 0.15;
		};
	};

	if ( _isNotWounded && _amountOfDamage >= 0.86) then {
		_unit setVariable ["PAR_wounded", true];
		_unit setVariable ["PAR_isUnconscious", 1, true];
		_unit setCaptive true;
		_unit allowDamage false;
		_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_BleedOut), true];
		[_unit, _killer] spawn PAR_Player_Unconscious;
		closedialog 0;
	};

	_amountOfDamage min 0.86;
};

PAR_Player_Unconscious = {
	params [ "_unit", "_killer" ];

	// Death message
	if (PAR_EnableDeathMessages && !isNil "_killer" && _killer != _unit) then {
		["PAR_deathMessage", [_unit, _killer]] remoteExec ["PAR_public_EH", 0];
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
