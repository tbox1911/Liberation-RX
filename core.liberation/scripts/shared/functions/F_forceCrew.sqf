params ["_vehicle", ["_side", GRLIB_side_friendly]];

// Aircraft / Drone
if (typeOf _vehicle in uavs_vehicles + static_vehicles_AI || (_vehicle isKindOf "Air")) exitWith {
	private _grp = createGroup [_side, true];
	_side createVehicleCrew _vehicle;
	sleep 0.2;
	(crew _vehicle) joinSilent _grp;
	(crew _vehicle);
};

private _vehicle_roles = [];
if (_vehicle isKindOf "StaticWeapon") then {
	_vehicle_roles = ["gunner"];
};
if (_side == GRLIB_side_civilian) then {
		_vehicle_roles = ["driver"];
};
if (count _vehicle_roles == 0) then {
	{
		if ((_x select 1) in ["driver","commander","gunner"]) then { _vehicle_roles pushBackUnique (_x select 1) };
	} forEach (fullCrew [_vehicle, "", true]);
};
if (count _vehicle_roles == 0) exitWith {[]};

private _path = "";
private _grp = createGroup [_side, true];
{
	private _unit = objNull;
	if (_side == GRLIB_side_enemy) then {
		_unit = _grp createUnit [opfor_crew, _vehicle, [], 20, "NONE"];
		_unit addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
		if (typeOf _vehicle in militia_vehicles) then {
			_path = format ["mod_template\%1\loadout\crewman.sqf", GRLIB_mod_east];
			[_path, _unit] call F_getTemplateFile;
			[_unit] spawn reammo_ai;
		};
	};

	if (_side == GRLIB_side_friendly) then {
		_unit = _grp createUnit [crewman_classname, _vehicle, [], 20, "NONE"];
		_unit addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
		_path = format ["mod_template\%1\loadout\crewman.sqf", GRLIB_mod_west];
		[_path, _unit] call F_getTemplateFile;
		[_unit] spawn reammo_ai;
	};

	if (_side == GRLIB_side_civilian) then {
		_unit = _grp createUnit [(selectRandom civilians), _vehicle, [], 20, "NONE"];
		_unit addEventHandler ["HandleDamage", { _this call damage_manager_civilian }];
		_unit setVariable ['GRLIB_can_speak', true, true];
		_unit setVariable ["GRLIB_is_civilian", true, true];
	};

	_unit allowDamage false;
	_unit addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_unit setSkill 0.65;
	_unit allowFleeing 0;

	private _role = _vehicle_roles select _forEachIndex;
    if (_role == "driver") then {
        _unit assignAsDriver _vehicle;
        _unit moveInDriver _vehicle;
    };
    if (_role == "commander") then {
        _unit assignAsCommander _vehicle;
        _unit moveInCommander _vehicle;
    };
    if (_role == "gunner") then {
        _unit assignAsGunner _vehicle;
        _unit moveInGunner _vehicle;
    };
    // if (_role == "turret") then {
    //     _unit assignAsTurret _vehicle;
    //     _unit moveInTurret [_vehicle, [1]];
    // };
	sleep 0.1;
} forEach _vehicle_roles;

(crew _vehicle) joinSilent _grp;
(units _grp) allowGetIn true;
(units _grp) orderGetIn true;
(_grp) addVehicle _vehicle;

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
