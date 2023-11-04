if (!isServer && hasInterface) exitWith {};
params ["_vehicle"];

_vehicle setMaxLoad 30000;
_vehicle hideObjectGlobal true;
