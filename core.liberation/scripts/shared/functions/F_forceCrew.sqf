params ["_vehicle", "_side"];

if (_side == GRLIB_side_civilian) exitWith {[]};

private _mod = GRLIB_mod_east;
if (_side == GRLIB_side_friendly) then {
	_mod = GRLIB_mod_west;
};

private _path = format ["mod_template\%1\loadout\%2.sqf", _mod, "crewman"];
private _grp = _side createVehicleCrew _vehicle;
sleep 0.2;
(crew _vehicle) joinSilent _grp;
{
	if !(_vehicle isKindOf "Air") then {
		[_path, _x] call F_getTemplateFile;
		[_x] call reammo_ai;
	};
	if (_side == GRLIB_side_enemy) then {
		_x addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
	};
	if (_side == GRLIB_side_friendly) then {
		_x addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
	};
	_x addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_x setSkill 0.65;
	_x allowFleeing 0;
} foreach (units _grp);

_grp setCombatMode "WHITE";
_grp setBehaviour "AWARE";
(crew _vehicle);