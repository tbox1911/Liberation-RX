params ["_vehicle", ["_force", false]];

if (!local _vehicle) exitWith { [_vehicle, _force] remoteExec ["vehicle_unflip_remote_call", 2] };
if !(_vehicle isKindOf "LandVehicle" || _vehicle isKindOf "StaticWeapon") exitWith {};
if (round (speed vehicle _vehicle) > 0) exitWith {};
if (surfaceIsWater (getPos _vehicle)) exitWith {};
if !(isNull (_vehicle getVariable ["R3F_LOG_est_transporte_par", objNull])) exitWith {};


if (vectorUp _vehicle select 2 < 0.60) then {
    _vehicle allowDamage false;
    _vehicle setpos [(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, 0.5];
    _vehicle setVectorUp surfaceNormal position _vehicle;
    sleep 2;
    _vehicle allowDamage true;
};

if (getPosATL _vehicle select 2 < -0.50 || _force) then {
    _vehicle allowDamage false;
    { _x allowDamage false } forEach (crew _vehicle);
    private _pos = (getpos _vehicle);
    if (_force) then {
        _pos = ([_pos, 2] call F_getRandomPos);
        //_pos = (_pos vectorAdd [([[-5,0,5], 0] call F_getRND), ([[-5,0,5], 0] call F_getRND), 0.5]);
    };
    _vehicle setpos _pos;
    sleep 3;
    _vehicle allowDamage true;
    { _x allowDamage true } forEach (crew _vehicle);
};
