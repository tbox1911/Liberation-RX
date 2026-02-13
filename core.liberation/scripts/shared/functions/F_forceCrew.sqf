params [
	"_vehicle",
	["_side", GRLIB_side_friendly],
	["_mission_ai", false],
	["_type", "infantry"]
];

if (count crew _vehicle > 0) exitWith { grpNull };

private _vehicle_class = typeOf _vehicle;
_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

private _grp =_side createVehicleCrew _vehicle;
sleep 0.1;
if (count (units _grp) == 0) exitWith { diag_log format ["--- LRX can't create crew for vehicle %1", _vehicle_class]; grpNull };

// Drone / UAV / Aircraft
if (_vehicle_class in (uavs_vehicles + static_vehicles_AI)) exitWith { _grp };

private ["_unit", "_path", "_loadout"];
{
	_unit = _x;
	_unit allowDamage false;
	if (_mission_ai) then { _unit setVariable ["GRLIB_mission_AI", true, true] };
	_unit addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
	_unit setPitch 1;
	_unit setSkill 0.65;
	_unit allowFleeing 0;

	// Side
	switch (_side) do {
		case GRLIB_side_enemy: {
			_unit addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
			if (_type == "militia") then {
				_path = format ["mod_template\%1\loadout\crewman.sqf", GRLIB_mod_east];
				[_path, _unit] call F_getTemplateFile;
				[_unit] spawn reammo_ai;
			};
			if (_type == "infantry") then {
				_loadout = getUnitLoadout opfor_crew;
				_unit setUnitLoadout _loadout;
			};
		};
		case GRLIB_side_friendly: {
			if (GRLIB_force_english) then { _unit setSpeaker (format ["Male0%1ENG", round (1 + floor random 9)]) };
			_loadout = getUnitLoadout crewman_classname;
			_unit setUnitLoadout _loadout;
		};
		case GRLIB_side_civilian: {
			_unit addEventHandler ["HandleDamage", { _this call damage_manager_civilian }];
			_unit setVariable ['GRLIB_can_speak', true, true];
			_loadout = getUnitLoadout (selectRandom civilians);
			_unit setUnitLoadout _loadout;
		};
	};
} forEach (units _grp);

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
