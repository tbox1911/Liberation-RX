params [
    "_spawnpos",                    // position to spawn
    ["_classname", []],             // array of classname to create
    ["_side", GRLIB_side_enemy],    // side of units group
    ["_type", "infantry"]           // type of unit
];

private ["_unit", "_nb_unit", "_validpos", "_max_try"];
if (count _classname == 0) exitWith {diag_log ["DBG: Error libunit ", _this]};

if (_type in ["divers", "para", "defender", "guard"]) then {
	_nb_unit = count _classname;
} else {
	_nb_unit = round ((count _classname) * ([] call F_adaptiveOpforFactor));
};

private _grp = createGroup [_side, true];
{
	if ( (count units _grp) < _nb_unit) then {
		_validpos = zeropos;
		_max_try = 10;
        
        if (_type == "divers") then {
            _validpos = _spawnpos vectorAdd [floor(random 20), floor(random 20), -4];
        };

        if (_type == "para") then {
            _validpos = _spawnpos vectorAdd [floor(random 20), floor(random 20), 0];
        };

		while { (_validpos isEqualTo zeropos) && _max_try > 0 } do {
			_validpos = [_spawnpos, 0, GRLIB_capture_size, 1, 0, 0, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
			_max_try = _max_try - 1;
		};

		if (!(_validpos isEqualTo zeropos)) then {
			_unit = _grp createUnit [_x, _validpos, [], 5, "NONE"];
			_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			[_unit] joinSilent _grp;
			if (_type == "para") then {_unit addBackpack "B_Parachute"};
			if (_type in ["militia", "guard"]) then {[ _unit ] call loadout_militia};
			[ _unit ] call reammo_ai;
            _unit switchMove "amovpknlmstpsraswrfldnon";
			_unit playMoveNow "amovpknlmstpsraswrfldnon"; 
            sleep 0.1;
		} else {
			diag_log format ["--- LRX Error: No place to build unit %1 at position %2", _x, _spawnpos];
		};
	};
	sleep 0.1;
} foreach _classname;

_grp;
