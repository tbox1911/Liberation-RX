if (!isServer && hasInterface) exitWith {};
params ["_unit", "_vehicle"];

_vehicle setHitPointDamage ["HitHull", 1];
_vehicle setDamage [1, true, _unit];
