params ["_vehicle", "_ttl"];

_ttl = round (time + _ttl);
if (typeName _vehicle == "GROUP") exitWith {
    {
        _x setVariable ["GRLIB_counter_TTL", _ttl, true];
        _x setVariable ["GRLIB_battlegroup", true, true];
    } forEach (units _vehicle);
};

if (typeName _vehicle == "OBJECT") then {
    if (_vehicle isKindOf "AllVehicles") then {
        {
            _x setVariable ["GRLIB_counter_TTL", _ttl, true];
            _x setVariable ["GRLIB_battlegroup", true, true];
        } forEach (crew _vehicle);
    };
    _vehicle setVariable ["GRLIB_counter_TTL", _ttl, true];
    _vehicle setVariable ["GRLIB_battlegroup", true, true];    
};
