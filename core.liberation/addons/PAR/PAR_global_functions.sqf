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
	PAR_AI_bros select { lifeState _x != "INCAPACITATED" && isNil {_x getVariable 'PAR_busy'} };
};
PAR_unblock_AI = {
	// Unblock unit(s) 0-8-1
	params ["_unit_array"];
	if (player getVariable ["SOG_player_in_tunnel", false]) exitWith {};
	if ( isNull (objectParent player) && count _unit_array == 0 ) then {
		if (surfaceIsWater (getPos player)) then {
			private _pos = getPosASL player;
			private _zpos = _pos select 2;
			if (_zpos < -1.4) then { _pos set [2, -1.4 max _zpos] };
			player setPosASL _pos;
			player switchMove "";
			player playMoveNow "";
		} else {
			player setPosATL (getPosATL player vectorAdd [([] call F_getRND), ([] call F_getRND), 0.3]);
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
				sleep 0.2;
				unAssignVehicle _unit;
				[_unit] orderGetIn false;
				[_unit] allowGetIn false;
				sleep 0.2;
				if (surfaceIsWater (getPos _unit)) then {
					_unit setPosASL (getPosASL player vectorAdd [([] call F_getRND), ([] call F_getRND), 0]);
				} else {
					_unit setPosATL (getPosATL player vectorAdd [([] call F_getRND), ([] call F_getRND), 0.3]);
				};
				sleep 0.2;
				_unit stop false;
				_unit enableAI "ALL";
				[_unit] joinSilent (group player);
				sleep 0.2;
				_unit doFollow player;
				if (surfaceIsWater (getPos _unit)) then {
					_unit switchMove "";
					_unit playMoveNow "";
				} else {
					_unit switchMove "AmovPercMwlkSrasWrflDf";
					_unit playMoveNow "AmovPercMwlkSrasWrflDf";
				};
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
	if ((_speaker getVariable ["PAR_Grp_ID","0"]) == format ["Bros_%1", PAR_Grp_ID] || isPlayer _speaker) then {
		gamelogic globalChat _msg;
	};
};
PAR_fn_fixPos = {
	params ["_list"];
	{
		private _pos = getPosASL _x;
		if (surfaceIsWater _pos) then {
			if (isPlayer _x) then {
				_x switchMove ""; // reset
				_x playMoveNow "";
			} else {
				private _zpos = _pos select 2;
				if (_zpos < -1.2) then { _pos set [2, -1.2 max _zpos] };
				_x setPosASL _pos;
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
	private _mk1 = createMarkerLocal [format ["PAR_marker_%1", PAR_Grp_ID], getPosATL player];
	_mk1 setMarkerTypeLocal "loc_Hospital";
	_mk1 setMarkerTextLocal format ["%1 Injured", name player];
	_mk1 setMarkerColor "ColorRed";
};
PAR_del_marker = {
	deletemarker format ["PAR_marker_%1", PAR_Grp_ID];
};
PAR_revive_max = {
	params ["_unit"];

	private _cur_revive = (_unit getVariable ["PAR_revive_max", PAR_ai_revive]) - 1;
	_unit setVariable ["PAR_revive_max", _cur_revive];
	private _msg = format ["%1, %2 Revive left.", name _unit, _cur_revive];
	if (_cur_revive == 0) then { _msg = format ["CRITICAL! %1 LAST Revive !!", name _unit] };
	[_unit, _msg] call PAR_fn_globalchat;

	private _timer = 20;
	while { _timer >= 0 && alive _unit } do {
		private _near_medical = (count (nearestObjects [_unit, [medic_heal_typename], 12]) > 0);
		if (_near_medical) then {
			if (_unit distance2D player < 100) then {
				private _msg = format ["%1 is Healing faster...", name _unit];
				[_unit, _msg] call PAR_fn_globalchat;
			};
			sleep 25;
		} else {
			sleep 60;
		};
		_timer = _timer - 1;
	};

	if (!alive _unit) exitWith {};
	private _revive = (_unit getVariable ["PAR_revive_max", PAR_ai_revive]) + 1;
	_unit setVariable ["PAR_revive_max", _revive];
	private _msg = format ["%1 revive restored (%2) !!", name _unit, _revive];
	[_unit, _msg] call PAR_fn_globalchat;
};
PAR_spawn_gargbage = {
	params ["_target"];
	private _pos = getPos _target;
	if (surfaceIsWater _pos) exitWith {};
	if (_pos select 2 > 10) exitWith {};
	private _grbg = createVehicle [(selectRandom PAR_MedGarbage), _pos, [], 0, "CAN_COLLIDE"];
	_grbg spawn {sleep (60 + floor(random 30)); deleteVehicle _this};
};
PAR_spawn_blood = {
	params ["_target"];
	private _pos = getPos _target;
	if (surfaceIsWater _pos) exitWith {objNull};
	if (_pos select 2 > 10) exitWith {objNull};
	private _grbg = createVehicle [(selectRandom PAR_BloodSplat), _pos, [], 0, "CAN_COLLIDE"];
	_grbg;
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
	_unit setVariable ["PAR_revive_max", (PAR_ai_revive + (GRLIB_rank_level find (rank _unit)))];
	_unit setVariable ["PAR_Grp_ID", format["Bros_%1", PAR_Grp_ID], true];
	_unit setVariable ["GRLIB_can_speak", true, true];
};

// Player Section
PAR_Player_Init = {
	player addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	player setVariable ["PAR_wounded", false, true];
	player setVariable ["PAR_isUnconscious", false, true];
	player setVariable ["PAR_isDragged", 0, true];
	player setVariable ["ace_sys_wounds_uncon", false];
	player setVariable ["PAR_Grp_ID", format["Bros_%1", PAR_Grp_ID], true];
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
		private _veh_killer = objectParent _killer;
		private _veh_tk = true;
		if (!isNull _veh_killer) then {
			_veh_tk = (_veh_killer distance2D _veh_unit > 10);
		};
		if (_isNotWounded && isPlayer _killer && _killer != _unit && _veh_tk && _amountOfDamage > 0.15) then {
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

	private _medic_message = "";
	switch (floor random 3) do {
		case 0 : { _medic_message = localize "STR_PAR_Need_Medic1"; };
		case 1 : { _medic_message = localize "STR_PAR_Need_Medic2"; };
		case 2 : { _medic_message = localize "STR_PAR_Need_Medic3"; };
	};
	_unit globalChat _medic_message;

	// Mute Radio
	5 fadeRadio 0;

	// Dog barf
	_my_dog = player getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", player] };

	// PAR AI Revive Call
	[_unit] spawn PAR_fn_unconscious;
	sleep 1;

	while { alive _unit && (_unit getVariable ["PAR_isUnconscious", false])} do {
		private _bleedOut = player getVariable ["PAR_BleedOutTimer", 0];
		public_bleedout_message = format [localize "STR_BLEEDOUT_MESSAGE", round (_bleedOut - time)];
		public_bleedout_timer = round (_bleedOut - time);
		sleep 0.5;
	};

	// Player got revived
	if (!(_unit getVariable ["PAR_isUnconscious", false])) then {
		// Unmute Radio
		5 fadeRadio 1;

		// Unmute ACRE
		_unit setVariable ["ace_sys_wounds_uncon", false];

		// Dog stop
		if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", nil] };
	};
};
