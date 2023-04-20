if (!isServer) exitWith {};
params ["_unit", "_score"];
if (isNil "_unit") exitWith {};

if ( isMultiplayer ) then {
	_unit addScore _score;
} else {
	private _oldscore = _unit getVariable ["GREUH_score_count", 0];
	_unit setVariable ["GREUH_score_count", (_oldscore + _score), true];
};