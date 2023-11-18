params ["_unit"];
private ["_pos", "_grave", "_grave_box", "_old_graves", "_uniform", "_vest", "_backpack" ];

_unit connectTerminalToUAV objNull;
[(_unit getVariable ['PAR_myMedic', objNull]), _unit] call PAR_fn_medicRelease;
_unit setVariable ['PAR_wounded', false];

if (_unit == player) then {
	// Grave + stuff box
	_pos = getPosATL _unit;
	if ( isNull objectParent player &&
		!([_unit, "LHD", GRLIB_capture_size] call F_check_near) &&
		round (_pos select 2) == 0 && !(surfaceIsWater _pos)
	) then {
		_unit setPosATL ((markerPos GRLIB_respawn_marker) vectorAdd [floor(random 5), floor(random 5), 1]);
		// create grave
		_grave = (selectRandom GRLIB_player_grave) createVehicle _pos;
		_grave allowDamage false;
		[_grave, playerbox_cargospace] remoteExec ["setMaxLoad", 2];
		_grave setPosATL _pos;
		_grave setvariable ["GRLIB_grave_message", format ["%1 - R.I.P -", name player], true];
		_grave_dir = getDir _grave;

		// create grave box
		_grave_box_pos = (getposATL _grave) vectorAdd ([[-1.75, 0, 0], -_grave_dir] call BIS_fnc_rotateVector2D);
		_grave_box = GRLIB_player_gravebox createVehicle _grave_box_pos;
		_grave_box setPosATL _grave_box_pos;
		_grave_box attachto [_grave];
		_grave_box setVariable ["R3F_LOG_disabled", true, true];
		_grave_box setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];

		// remove old grave and box
		_old_graves_max = 3;
		_old_graves = _unit getVariable ["GRLIB_grave", []];
		if (count _old_graves > 0) then {
			{ deleteVehicle _x } forEach (attachedObjects (_old_graves select (count _old_graves)-1));
			if (count _old_graves >= _old_graves_max) then {
				deleteVehicle (_old_graves select 0);
				_old_graves deleteAt 0;
			};
		};
		_old_graves pushback _grave;
		_unit setvariable ["GRLIB_grave", _old_graves, true];
		"player_grave_box" setMarkerPosLocal _grave_box;

		// clear box
		[_grave_box] call F_clearCargo;
		[_grave_box, _unit] call save_loadout_cargo;
	};

	// respawn penalty
	if ([_unit] call F_getScore > (GRLIB_perm_log + 50)) then { [_unit, -10] remoteExec ["F_addScore", 2] };

	// Respawn Cooldown
	if (GRLIB_respawn_cooldown > 0) then {
		player setVariable ["GRLIB_last_respawn", round (time + GRLIB_respawn_cooldown)];
	};
	titleText ["" ,"BLACK FADED", 100];
};

removeAllWeapons _unit;
deleteVehicle _unit;
