params ["_vehicle", "_side"];

private _mod = GRLIB_mod_east;
if (_side == GRLIB_side_friendly) then {
	_mod = GRLIB_mod_west;
};

private _not_aircraft = !(_vehicle isKindOf "Air");
private _path = format ["mod_template\%1\loadout\%2.sqf", _mod, "crewman"];
private _grp = _side createVehicleCrew _vehicle;
sleep 0.2;
(units _grp) joinSilent _grp;
(units _grp) allowGetIn true;
(units _grp) orderGetIn true;

{
	if (_side == GRLIB_side_enemy) then {
		_x addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
		if (_not_aircraft) then {
			[_path, _x] call F_getTemplateFile;
			[_x] call reammo_ai;
		};
	};

	if (_side == GRLIB_side_friendly) then {
		_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
		if (_not_aircraft) then {
			[_path, _x] call F_getTemplateFile;
			[_x] call reammo_ai;
		};
	};

	if (_side == GRLIB_side_civilian) then {
		_x setVariable ['GRLIB_can_speak', true, true];
		_x addEventHandler ["HandleDamage", { _this call damage_manager_civilian }];
	};

	_x addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_x setSkill 0.65;
	_x allowFleeing 0;
} foreach (units _grp);

(group _vehicle) addVehicle _vehicle;
_grp setCombatMode "WHITE";
_grp setBehaviour "AWARE";
(crew _vehicle);