// Taken from: Grumpy Old Man
// (https://forums.bohemia.net/forums/topic/216673-quick-stringreplace/?do=findComment&comment=3290725)
// _result = ["xxx is awesome, I love xxx!", "xxx", "Arma"] call F_replaceWith;

params ["_string","_find","_replaceWith"];

private _pos = (_string find _find);
if (_pos isEqualTo -1) exitWith {_string};
[[(_string select [0,_pos]),_replaceWith,_string select [_pos + count _find,count _string]] joinString "",_find,_replaceWith] call F_replaceWith;
