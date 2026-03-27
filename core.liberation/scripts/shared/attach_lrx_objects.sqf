params ["_vehicle", "_list"];
if (isNil "_list") exitWith {};
if (count _list == 0) exitWith {};

private ["_class", "_obj"];
{
    _class = _x;
    _obj = [_vehicle, _class] call attach_object_direct;
    if (_class == cargo_sling_typename && !isNull _obj) exitWith {
        [_list select 1] params [["_lst_lrx", []]];
        if (count _lst_lrx > 0) then { [_obj, _lst_lrx] call attach_lrx_objects };
    };
} forEach _list;
