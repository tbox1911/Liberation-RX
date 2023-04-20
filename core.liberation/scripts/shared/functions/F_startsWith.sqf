/*
	Parameters:
	_this select 0: String or Array - string(s) to search for
	_this select 1: String - string to check in
	_this select 2: Boolean - case sensitive search (optional, default: false)

	Returns: Boolean - test result
	thx: AgentRev, Killzone_Kid
*/

params [
	["_needles", []],
	["_haystack", ""],
	["_caseSensitive", false]
];
private _found = false;

if (typeName _needles != "ARRAY") then { _needles = [_needles] };

if (_caseSensitive) then {
	{
		if (_x != "" && _x isEqualTo (_haystack select [0, count _x])) exitWith { _found = true };
	} forEach _needles;
} else {
	{
		if (_x != "" && _x == (_haystack select [0, count _x])) exitWith { _found = true };
	} forEach _needles;
};

_found
