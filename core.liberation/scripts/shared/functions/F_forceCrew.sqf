params [
	"_vehicle",
	["_side", GRLIB_side_friendly],
	["_mission_ai", false]
];

if (count crew _vehicle > 0) exitWith { grpNull };

private _vehicle_class = typeOf _vehicle;
_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

// // Drone / UAV / Aircraft
if (_vehicle_class in uavs_vehicles + static_vehicles_AI || (_vehicle isKindOf "Air")) exitWith {
	private _grp = createGroup [_side, true];
	_side createVehicleCrew _vehicle;
	sleep 1;
	(crew _vehicle) joinSilent _grp;
	_grp;
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
if (count _vehicle_roles == 0) exitWith { diag_log format ["--- LRX Crew Can't find role for vehicle %1", _vehicle_class]; grpNull };

private _cfg = configFile >> "CfgVehicles" >> _vehicle_class;
private _pilot = getText (_cfg >> "crew");
private _cargo  = getArray (_cfg >> "typicalCargo");
private _others = getArray (_cfg >> "typicalTransportSoldier");
private _unit_class = [_pilot] + _cargo + _others;
_unit_class = _unit_class arrayIntersect _unit_class;

if (_side == GRLIB_side_civilian) then { _unit_class = civilians };
if (count _unit_class == 0) then {
	if (_side == GRLIB_side_enemy) then { _unit_class = [opfor_crew] };
	if (_side == GRLIB_side_friendly) then { _unit_class = [crewman_classname] };
};

private _path = "";
private _unit = objNull;
private _grp = createGroup [_side, true];
{
	_unit = _grp createUnit [(selectRandom _unit_class), _vehicle, [], 20, "NONE"];
	_unit allowDamage false;
	[_unit] joinSilent _grp;
	if (_mission_ai) then { _unit setVariable ["GRLIB_mission_AI", true, true] };
	_unit addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_unit setPitch 1;
	_unit setSkill 0.65;
	_unit allowFleeing 0;

	// Side
	switch (_side) do {
		case GRLIB_side_enemy: {
			_unit addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
			if (_vehicle_class in militia_vehicles) then {
				_path = format ["mod_template\%1\loadout\crewman.sqf", GRLIB_mod_east];
				[_path, _unit] call F_getTemplateFile;
				[_unit] spawn reammo_ai;
			};
		};
		case GRLIB_side_friendly: {
			if (GRLIB_force_english) then { _unit setSpeaker (format ["Male0%1ENG", round (1 + floor random 9)]) };
		};
		case GRLIB_side_civilian: {
			_unit addEventHandler ["HandleDamage", { _this call damage_manager_civilian }];
			_unit setVariable ['GRLIB_can_speak', true, true];
		};
	};

	// Roles
	private _role = _vehicle_roles select _forEachIndex;
	switch (_role) do {
		case "driver": {
			_unit assignAsDriver _vehicle;
			_unit moveInDriver _vehicle;
		};
		case "commander": {
			_unit assignAsCommander _vehicle;
			_unit moveInCommander _vehicle;
		};
		case "gunner": {
			_unit assignAsGunner _vehicle;
			_unit moveInGunner _vehicle;
		};
	};
	sleep 0.1;
} forEach _vehicle_roles;
sleep 1;

{ if (isNull objectParent _x) then {deleteVehicle _x} } forEach (units _grp);
(units _grp) allowGetIn true;
(units _grp) orderGetIn true;
_grp addVehicle _vehicle;

if (_side == GRLIB_side_civilian) then {
	_grp setCombatMode "BLUE";
	_grp setBehaviourStrong "CARELESS";
} else {
	_grp setCombatMode "WHITE";
	_grp setBehaviourStrong "AWARE";
};

sleep 1;
{ _x allowDamage true } forEach (units _grp);

_grp;
