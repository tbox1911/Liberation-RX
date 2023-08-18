params [
    "_spawnpos",                    // position to spawn
    ["_classname", []],             // array of classname to create
    ["_side", GRLIB_side_enemy],    // side of units group
    ["_type", "infantry"]           // type of unit
];

private _nb_unit = count _classname;
if (_nb_unit == 0) exitWith {diag_log ["--- LRX Error: no unit to create.", _this]; grpNull};

if (_type != "civilian") then {
	diag_log format [ "Spawn (%1) %2 Units (%3) at %4", _nb_unit, _type, _side, time ];
};

private _grp = createGroup [_side, true];
if (isNull _grp) exitWith { diag_log "--- LRX Error: cannot create group."; grpNull};

private ["_unit", "_validpos", "_max_try", "_backpack"];
{
	if ( (count units _grp) < _nb_unit) then {
		_validpos = zeropos;
		_max_try = 20;

        if (_type == "divers") then {
            _validpos = _spawnpos vectorAdd [floor(random 20), floor(random 20), -5];
        };

        if (_type == "para") then {
            _validpos = _spawnpos vectorAdd [floor(random 20), floor(random 20), 0];
        };

		private _range = GRLIB_capture_size;
		while { (_validpos isEqualTo zeropos) && _max_try > 0 } do {
			_validpos = [_spawnpos, 0, _range, 1, 0, 0, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
			_max_try = _max_try - 1;
			_range = _range + 5;
			sleep 1;
		};

		if (_validpos isEqualTo zeropos) then {
			diag_log format ["--- LRX Error: No place to build unit %1 at position %2", _x, _spawnpos];
		} else {
			_unit = _grp createUnit [_x, _validpos, [], 5, "NONE"];
			_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			[_unit] joinSilent _grp;
			if (_type in ["militia", "guard"]) then {[ _unit ] call loadout_militia};
			[_unit] call reammo_ai;
            _unit switchMove "AmovPercMwlkSrasWrflDf";
			_unit playMoveNow "AmovPercMwlkSrasWrflDf";
            sleep 0.1;			
		};

		if (!isNil "_unit") then {
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
				_unit setVariable ["GRLIB_mission_AI", true, true];
			};
		};
	};
	sleep 0.1;
} foreach _classname;

[_grp] call F_deleteWaypoints;
_grp;
