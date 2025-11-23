params ["_vehicle", ["_force", false]];

if !(_vehicle isKindOf "LandVehicle" || _vehicle isKindOf "StaticWeapon") exitWith {};
if (round (speed vehicle _vehicle) > 0) exitWith {};
if (surfaceIsWater (getPos _vehicle)) exitWith {};
if !(isNull (_vehicle getVariable ["R3F_LOG_est_transporte_par", objNull])) exitWith {};

private _state = isDamageAllowed _vehicle;

if (vectorUp _vehicle select 2 < 0.60) then {
    _vehicle allowDamage false;
    _vehicle setpos [(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, 0.5];
    _vehicle setVectorUp surfaceNormal position _vehicle;
    sleep 2;
    _vehicle allowDamage _state;
};

if (getPosATL _vehicle select 2 < -0.50 || _force) then {
    _vehicle allowDamage false;
    private _pos = (getpos _vehicle);
    if (_force) then {
        _pos = (_pos vectorAdd [([[-5,0,5], 0] call F_getRND), ([[-5,0,5], 0] call F_getRND), 0.5]);
    };
    _vehicle setpos _pos;
    sleep 2;
    _vehicle allowDamage _state;
};
