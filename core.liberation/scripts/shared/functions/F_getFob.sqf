params [[ "_source_position", (getPos player)]];

private _fob = (_source_position nearObjects [FOB_typename, 20] select 0);

if (isNil "_fob") then {
    _fob = (_source_position nearObjects [FOB_outpost, 20] select 0);
};

if (isNil "_fob") then {
    _fob = objNull;
};

_fob;