if (!isServer && hasInterface) exitWith {};
params ["_pos", "_type"];
[_pos, ([] call getNbUnits), _type] call createCustomGroup;
