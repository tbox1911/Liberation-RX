params ["_unit"];
if (isNil "_unit") exitWith {0};

private _score = 0;
if ( isMultiplayer ) then {
	_score = score _unit;
} else {
	_score = _unit getVariable ["GREUH_score_count", 0];
};

_score;