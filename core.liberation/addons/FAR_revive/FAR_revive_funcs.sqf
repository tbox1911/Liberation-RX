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
			if (round (player distance2D _unit) < 50 && (lifeState _unit != 'incapacitated') ) then {
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
			} else {
				hintSilent "Unit is too far or is unconscious. (max 50m)";
				sleep 2;
				hintSilent "";
			};
		} forEach _unit_array;
	};
};

////////////////////////////////////////////////
// Player Actions
////////////////////////////////////////////////
FAR_Player_Actions = {
	if (alive player && player isKindOf "Man") then
	{
		// addAction args: title, filename, (arguments, priority, showWindow, hideOnUse, shortcut, condition, positionInModel, radius, radiusView, showIn3D, available, textDefault, textToolTip)
		player addAction ["<t color='#00C900'>" + "Revive" + "</t>", "addons\FAR_revive\FAR_handleAction.sqf", ["action_revive"], 10, true, true, "", "call FAR_Check_Revive"];
		player addAction ["<t color='#009900'>" + "Stabilize" + "</t>", "addons\FAR_revive\FAR_handleAction.sqf", ["action_stabilize"], 10, true, true, "", "call FAR_Check_Stabilize"];
		player addAction ["<t color='#C90000'>" + "Suicide" + "</t>", "addons\FAR_revive\FAR_handleAction.sqf", ["action_suicide"], 9, false, true, "", "call FAR_Check_Suicide"];
		player addAction ["<t color='#C90000'>" + "Drag" + "</t>", "addons\FAR_revive\FAR_handleAction.sqf", ["action_drag"], 9, false, true, "", "call FAR_Check_Dragging"];
	};
};

////////////////////////////////////////////////
// Handle Death
////////////////////////////////////////////////
FAR_HandleDamage_EH = {
	params [ "_unit", "_selectionName", "_amountOfDamage", "_killer", "_projectile", "_hitPartIndex" ];
	private [ "_isUnconscious", "_olddamage", "_damageincrease", "_vestarmor", "_vest_passthrough", "_vestobject", "_helmetarmor",  "_helmet_passthrough", "_helmetobject" ];

	_isUnconscious = _unit getVariable "FAR_isUnconscious";

    if (_isUnconscious == 0 && (_amountOfDamage >= 0.86)) then {
		closedialog 0;
		_unit setVariable ["FAR_isUnconscious", 1, true];
		_unit setCaptive true;
		_unit allowDamage false;
		[_unit, _killer] spawn FAR_Player_Unconscious;
	};
	_amountOfDamage min 0.86;
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

    // TK Protect
	BTC_vip = [];
	_veh_unit = vehicle _unit;
	_veh_killer = vehicle _killer;
	if (isPlayer _killer && _killer != _unit && _veh_unit != _veh_killer && BTC_vip find (name _killer) == -1) exitWith	{
		FAR_tkMessage = [_unit, _killer];
		publicVariable "FAR_tkMessage";
		["FAR_tkMessage", [_unit, _killer]] call FAR_public_EH;

		BTC_tk_PVEH = [name _killer];
		publicVariable "BTC_tk_PVEH";
		_unit setDamage 0;
		_unit setVariable ["FAR_isUnconscious", 0, true];
		_unit setVariable ["GREUH_isUnconscious", 0, true];
		_unit setUnconscious false;
		sleep 3;
		_unit allowDamage true;
	};

	// Eject unit if inside vehicle
	_veh = objectParent _unit;
	if (!(isNull _veh)) then {[_veh, _unit] spawn MGI_fn_eject};

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

	// MGI AI Revive Call
	_unit setVariable ["GREUH_isUnconscious", 1, true];
	_unit setUnconscious true;
	_unit setVariable ["MGI_isUnconscious", true];

	// Mute Radio
	5 fadeRadio 0;

	// Dog barf
	_my_dog = player getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then { _my_dog setVariable ["do_find", player] };

	_unit switchMove "";
	[_unit] spawn MGI_fn_unconscious;

	_bleedOut = time + FAR_BleedOut;
	while { !isNull _unit && alive _unit && _unit getVariable "FAR_isUnconscious" == 1 && _unit getVariable "FAR_isStabilized" == 0 && (FAR_BleedOut <= 0 || time < _bleedOut) } do
	{
		//hintSilent format[localize "STR_BLEEDOUT_MESSAGE" + "\n\n%2", round (_bleedOut - time), call FAR_CheckFriendlies];
		hintSilent format[localize "STR_BLEEDOUT_MESSAGE" + "\n", round (_bleedOut - time)];
		public_bleedout_message = format [localize "STR_BLEEDOUT_MESSAGE", round (_bleedOut - time)];
		public_bleedout_timer = round (_bleedOut - time);
		sleep 0.5;
	};

	if (_unit getVariable "FAR_isStabilized" == 1) then {
		//Unit has been stabilized. Disregard bleedout timer and umute player
		_unit setVariable ["ace_sys_wounds_uncon", false];
		while { !isNull _unit && alive _unit && _unit getVariable "FAR_isUnconscious" == 1 } do
		{
			//hintSilent format["%1\n\n%2", localize "STR_BLEEDOUT_STABILIZED", call FAR_CheckFriendlies];
			hintSilent format["%1\n", localize "STR_BLEEDOUT_STABILIZED"];
			public_bleedout_message = localize "STR_BLEEDOUT_STABILIZED";
			public_bleedout_timer = FAR_BleedOut;
			sleep 0.5;
		};
	};

	// Player bled out
	if ((FAR_BleedOut > 0 && {time > _bleedOut} && {_unit getVariable ["FAR_isStabilized",0] == 0}) || (vehicle _unit != _unit)) then {
		_unit setDamage 1;
	} else {
		// Player got revived
		_unit setVariable ["FAR_isStabilized", 0, true];

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

		_unit setUnconscious false;
		_unit playMove "amovppnemstpsraswrfldnon";
		_unit playMove "";
		uIsleep 10;

		_unit setCaptive false;
		_unit allowDamage true;
	};
};

////////////////////////////////////////////////
// Revive Player
////////////////////////////////////////////////
FAR_HandleRevive = {
	private ["_target"];

	_target = _this select 0;
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "attendant");
	if (alive _target) then	{
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 6;
		if (!("Medikit" in (backpackItems player)) ) then {
			player removeItem "FirstAidKit";
		};
		if (_isMedic == 1 && "Medikit" in (backpackItems player)) then {
			_target setDamage 0;
		} else {
			_target setDamage 0.25;
		};
		_target setVariable ["FAR_isUnconscious", 0, true];
		_target setVariable ['MGI_isUnconscious', false];
		_target setVariable ["FAR_isDragged", 0, true];
		[player, 5] remoteExec ["addScore", 2];
	};
};

////////////////////////////////////////////////
// Stabilize Player
////////////////////////////////////////////////
FAR_HandleStabilize = {
	private ["_target"];
	_target = _this select 0;
	if (alive _target) then
	{
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		if (!("Medikit" in (items player)) ) then {
			player removeItem "FirstAidKit";
		};
		_target setVariable ["FAR_isStabilized", 1, true];
		sleep 6;
	};
};

////////////////////////////////////////////////
// Drag Injured Player
////////////////////////////////////////////////
FAR_Drag = {
	private ["_target", "_id"];

	FAR_isDragging = true;

	_target = _this select 0;

	_target attachTo [player, [0, 1.1, 0.092]];
	_target setDir 180;
	_target setVariable ["FAR_isDragged", 1, true];

	player playMoveNow "AcinPknlMstpSrasWrflDnon";

	// Rotation fix
	FAR_isDragging_EH = _target;
	publicVariable "FAR_isDragging_EH";

	// Add release action and save its id so it can be removed
	_id = player addAction ["<t color='#C90000'>" + "Release" + "</t>", "addons\FAR_revive\FAR_handleAction.sqf", ["action_release"], 10, true, true, "", "true"];

	hint "Press 'C' if you can't move.";

	// Wait until release action is used
	waitUntil
	{
		!alive player || player getVariable ["FAR_isUnconscious", 1] == 1 ||
		!alive _target || _target getVariable ["FAR_isUnconscious", 1] == 0 ||
		_target getVariable "FAR_isDragged" == 0 || lifeState _target != 'incapacitated' ||
		!FAR_isDragging
	};

	// Handle release action
	FAR_isDragging = false;

	if (!isNull _target && alive _target) then
	{
		_target switchMove "AinjPpneMstpSnonWrflDnon";
		_target setVariable ["FAR_isDragged", 0, true];
		detach _target;
	};
	// Switch back to default animation
	player playMove "amovpknlmstpsraswrfldnon";
	player removeAction _id;
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
// Revive Action Check
////////////////////////////////////////////////
FAR_Check_Revive = {
	private ["_target", "_isTargetUnconscious", "_isDragged"];

	_return = false;

	// Unit that will excute the action
	_isPlayerUnconscious = player getVariable "FAR_isUnconscious";
	_isMedic = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "attendant");
	_target = cursorTarget;

	// Make sure player is alive and target is an injured unit
	if( !alive player || _isPlayerUnconscious == 1 || FAR_isDragging || !isNull R3F_LOG_joueur_deplace_objet || isNil "_target" || !alive _target || (!isPlayer _target && !FAR_Debugging) || round(_target distance2D player) > 3 ) exitWith
	{
		_return
	};

	_isTargetUnconscious = _target getVariable "FAR_isUnconscious";
	_isDragged = _target getVariable "FAR_isDragged";

	// Make sure target is unconscious and player is a medic
	if (_isTargetUnconscious == 1 && _isDragged == 0 && (_isMedic == 1 || FAR_ReviveMode > 0) && ( ("FirstAidKit" in (items player)) || ("Medikit" in (items player)) ) ) then
	{
		_return = true;

		// [ReviveMode] Check if player has a Medikit
		if ( FAR_ReviveMode == 2 && !("Medikit" in (items player)) ) then
		{
			_return = false;
		};
	};

	_return
};

////////////////////////////////////////////////
// Stabilize Action Check
////////////////////////////////////////////////
FAR_Check_Stabilize = {
	private ["_target", "_isTargetUnconscious", "_isDragged"];

	_return = false;

	// Unit that will excute the action
	_isPlayerUnconscious = player getVariable "FAR_isUnconscious";
	_target = cursorTarget;


	// Make sure player is alive and target is an injured unit
	if( !alive player || _isPlayerUnconscious == 1 || FAR_isDragging || !isNull R3F_LOG_joueur_deplace_objet || isNil "_target" || !alive _target || (!isPlayer _target && !FAR_Debugging) || (_target distance player) > 2 ) exitWith
	{
		_return
	};

	_isTargetUnconscious = _target getVariable "FAR_isUnconscious";
	_isTargetStabilized = _target getVariable "FAR_isStabilized";
	_isDragged = _target getVariable "FAR_isDragged";

	// Make sure target is unconscious and hasn't been stabilized yet, and player has a FAK/Medikit
	if (_isTargetUnconscious == 1 && _isTargetStabilized == 0 && _isDragged == 0 && ( ("FirstAidKit" in (items player)) || ("Medikit" in (items player)) ) ) then
	{
		_return = true;
	};

	_return
};

////////////////////////////////////////////////
// Suicide Action Check
////////////////////////////////////////////////
FAR_Check_Suicide = {
	_return = false;
	_isPlayerUnconscious = player getVariable ["FAR_isUnconscious",0];

	if (alive player && _isPlayerUnconscious == 1) then
	{
		_return = true;
	};

	_return
};

////////////////////////////////////////////////
// Dragging Action Check
////////////////////////////////////////////////
FAR_Check_Dragging = {
	private ["_target", "_isPlayerUnconscious", "_isDragged"];

	_return = false;
	_target = cursorTarget;
	_isPlayerUnconscious = player getVariable "FAR_isUnconscious";

	if( !alive player || _isPlayerUnconscious == 1 || FAR_isDragging || !isNull R3F_LOG_joueur_deplace_objet || isNil "_target" || !alive _target || (_target distance player) > 3 ) exitWith
	{
		_return;
	};

	_isDragged = _target getVariable ["FAR_isDragged", 0];
	if( lifeState _target == 'incapacitated' && _isDragged == 0) then {
		_return = true;
	};

	_return
};
