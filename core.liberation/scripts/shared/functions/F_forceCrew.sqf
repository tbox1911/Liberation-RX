params ["_vehicle", ["_side", GRLIB_side_friendly]];

private _grp = _side createVehicleCrew _vehicle;
{ _x allowDamage false } foreach (units _grp);
sleep 0.2;

if (count (crew _vehicle) == 0) then {
	_grp = createGroup [_side, true];
	_unit = _grp createUnit [crewman_classname, (getPosATL _vehicle), [], 20, "NONE"];
	_unit allowDamage false;
	_unit assignAsDriver _vehicle;
	_unit moveInDriver _vehicle;
	sleep 0.2;
};

(units _grp) joinSilent _grp;
(units _grp) allowGetIn true;
(units _grp) orderGetIn true;

private _path = "";
private _aircraft = (_vehicle isKindOf "Air");
{
	if (_side == GRLIB_side_enemy) then {
		_x addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
		if (_aircraft) then {
			[_x] spawn escape_ai;
		} else {
			_path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_east, "crewman"];
			[_path, _x] call F_getTemplateFile;
			[_x] spawn reammo_ai;
		};
	};

	if (_side == GRLIB_side_friendly) then {
		_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
		if (_aircraft) then {
			[_x] spawn escape_ai;
		} else {
			_path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, "crewman"];
			[_path, _x] call F_getTemplateFile;
			[_x] spawn reammo_ai;
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
if (_side == GRLIB_side_civilian) then {
	_grp setCombatMode "BLUE";
	_grp setBehaviourStrong "CARELESS";
} else {
	_grp setCombatMode "WHITE";
	_grp setBehaviourStrong "AWARE";
};
sleep 1;
{ _x setDamage 0; _x allowDamage true } foreach (units _grp);
(crew _vehicle);
