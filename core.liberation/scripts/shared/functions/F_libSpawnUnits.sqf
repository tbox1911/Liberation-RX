params [
	"_spawnpos",                    // position to spawn
	["_classname", []],             // array of classname to create
	["_side", GRLIB_side_enemy],    // side of units group
	["_type", "infantry"]           // type of unit
];

private _nb_unit = count _classname;
if (_nb_unit == 0) exitWith {diag_log ["--- LRX Error: no unit to create.", _this]; grpNull};
//_nb_unit = _nb_unit min round (16 * ([] call F_adaptiveOpforFactor));

private _grp = createGroup [_side, true];
if (isNull _grp) exitWith { diag_log "--- LRX Error: cannot create group."; grpNull};

diag_log format [ "Spawn (%1) %2 Units (%3-%4) at %5", _nb_unit, _type, _side, _grp, time ];

private ["_unit", "_backpack", "_maxpos"];
{
	if ( (count units _grp) < _nb_unit) then {
		if (_type == "divers") then {
			_spawnpos = _spawnpos vectorAdd [floor(random 20), floor(random 20), -5];
		};

		if (_type == "para") then {
			_spawnpos = _spawnpos vectorAdd [floor(random 20), floor(random 20), 0];
		};

		_unit = _grp createUnit [_x, _spawnpos, [], 20, "NONE"];
		if (!isNil "_unit") then {
			_unit allowDamage false;
			_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			[_unit] joinSilent _grp;
			[_unit] spawn F_fixModUnit;
			if (_type == "militia") then {[_unit] call loadout_militia};
			[_unit] spawn reammo_ai;

			if (_type == "para") then {
				_backpack = backpack _unit;
				if ( _backpack != "" && _backpack != "B_Parachute" ) then {
					_unit setVariable ["GRLIB_para_backpack", _backpack];
					_unit setVariable ["GRLIB_para_backpack_contents", (backpackItems _unit)];
					removeBackpack _unit;
					sleep 0.1;
				};
				_unit addBackpack "B_Parachute";
			};

			if (_type == "defender") then {
				_unit setVariable ["PAR_Grp_ID", "server", true];
			};
		} else {
			diag_log format ["--- LRX Error: Cannot create unit %1 at position %2", _x, _spawnpos];
		};
		sleep 0.1;
	};
} foreach _classname;

_grp setCombatMode "WHITE";
_grp setCombatBehaviour "COMBAT";

[units _grp] spawn {
	params ["_units"];
	sleep 4;
	{
		if (isNull objectParent _x) then {
			_x switchMove "AmovPercMwlkSrasWrflDf";
			_x playMoveNow "AmovPercMwlkSrasWrflDf";
		};
		_x setDamage 0;
		_x allowDamage true;
	} foreach _units;
};

_grp;
