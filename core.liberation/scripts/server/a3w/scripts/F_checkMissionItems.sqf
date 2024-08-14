params ["_pos", "_typename", "_count"];

private _barrels = (_pos nearEntities [_typename, 20]) select {
    isNil {_x getVariable "R3F_LOG_objets_charges"} &&
    isNull attachedTo _x &&
    !(_x getVariable ['R3F_LOG_disabled', false])
};

if (count _barrels == _count) exitWith { sleep 1; { deleteVehicle _x } forEach _barrels; true };

false;
