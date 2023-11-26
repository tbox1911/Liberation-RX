params ["_unit"];
private ["_pos", "_grave", "_grave_box", "_old_graves", "_uniform", "_vest", "_backpack" ];

_unit connectTerminalToUAV objNull;
[(_unit getVariable ['PAR_myMedic', objNull]), _unit] call PAR_fn_medicRelease;
_unit setVariable ['PAR_wounded', false];

if (_unit == player) then {
	// Grave + Save Stuff
	_pos = getPosATL _unit;
	if ( isNull objectParent player &&
		!([_unit, "LHD", GRLIB_capture_size] call F_check_near) &&
		round (_pos select 2) == 0 && !(surfaceIsWater _pos)
	) then {
		_unit hideObject true;
		//_unit setPosATL ((markerPos GRLIB_respawn_marker) vectorAdd [floor(random 5), floor(random 5), 1]);

		// Save Stuff
		[GRLIB_grave] call F_clearCargo;
		[GRLIB_grave, _unit] call save_loadout_cargo;

		// create grave
		_grave = (selectRandom GRLIB_player_grave) createVehicle _pos;
		_grave allowDamage false;
		_grave setPosATL _pos;
		_grave setvariable ["GRLIB_grave_message", format ["%1 - R.I.P -", name player], true];
		_grave_dir = getDir _grave;

		// attach grave box
		_grave_box_pos = (getposATL _grave) vectorAdd ([[-1.75, 0, 0], -_grave_dir] call BIS_fnc_rotateVector2D);
		GRLIB_grave enableSimulationGlobal true;
		GRLIB_grave setPosATL _grave_box_pos;
		GRLIB_grave attachto [_grave];
		"player_grave_box" setMarkerPosLocal GRLIB_grave;
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
