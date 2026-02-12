params ["_unit"];

[(_unit getVariable ['PAR_myMedic', objNull]), _unit] call PAR_fn_medicRelease;

removeAllActions _unit;
if (_unit == player) then {
	disableUserInput true;
	titleText ["" ,"BLACK FADED", 100];
	1 fadeSound 0;
	_unit connectTerminalToUAV objNull;

	// Grave + Save Stuff
	private _pos = getPosATL _unit;
	private _dir = getDir _unit;
	if (PAR_grave == 1 && isNull objectParent player &&	!([_unit, "LHD", GRLIB_capture_size] call F_check_near) && (_pos select 2) <= 2 && !(surfaceIsWater _pos)) then {

		// Clean body
		removeAllWeapons _unit;
		_unit setPosATL ((markerPos GRLIB_respawn_marker) vectorAdd [floor random 5, floor random 5, 0.5]);

		// Save Stuff
		[PAR_grave_box] call F_clearCargo;
		[PAR_grave_box, PAR_backup_loadout] call F_setCargo;

		// remove old grave (max: 3)
		private _old_graves = (allMissionObjects "Cemetery_base_F" select { _x getVariable ["GRLIB_vehicle_owner", ""] == PAR_Grp_ID });
		if (count _old_graves >= 3) then { deleteVehicle (selectRandom _old_graves) };

		// create grave
		private _grave = createVehicle [(selectRandom PAR_graves), zeropos, [], 0, "CAN_COLLIDE"];
		_grave allowDamage false;
		_grave setDir _dir;
		_grave setPosATL _pos;
		_grave setVectorUp surfaceNormal position _grave;
		_grave setvariable ["PAR_grave_message", format ["- R.I.P - %1", name player], true];
		_grave setvariable ["GRLIB_vehicle_owner", PAR_Grp_ID, true];

		// attach grave box
		private _grave_box_pos = (getposATL _grave) vectorAdd ([[-1.75, 0, 0], -(getDir _grave)] call BIS_fnc_rotateVector2D);
		PAR_grave_box enableSimulationGlobal true;
		PAR_grave_box setPosATL _grave_box_pos;
		PAR_grave_box attachto [_grave];

		// Marker
		"PAR_grave_box_marker" setMarkerPosLocal PAR_grave_box;
	};

	// TFAR
	if (GRLIB_TFR_enabled) then {
		player setVariable ["GRLIB_TFAR_SW_config", (call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings];
		player setVariable ["GRLIB_TFAR_LR_config", (call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrSettings];
	};

	// Marker
	if (PAR_grave == 0) then { "PAR_grave_box_marker" setMarkerPosLocal _pos };

	// Respawn Penalty
	if ([_unit] call F_getScore > (GRLIB_perm_log + 50)) then { [_unit, -10] remoteExec ["F_addScore", 2] };

	// Respawn Cooldown
	if (GRLIB_respawn_cooldown > 0) then {
		player setVariable ["GRLIB_last_respawn", round (time + GRLIB_respawn_cooldown)];
	};

	// No stuff
	_unit setVariable ["GREUH_stuff_price", nil, true];

	// Death count
	_unit setVariable ["GREUH_killed", (_unit getVariable ["GREUH_killed", 0]) + 1, true];
	GRLIB_player_spawned = false;

	titleText ["" ,"BLACK FADED", 100];
} else {
	PAR_AI_bros = PAR_AI_bros - [_unit];
	private _msg = format [localize "STR_PAR_DE_01", name _unit];
	[_unit, _msg] call PAR_fn_globalchat;
	sleep 50;
	removeAllWeapons _unit;
	hideBody _unit;
	sleep 10;
	deleteVehicle _unit;
};
