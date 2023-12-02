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
		// Save Stuff
		[PAR_grave_box] call F_clearCargo;
		[PAR_grave_box, _unit] call save_loadout_cargo;

		//_unit hideObject true;
		_unit setPosATL ((markerPos GRLIB_respawn_marker) vectorAdd [floor(random 5), floor(random 5), 1]);

		// create grave
		_grave = (selectRandom PAR_graves) createVehicle _pos;
		_grave allowDamage false;
		_grave setPosATL _pos;
		_grave setvariable ["PAR_grave_message", format ["- R.I.P - %1", name player], true];
		_grave_dir = getDir _grave;

		// remove old grave (max: 3)
		_old_graves = _unit getVariable ["PAR_player_graves", []];
		_old_graves pushback _grave;
		if (count _old_graves > 3) then {
			deleteVehicle (_old_graves select 0);
			_old_graves deleteAt 0;
		};
		_unit setvariable ["PAR_player_graves", _old_graves];

		// attach grave box
		_grave_box_pos = (getposATL _grave) vectorAdd ([[-1.75, 0, 0], -_grave_dir] call BIS_fnc_rotateVector2D);
		PAR_grave_box enableSimulationGlobal true;
		PAR_grave_box setPosATL _grave_box_pos;
		PAR_grave_box attachto [_grave];
		"player_grave_box" setMarkerPosLocal _grave;
	};

	// respawn penalty
	if ([_unit] call F_getScore > (GRLIB_perm_log + 50)) then { [_unit, -10] remoteExec ["F_addScore", 2] };

	// Respawn Cooldown
	if (GRLIB_respawn_cooldown > 0) then {
		player setVariable ["GRLIB_last_respawn", round (time + GRLIB_respawn_cooldown)];
	};
	titleText ["" ,"BLACK FADED", 100];
} else {
	gamelogic globalChat (format [localize "STR_PAR_DE_01", name _unit]);
};

removeAllWeapons _unit;
deleteVehicle _unit;
