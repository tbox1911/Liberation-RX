// make local units aware of other (remote) friendly units around them
sleep 120;

private ["_local_units", "_remote_units"];
private _radius = 3000;
private _vehicle_only = false;

while { true } do {
    if (_vehicle_only) then {
        _local_units = [units GRLIB_side_friendly, { (local _x) && (alive _x) && !(isNull objectParent _x)}] call BIS_fnc_conditionalSelect;
        _remote_units = [units GRLIB_side_friendly, { !(local _x) && (alive _x) && !(isNull objectParent _x)}] call BIS_fnc_conditionalSelect;
    } else {
        _local_units = [units GRLIB_side_friendly, { (local _x) && (alive _x)}] call BIS_fnc_conditionalSelect;
        _remote_units = [units GRLIB_side_friendly, { !(local _x) && (alive _x)}] call BIS_fnc_conditionalSelect;
    };

    //diag_log format ["DBG: L:%1 R:%2", count _local_units, count _remote_units];
    if (count _local_units > 0 && count _remote_units > 0) then {
        {
            _unit = _x;
            {
                if (_unit distance2D _x < _radius && _unit knowsAbout _x < 2) then {
                    _unit reveal [_x, 4];
                };
            } forEach _remote_units;
        } forEach _local_units;
    };
    sleep 60;
};
