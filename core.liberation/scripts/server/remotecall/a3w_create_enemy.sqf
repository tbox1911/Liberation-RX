params ["_pos", "_type"];

if (!isServer) exitWith {};
if (isNil "_pos") exitWith {};

private _nbUnits = [] call getNbUnits;
private _aiGroup = createGroup [GRLIB_side_enemy, true];
[_aiGroup, _pos, _nbUnits, _type] call createCustomGroup;