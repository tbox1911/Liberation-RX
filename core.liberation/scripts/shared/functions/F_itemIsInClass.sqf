params ["_item", "_list"];
private _ret = false;
{ if (_item isKindOf _x) then { _ret = true } } forEach _list;
_ret;