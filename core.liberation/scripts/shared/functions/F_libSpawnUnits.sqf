params [
	"_spawn_pos",                   // position to spawn
	["_classname", []],             // array of classname to create
	["_side", GRLIB_side_enemy],    // side of units group
	["_type", "infantry"],          // type of unit
	["_mission_ai", false]          // from side mission
];

if (count _classname == 0) exitWith { diag_log ["--- LRX Error: no unit to create.", _this]; grpNull };

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

private _max_rank = 1;
switch (_type) do {
	case "militia" : { _max_rank = 2 };
	case "cargo" : { _max_rank = 3 };
	case "infantry" : { _max_rank = 3 };
	case "building" : { _max_rank = 3 };
	case "para" : { _max_rank = 4 };
	case "guards" : { _max_rank = 4 };
	case "bandits" : { _max_rank = 4 };
};

private ["_unit", "_ai_rank", "_pos", "_backpack"];
{
	_pos = _spawn_pos getPos [(2 + floor random 20), floor random 360];
	_unit = _grp createUnit [_x, _pos, [], 10, "NONE"];
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
		_unit setPitch 1;
		_ai_rank = selectRandom (GRLIB_rank_level select [0, _max_rank]);
		_unit setUnitRank _ai_rank;
		_unit setSkill (0.5 + (GRLIB_rank_level find _ai_rank) * 0.05);

		if (_type == "divers") then {
			_pos set [2, -6];
			_unit setPosASL _pos;
		};

		// diag_log format ["DBG: Create unit %1 at position %2", _unit, _pos];
		[_unit] call F_fixModUnit;
		if (_type == "militia") then { [_unit] call loadout_militia };
		if (_type == "building") then { _unit setVariable ["GRLIB_in_building", true, true] };
		if (_type == "bandits") then {
			[_unit] call loadout_militia;
			_unit addMPEventHandler ["MPKilled", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];
				if (side group _killer != GRLIB_side_friendly || !(isNull objectParent _killer)) exitWith {};
				if (floor random 3 == 0) then { money_typename createVehicle getPos _unit };
			}];
		};
		if (_type == "guards" && _forEachIndex % 4 == 0) then {
			removeBackpack _unit;
			_unit addBackpack "B_AssaultPack_blk";
			_unit addWeapon "launch_MRAWS_green_F";
		};

		[_unit] spawn reammo_ai;

		if (_type == "para") then {
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

[_units, _type] spawn {
	params ["_units", "_type"];
	sleep 1;
	{
		_unit = _x;
		if (_type in ["militia", "infantry"]) then {
			[_unit] call F_fixPosUnit;
			_unit switchMove "AmovPercMwlkSnonWnonDf";
			_unit playMoveNow "AmovPercMwlkSnonWnonDf";
		};
		sleep 0.1;
	} forEach _units;
	sleep 3;
	{ _x allowDamage true } forEach _units;
};

_grp;
