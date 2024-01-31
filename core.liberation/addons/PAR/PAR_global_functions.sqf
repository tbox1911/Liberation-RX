// PAR Remote Call - Server Side
//PAR_remote_bounty = compileFinal preprocessFileLineNumbers "addons\PAR\server\PAR_remote_bounty.sqf";
//PAR_remote_sortie = compileFinal preprocessFileLineNumbers "addons\PAR\server\PAR_remote_sortie.sqf";

// PAR Global Functions - Client side
PAR_EventHandler = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_EventHandler.sqf";
PAR_AI_Manager = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_AI_Manager.sqf";
PAR_ActionManager = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_ActionManager.sqf";
PAR_fn_nearestMedic = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_nearestMedic.sqf";
PAR_fn_medic = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_medic.sqf";
PAR_fn_medicRelease = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_medicRelease.sqf";
PAR_fn_medicRecall = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_medicRecall.sqf";
PAR_fn_checkMedic = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_checkMedic.sqf";
PAR_fn_911 = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_911.sqf";
PAR_fn_sortie = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_sortie.sqf";
PAR_fn_death = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_death.sqf";
PAR_fn_unconscious = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_unconscious.sqf";
PAR_fn_eject = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_eject.sqf";
PAR_fn_heal = compileFinal preprocessFileLineNumbers "addons\PAR\PAR_fn_heal.sqf";

PAR_medic_units = {
	params ["_medic"];
	(units player + units GRLIB_side_civilian) select { !isPlayer _x && alive _x && lifeState _x != "INCAPACITATED" && (_x getVariable ["PAR_Grp_ID","0"]) == (_medic getVariable ["PAR_Grp_ID","1"])};
};
PAR_unblock_AI = {
	// Unblock unit(s) 0-8-1
	params ["_unit_array"];
	if (player getVariable ["SOG_player_in_tunnel", false]) exitWith {};
	if ( isNull (objectParent player) && count _unit_array == 0 ) then {
		if (surfaceIsWater (getPos player)) then {
			[[player]] spawn PAR_fn_fixPos;
		} else {
			player setPosATL (getPosATL player vectorAdd [([] call F_getRND), ([] call F_getRND), 0.5]);
		};
	} else {
		{
			_unit = _x;
			if (isNull (objectParent _unit) && (player distance2D _unit) < 50 && (lifeState _unit != 'INCAPACITATED')) then {
				_unit stop true;
				sleep 1;
				_unit doWatch objNull;
				_unit switchmove "";
				_unit disableAI "ALL";
				private _grp = createGroup [GRLIB_side_friendly, true];
				[_unit] joinSilent _grp;
				unAssignVehicle _unit;
				[_unit] orderGetIn false;
				[_unit] allowGetIn false;
				sleep 1;
				if (surfaceIsWater (getPos _unit)) then {
					[[_unit]] spawn PAR_fn_fixPos;
				} else {
					_unit setPosATL (getPosATL player vectorAdd [([] call F_getRND), ([] call F_getRND), 0.5]);
				};
				[_unit] joinSilent (group player);
				_unit stop false;
				_unit enableAI "ALL";
				_unit doFollow player;
				_unit switchMove "AmovPercMwlkSrasWrflDf";
				_unit playMoveNow "AmovPercMwlkSrasWrflDf";
			} else {
				hintSilent "Unit is in a vehicle or is unconscious,\n or is too far. (max 50m)";
			};
		} forEach _unit_array;
	};
};
PAR_abandon_priso = {
	// Abandon selected prisoners 0-8-2
	params ["_unit_array"];
	if (player getVariable ["SOG_player_in_tunnel", false]) exitWith {};
	if ( count _unit_array > 0 ) then {
		{
			_unit = _x;
			if (!isNil {_unit getVariable "GRLIB_is_prisoner"}) then {
				if (isNull (objectParent _unit) && (player distance2D _unit) < 50) then {
					private _grp = createGroup [GRLIB_side_enemy, true];
					[_unit] joinSilent _grp;
					_unit stop true;
					_unit switchMove "";
					_unit setUnitPos "UP";
					sleep 1;
					_unit disableAI "ANIM";
					_unit disableAI "MOVE";
					_anim = "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
					[_unit, _anim] remoteExec ["switchMove", 0];
					[_unit, _anim] remoteExec ["playMoveNow", 0];
					_unit setVariable ["GRLIB_is_prisoner", true, true];
				} else {
					hintSilent "Prisoner is in a vehicle or is too far. (max 50m)";
				};
			};
		} forEach _unit_array;
	};
};
PAR_fn_globalchat = {
  params ["_speaker", "_msg"];
  if (isDedicated) exitWith {};
  if (!(local _speaker)) exitWith {};
  if ((_speaker getVariable ["PAR_Grp_ID","0"]) == format["Bros_%1",PAR_Grp_ID] || isPlayer _speaker) then {
    gamelogic globalChat _msg;
  };
};
PAR_fn_fixPos = {
	params ["_list"];
	{
		private _pos = getPosATL _x;
		if (local _x && surfaceIsWater _pos) then {
			_pos = getPosASL _x;
			_zpos = _pos select 2;
			if (_zpos < -3) then {
				_pos set [2, -1 max _zpos];
				_x setPosASL _pos;
				_x switchMove "";
				_x playMoveNow "";
			};
		};
	} forEach _list;
};
PAR_is_medic = {
	params ["_unit"];
	(getNumber (configOf _unit >> "attendant") == 1);
};
PAR_has_medikit = {
	params ["_unit"];
	(PAR_AidKit in (items _unit) || PAR_Medikit in (items _unit));
};
PAR_public_EH = {
	params ["_EH", "_target"];
	private _killed = _target select 0;
	private _killer = _target select 1;

	// PAR_deathMessage
	if (_EH == "PAR_deathMessage") then {
		if (isPlayer _killed) then {
			if (isNull _killer) then {
				gamelogic globalChat format ["%1 was injured for an unknown reason", name _killed];
			} else {
				gamelogic globalChat format ["%1 was injured by %2", name _killed, name _killer];
			};
		};
	};

	// PAR_tkMessage
	if (_EH == "PAR_tkMessage") then {
		if (isPlayer _killer && isPlayer _killed ) then {
			gamelogic globalChat format ["%1 has committed TK on %2",name _killer, name _killed];
		};
	};
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
	if (_unit getVariable ["PAR_EH_Installed", false]) exitWith {};
	_unit setVariable ["PAR_EH_Installed", true];
	[_unit] call PAR_EventHandler;
	_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	_unit setVariable ["PAR_wounded", false, true];
	_unit setVariable ["PAR_isUnconscious", false, true];
	_unit setVariable ["PAR_isDragged", 0, true];
	_unit setVariable ["PAR_myMedic", nil];
	_unit setVariable ["PAR_busy", nil];
	_unit setVariable ["PAR_heal", nil];
	_unit setVariable ["PAR_healed", nil];
	_unit setVariable ["PAR_AI_score", ((GRLIB_rank_level find (rank _unit)) + 1) * 5, true];
};

// Player Section
PAR_Player_Init = {
	player addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	player setVariable ["PAR_wounded", false, true];
	player setVariable ["PAR_isUnconscious", false, true];
	player setVariable ["PAR_isDragged", 0, true];
	player setVariable ["ace_sys_wounds_uncon", false];
	player setVariable ["PAR_Grp_ID",format["Bros_%1", PAR_Grp_ID], true];
	player setVariable ["PAR_myMedic", nil];
	player setVariable ["PAR_busy", nil];
	player setVariable ["PAR_heal", nil];
	player setVariable ["PAR_healed", nil];
	if (!GRLIB_fatigue) then { player enableFatigue false; player enableStamina false };
	if (GRLIB_opfor_english) then {player setSpeaker "Male01ENG"};
	player setCustomAimCoef 0.35;
	player setUnitRecoilCoefficient 0.6;
	player setCaptive false;

	PAR_isDragging = false;
	[player] call AR_Add_Player_Actions;
	[player] call add_player_actions;
	1 fadeSound 1;
	1 fadeRadio 1;
	NRE_EarplugsActive = 0;
	hintSilent "";
	showMap true;
};

PAR_HandleDamage_EH = {
	params ["_unit", "_selectionName", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex", "_instigator"];
	if (isNull _unit) exitWith {0};
	if (!isNull _instigator) then {
		if (isNull (getAssignedCuratorLogic _instigator)) then {
	    	_killer = _instigator;
		};
	} else {
		if (!(_killer isKindOf "CAManBase")) then {
			_killer = effectiveCommander _killer;
		};
	};

	private _isNotWounded = !(_unit getVariable ["PAR_wounded", false]);
	private _veh_unit = objectParent _unit;

	if (GRLIB_tk_mode > 0) then {
		// TK Protect
		private _veh_killer = vehicle _killer;
		if (_isNotWounded && isPlayer _killer && _killer != _unit && _veh_killer != _veh_unit && _amountOfDamage > 0.15) then {
			if ( _unit getVariable ["GRLIB_isProtected", 0] < time ) then {
				["PAR_tkMessage", [_unit, _killer]] remoteExec ["PAR_public_EH", 0];
				[_unit, _killer] remoteExec ["LRX_tk_check", 0];
				_unit setVariable ["GRLIB_isProtected", round(time + 3), true];
			};
			_amountOfDamage = 0;
		};
	};

	if ( _isNotWounded && _amountOfDamage >= 0.86) then {
		if (!(isNull _veh_unit)) then {[_unit, _veh_unit] spawn PAR_fn_eject};
		_unit setVariable ["PAR_wounded", true, true];
		_unit setVariable ["PAR_isUnconscious", true, true];
		_unit setCaptive true;
		_unit allowDamage false;
		_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_BleedOut), true];
		[_unit, _killer] spawn PAR_Player_Unconscious;
	};

	_amountOfDamage min 0.86;
};

PAR_Player_Unconscious = {
	params [ "_unit", "_killer" ];

	R3F_LOG_joueur_deplace_objet = objNull;

	// Death message
	if (PAR_EnableDeathMessages && !isNil "_killer" && _killer != _unit) then {
		["PAR_deathMessage", [_unit, _killer]] remoteExec ["PAR_public_EH", 0];
	};

	private _random_medic_message = floor (random 3);
	private _medic_message = "";
	switch (_random_medic_message) do {
		case 0 : { _medic_message = localize "STR_PAR_Need_Medic1"; };
		case 1 : { _medic_message = localize "STR_PAR_Need_Medic2"; };
		case 2 : { _medic_message = localize "STR_PAR_Need_Medic3"; };
	};
	_unit globalChat _medic_message;

	disableUserInput false;
	disableUserInput true;
	disableUserInput false;

	// Mute Radio
	5 fadeRadio 0;

	// Dog barf
	_my_dog = player getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", player] };

	// PAR AI Revive Call
	[_unit] spawn PAR_fn_unconscious;

	while { !isNull _unit && alive _unit && (_unit getVariable ["PAR_isUnconscious", false])} do {
		_bleedOut = player getVariable ["PAR_BleedOutTimer", 0];
		public_bleedout_message = format [localize "STR_BLEEDOUT_MESSAGE", round (_bleedOut - time)];
		public_bleedout_timer = round (_bleedOut - time);
		sleep 0.5;
	};

	if (alive _unit && !(_unit getVariable ["PAR_isUnconscious", false])) then {
		// Player got revived
		_unit switchMove "amovppnemstpsraswrfldnon";
		_unit playMoveNow "amovppnemstpsraswrfldnon";

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
