params [
	"_spawnpos",                    // position to spawn
	["_classname", []],             // array of classname to create
	["_side", GRLIB_side_enemy],    // side of units group
	["_type", "infantry"],          // type of unit
	["_onground", true]				// unit on ground
];

private _nb_unit = count _classname;
if (_nb_unit == 0) exitWith {diag_log ["--- LRX Error: no unit to create.", _this]; grpNull};
_nb_unit = _nb_unit min round (16 * ([] call F_adaptiveOpforFactor));

diag_log format [ "Spawn (%1) %2 Units (%3) at %4", _nb_unit, _type, _side, time ];

private _grp = createGroup [_side, true];
if (isNull _grp) exitWith { diag_log "--- LRX Error: cannot create group."; grpNull};

private ["_unit", "_backpack"];
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
			if (_type in ["militia", "guard"]) then {[ _unit ] call loadout_militia};
			[_unit] call reammo_ai;
			_unit switchMove "AmovPercMwlkSrasWrflDf";
			_unit playMoveNow "AmovPercMwlkSrasWrflDf";

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

			if (_onground && !(_type in ["divers", "para"]) ) then {
				// try to fix pos on rock/object (thanks Larrow)
				_spawnpos = getPosATL _unit;
				_start = +_spawnpos;
				_start set [2, 80];
				while { (lineIntersects [ATLToASL _start, ATLToASL _spawnpos]) } do {
					_spawnpos set [2, ((_spawnpos select 2) + 0.25)]
				};
				_unit setPosATL _spawnpos;
			};
		} else {
			diag_log format ["--- LRX Error: Cannot create unit %1 at position %2", _x, _spawnpos];
		};
	};
} foreach _classname;

[_grp] spawn {
	params ["_grp"];
	_grp setCombatMode "WHITE";
	_grp setCombatBehaviour "COMBAT";
	sleep 3;
	{
		_x setDamage 0;
		_x allowDamage true;
	} foreach (units _grp);
};

_grp;
