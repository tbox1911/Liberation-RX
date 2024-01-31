params ["_vehicle"];

_vehicle_hitpoints = getAllHitPointsDamage _vehicle;
_vehicle_damage = 0;
if (count _vehicle_hitpoints == 3) then {
    { _vehicle_damage = _vehicle_damage + _x } forEach (_vehicle_hitpoints select 2);
};
(_vehicle_damage >= 0.2 || damage _vehicle >= 0.2);
