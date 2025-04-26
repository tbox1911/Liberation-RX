params ["_unit"];

[(_unit getVariable ['PAR_myMedic', objNull]), _unit] call PAR_fn_medicRelease;

removeAllActions _unit;
if (_unit == player) then {
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

		// create grave
		private _grave = createVehicle [(selectRandom PAR_graves), zeropos, [], 0, "CAN_COLLIDE"];
		_grave allowDamage false;
		_grave setDir _dir;
		_grave setPosATL _pos;
		_grave setvariable ["PAR_grave_message", format ["- R.I.P - %1", name player], true];

		// remove old grave (max: 3)
		private _old_graves = _unit getVariable ["PAR_player_graves", []];
		_old_graves pushback _grave;
		if (count _old_graves > 3) then {
			deleteVehicle (_old_graves select 0);
			_old_graves deleteAt 0;
		};
		_unit setvariable ["PAR_player_graves", _old_graves];

		// attach grave box
		private _grave_box_pos = (getposATL _grave) vectorAdd ([[-1.75, 0, 0], -(getDir _grave)] call BIS_fnc_rotateVector2D);
		PAR_grave_box enableSimulationGlobal true;
		PAR_grave_box setPosATL _grave_box_pos;
		PAR_grave_box attachto [_grave];

		// Marker
		"PAR_grave_box_marker" setMarkerPosLocal PAR_grave_box;
	};

	// Marker
	deletemarker format ["PAR_marker_%1", PAR_Grp_ID];
	if (PAR_grave == 0) then { "PAR_grave_box_marker" setMarkerPosLocal _pos };

	// Respawn Penalty
	if ([_unit] call F_getScore > (GRLIB_perm_log + 50)) then { [_unit, -10] remoteExec ["F_addScore", 2] };

	// Respawn Cooldown
	if (GRLIB_respawn_cooldown > 0) then {
		player setVariable ["GRLIB_last_respawn", round (time + GRLIB_respawn_cooldown)];
	};
	titleText ["" ,"BLACK FADED", 100];
} else {
	PAR_AI_bros = PAR_AI_bros - [_unit];
	gamelogic globalChat (format [localize "STR_PAR_DE_01", name _unit]);
	sleep 50;
	removeAllWeapons _unit;
	hideBody _unit;
	sleep 10;
	deleteVehicle _unit;
};
