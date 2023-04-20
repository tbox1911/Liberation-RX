////////////////////////////////////////////////
// AI Support Menu
////////////////////////////////////////////////
FAR_unblock_AI = {
	params ["_unit_array"];
	if ( count _unit_array == 0 ) then {
		player setPos (getPos player vectorAdd [([] call F_getRND), ([] call F_getRND), 1]);
	} else {
		{
			_unit = _x;
			if (round (player distance2D _unit) < 50 && (lifeState _unit != 'INCAPACITATED') && vehicle _unit == _unit) then {
				doStop _unit;
				sleep 1;
				_unit doWatch objNull;
				_unit switchmove "";
				_unit disableAI "ALL";
				_grp = createGroup [GRLIB_side_friendly, true];
				[_unit] joinSilent _grp;
				doStop _unit;
				sleep 1;
				_unit setPos (getPos player vectorAdd [([] call F_getRND), ([] call F_getRND), 1]);
				[_unit] joinSilent (group player);
				_unit enableAI "ALL";
				_unit doFollow leader player;
				_unit switchMove "amovpknlmstpsraswrfldnon";
			} else {
				hintSilent "Unit is too far or is unconscious. (max 50m)";
				sleep 2;
				hintSilent "";
			};
		} forEach _unit_array;
	};
};

////////////////////////////////////////////////
// Handle Death
////////////////////////////////////////////////
FAR_HandleDamage_EH = {
	params [ "_unit", "_selectionName", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex" ];

	private _veh_unit = vehicle _unit;
	private _veh_killer = vehicle _killer;
	private _max_damage = 0.86;

	// TK Protect
	private _isProtected = _unit getVariable ["FAR_isProtected", 0];
	if (_isProtected == 0 && isPlayer _killer && _killer != _unit && _veh_unit != _veh_killer && BTC_vip find (name _killer) == -1) then {
		_unit setVariable ["FAR_isProtected", 1, true];
		FAR_tkMessage = [_unit, _killer];
		publicVariable "FAR_tkMessage";
		["FAR_tkMessage", [_unit, _killer]] call FAR_public_EH;
		BTC_tk_PVEH = [name _killer];
		publicVariable "BTC_tk_PVEH";
		[_unit] spawn { sleep 3;(_this select 0) setVariable ["FAR_isProtected", 0, true] };
		_isProtected = 1;
	};

	if (_isProtected == 1) then {
		_max_damage = 0;
	};

	private _isUnconscious = _unit getVariable ["FAR_isUnconscious", 0];
	if (_isProtected == 0 && _isUnconscious == 0 && (_amountOfDamage >= 0.86)) then {
		closedialog 0;
		_unit setVariable ["FAR_isUnconscious", 1, true];
		_unit setCaptive true;
		_unit allowDamage false;
		_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_BleedOut), true];
		[_unit, _killer] spawn FAR_Player_Unconscious;
	};

	_amountOfDamage min _max_damage;
};

////////////////////////////////////////////////
// Make Player Unconscious
////////////////////////////////////////////////
FAR_Player_Unconscious = {
	params [ "_unit", "_killer" ];

	// Death message
	if (FAR_EnableDeathMessages && !isNil "_killer" && _killer != _unit) then
	{
		FAR_deathMessage = [_unit, _killer];
		publicVariable "FAR_deathMessage";
		["FAR_deathMessage", [_unit, _killer]] call FAR_public_EH;
	};

	// Eject unit if inside vehicle
	private _veh_unit = vehicle _unit;
	if (_veh_unit != _unit) then {[_veh_unit, _unit] spawn PAR_fn_eject};

	[] call R3F_LOG_FNCT_objet_relacher;

	_random_medic_message = floor (random 3);
	_medic_message = localize "STR_FAR_Need_Medic1";
	switch (_random_medic_message) do {
		case 0 : { _medic_message = localize "STR_FAR_Need_Medic1"; };
		case 1 : { _medic_message = localize "STR_FAR_Need_Medic2"; };
		case 2 : { _medic_message = localize "STR_FAR_Need_Medic3"; };
	};
	public_medic_message = [_unit,_medic_message]; publicVariable "public_medic_message";

	disableUserInput false;
	disableUserInput true;
	disableUserInput false;

	// PAR AI Revive Call
	_unit setVariable ["GREUH_isUnconscious", 1, true];
	_unit setUnconscious true;
	_unit setVariable ["PAR_isUnconscious", true];

	// Mute Radio
	5 fadeRadio 0;

	// Dog barf
	_my_dog = player getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", player] };

	_unit switchMove "";
	[_unit] spawn PAR_fn_unconscious;

	while { !isNull _unit && alive _unit && _unit getVariable "FAR_isUnconscious" == 1 } do {
		_bleedOut = player getVariable ["PAR_BleedOutTimer", 0];
		hintSilent format[localize "STR_BLEEDOUT_MESSAGE" + "\n", round (_bleedOut - time)];
		public_bleedout_message = format [localize "STR_BLEEDOUT_MESSAGE", round (_bleedOut - time)];
		public_bleedout_timer = round (_bleedOut - time);
		sleep 0.5;
	};

	if (alive _unit && _unit getVariable "FAR_isUnconscious" == 0) then {
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

////////////////////////////////////////////////
// Drag Injured Unit
////////////////////////////////////////////////
FAR_Drag = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	FAR_isDragging = true;

	_target attachTo [player, [0, 1.1, 0.092]];
	_target setDir 180;
	_target setVariable ["FAR_isDragged", 1, true];

	player playMoveNow "AcinPknlMstpSrasWrflDnon";

	// Rotation fix
	FAR_isDragging_EH = _target;
	publicVariable "FAR_isDragging_EH";

	// Wait until release action is used
	waitUntil
	{
		!alive player || player getVariable ["FAR_isUnconscious", 1] == 1 ||
		!alive _target || _target getVariable ["FAR_isUnconscious", 1] == 0 ||
		_target getVariable ["FAR_isDragged", 0] == 0 || lifeState _target != 'INCAPACITATED' ||
		!FAR_isDragging
	};


	if (!isNull _target && alive _target) then
	{
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target setVariable ["FAR_isDragged", 0, true];
		detach _target;
	};
	// Switch back to default animation
	player playMove "amovpknlmstpsraswrfldnon";
	sleep 2;

	// Handle release action
	FAR_isDragging = false;
};

FAR_Release = {
	FAR_isDragging = false;
};

////////////////////////////////////////////////
// Event handler for public variables
////////////////////////////////////////////////
FAR_public_EH = {
  private ["_timeout", "_action", "_msg"];
	if(count _this < 2) exitWith {};

	_EH  = _this select 0;
	_target = _this select 1;

	// FAR_isDragging
	if (_EH == "FAR_isDragging_EH") then
	{
		_target setDir 180;
	};

	// FAR_deathMessage
	if (_EH == "FAR_deathMessage") then
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

	// FAR_tkMessage
	if (_EH == "FAR_tkMessage") then
	{
		_killed = _target select 0;
		_killer = _target select 1;

		if (isPlayer _killer && isPlayer _killed ) then
		{
			gamelogic globalChat (format ["%1 has committed TK and has been punished by %2",name _killer, name _killed]);
		};
	};
};

////////////////////////////////////////////////
// If the unit is Medic
////////////////////////////////////////////////
FAR_is_medic = {
	params ["_unit"];
	private _ret = false;

	if ( getNumber (configfile >> "CfgVehicles" >> typeOf _unit >> "attendant") == 1 ) then {
		_ret = true;
	};
	_ret
};

////////////////////////////////////////////////
// If the unit has a "Medikit"
////////////////////////////////////////////////
FAR_has_medikit = {
	params ["_unit"];
	private _ret = false;

	if ( (FAR_Medikit in (vest _unit)) || (FAR_Medikit in (items _unit)) || (FAR_Medikit in (backpackItems _unit)) ) then {
		_ret = true;
	};
	_ret
};