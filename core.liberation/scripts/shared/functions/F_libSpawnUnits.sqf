params [
	"_spawnpos",                    // position to spawn
	["_classname", []],             // array of classname to create
	["_side", GRLIB_side_enemy],    // side of units group
	["_type", "infantry"]           // type of unit
];

if (count _classname == 0) exitWith { diag_log ["--- LRX Error: no unit to create.", _this]; grpNull };

private _grp = createGroup [_side, true];
if (isNull _grp) exitWith { diag_log "--- LRX Error: cannot create group."; grpNull };
_grp setCombatMode "WHITE";
_grp setCombatBehaviour "COMBAT";

if (_type == "divers") then {
	_spawnpos set [2, -5];
} else {
	_spawnpos set [2, 0.5];
};

diag_log format ["Spawn (%1) %2 Units (%3-%4) Pos %5", count _classname, _type, _side, _grp, _spawnpos];

// if (_type == "para") then {
// 	_spawnpos = _spawnpos vectorAdd [floor(random 20), floor(random 20), 0];
// };

private ["_unit", "_backpack", "_maxpos"];
{
	_unit = _grp createUnit [_x, _spawnpos, [], 30, "NONE"];
	sleep 0.1;
	if (!isNil "_unit") then {
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
	sleep 0.2;
} foreach _classname;

_grp;
