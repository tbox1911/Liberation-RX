params [
	"_spawn_pos",                   // position to spawn
	["_classname", []],             // array of classname to create
	["_side", GRLIB_side_enemy],    // side of units group
	["_type", "infantry"],          // type of unit
	["_mission_ai", false]          // from side mission
];

if (count _classname == 0) exitWith { diag_log ["--- LRX Error: no unit to create.", _this]; grpNull };
if (isNil "_spawn_pos") exitWith { diag_log ["--- LRX Error: no position to create unit.", _this]; grpNull };
if (count _spawn_pos == 0) exitWith { diag_log ["--- LRX Error: no position to create unit.", _this]; grpNull };

private _grp = createGroup [_side, true];
if (isNull _grp) exitWith { diag_log "--- LRX Error: cannot create group."; grpNull };
_grp setCombatMode "WHITE";
_grp setBehaviourStrong "AWARE";

if ((_spawn_pos select 2) < 0) then { _spawn_pos set [2, 0.3] };
if (_type == "para") then {
	diag_log format ["Spawn (%1) %2 Units (%3-%4)", count _classname, _type, _side, _grp];
} else {
	diag_log format ["Spawn (%1) %2 Units (%3-%4) Pos %5", count _classname, _type, _side, _grp, _spawn_pos];
};

// ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"];
private _rank_range = [0, 6];
switch (_type) do {
	case "militia"  : { _rank_range = [0, 3] };
	case "cargo"    : { _rank_range = [2, 4] };
	case "infantry" : { _rank_range = [4, 6] };
	case "building" : { _rank_range = [3, 5] };
	case "para"     : { _rank_range = [4, 6] };
	case "guards"   : { _rank_range = [4, 5] };
	case "bandits"  : { _rank_range = [5, 5] };
	case "defender" : { _rank_range = [4, 5] };
};

private ["_unit", "_rank_unit", "_pos", "_backpack"];
{
	_unit = _grp createUnit [_x, _spawn_pos, [], 15, "NONE"];
	if (!isNil "_unit") then {
		_unit allowDamage false;
		[_unit] joinSilent _grp;
		if (_mission_ai) then {
			_unit setVariable ["GRLIB_mission_AI", true, true];
			_unit setVariable ["ace_sys_wounds_uncon", false];
			_unit setVariable ["acex_headless_blacklist", true, true];
			_unit setSkill ["courage", 1];
			_unit allowFleeing 0;
		};
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

		_pos = getPos _unit;
		if (_type == "divers") then {
			_pos set [2, -6];
			_unit setPosASL _pos;
		};

		// diag_log format ["DBG: Create unit %1 at position %2", _unit, _pos];
		[_unit] call F_fixModUnit;
		if (_type == "militia") then { [_unit] spawn loadout_militia };
		if (_type == "building") then { _unit setVariable ["GRLIB_in_building", true, true] };
		if (_type == "bandits") then {
			[_unit] spawn loadout_militia;
			_unit addMPEventHandler ["MPKilled", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				if (side group _killer != GRLIB_side_friendly || !(isNull objectParent _killer)) exitWith {};
				if (floor random 3 == 0) then { money_typename createVehicle getPos _unit };
			}];
		};
		if (_type == "guards" && _forEachIndex % 4 == 0) then {
			removeBackpack _unit;
			_unit addWeapon "launch_MRAWS_green_F";
			_unit addSecondaryWeaponItem "MRAWS_HEAT_F";
			_unit addBackpack "B_AssaultPack_blk";
			for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HEAT_F"};
		};

		if (_type == "cargo") then {
			_unit setSkill ["courage", 1];
			_unit allowFleeing 0;
		};

		[_unit] spawn reammo_ai;
		_rank_range params ["_rank_min", "_rank_max"];
		_rank_unit = GRLIB_rank_level select (_rank_min + floor random (_rank_max - _rank_min + 1));
		_unit setUnitRank _rank_unit;
		[_unit, _rank_unit] spawn F_setUnitSkill;

		if (_type == "para") then {
			_unit setSkill ["courage", 1];
			_unit allowFleeing 0;
			_backpack = backpack _unit;
			if (_backpack != "" && !(_backpack isKindOf "B_Parachute")) then {
				_unit setVariable ["GRLIB_para_backpack", _backpack];
				_unit setVariable ["GRLIB_para_backpack_contents", (backpackItems _unit)];
				removeBackpack _unit;
				sleep 0.1;
			};
			_unit addBackpack "B_Parachute";
		};
	} else {
		diag_log format ["--- LRX Error: Cannot create unit %1 at position %2", _x, _pos];
	};
	sleep 0.1;
} foreach _classname;

private _units = units _grp;
if (count _units == 0) exitWith { diag_log "--- LRX Error: created group is empty."; grpNull };

[_type, _units] spawn {
	params ["_type", "_units"];
	sleep 5;
	{
		_x allowDamage true;
		if (_type in ["militia", "infantry"]) then { [_x] spawn F_fixPosUnit };
		sleep 0.1;
	} forEach _units;
};

_grp;
