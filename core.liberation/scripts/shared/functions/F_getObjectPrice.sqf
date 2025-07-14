params ["_class", ["_list", []]];

if (count _list == 0) then {
    _list = GRLIB_recycleable_info;
};

private _ret = _list select { (_x select 0) == _class } select 0 select 2;
if (isNil "_ret") then { _ret = 1 };
_ret;
