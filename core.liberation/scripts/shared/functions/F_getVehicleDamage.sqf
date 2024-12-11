params ["_vehicle"];

private _vehicle_hitpoints = getAllHitPointsDamage _vehicle;
if (count _vehicle_hitpoints != 3) exitWith { damage _vehicle };
private _current_hitpoints = (_vehicle_hitpoints select 2);
if (count _current_hitpoints == 0) exitWith { damage _vehicle };

private _vehicle_damage = 0;
{ _vehicle_damage = _vehicle_damage + _x } forEach _current_hitpoints;
(_vehicle_damage / count _current_hitpoints);
