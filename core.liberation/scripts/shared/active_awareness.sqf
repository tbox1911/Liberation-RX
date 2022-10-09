// make local units aware of other (remote) friendly units around them
if (isDedicated) exitWith {};
sleep 300;

private ["_local_units", "_remote_units"];
private _radius = 3000;

while { true } do {
    _local_units = [allUnits, { (local _x) && (alive _x) && side _x == GRLIB_side_friendly}] call BIS_fnc_conditionalSelect;
    _remote_units =  [allUnits, { !(local _x) && (alive _x) && side _x == GRLIB_side_friendly}] call BIS_fnc_conditionalSelect;
    if (count _local_units > 0 && count _remote_units > 0) then {
        {
            _unit = _x;
            {
                if (_unit distance2D _x < _radius && _unit knowsAbout _x < 2) then {
                    _unit reveal [_x, 4];
                };
                //  else {
                //     _unit forgetTarget _x;
                // };
            } forEach _remote_units;
        } forEach _local_units;
    };
    sleep 60;
};
