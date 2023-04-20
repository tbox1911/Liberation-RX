params ["_vehicle", "_lst_a3"];
private ["_items_list", "_magazine_list", "_last", "_containers"];

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
_vehicle setMaxLoad playerbox_cargospace;

{_vehicle addWeaponWithAttachmentsCargoGlobal [ _x, 1]} forEach (_lst_a3 select 0);

if ( (typeOf _vehicle) == playerbox_typename) then {
    _containers = [];
    {
        _name = _x select 0;
        _containers pushback _name;
        if (_name isKindOf "Bag_Base") then {
            _vehicle addBackpackCargoGlobal [_name, 1];
        } else {
            _vehicle addItemCargoGlobal [_name, 1];
        };
        _last = (everyContainer _vehicle) select (count everyContainer _vehicle) - 1 select 1;
        _items_list = _x select 1 select 0;
        if (!isNil "_items_list") then {
            {_last addItemCargoGlobal [_x, (_items_list select 1) select _forEachIndex]} forEach (_items_list select 0);
        };
        _magazine_list = _x select 1 select 1;
        if (!isNil "_magazine_list") then {
            {_last addItemCargoGlobal [_x, (_magazine_list select 1) select _forEachIndex]} forEach (_magazine_list select 0);
        };
    } foreach (_lst_a3 select 3);

    _items_list = (_lst_a3 select 1);
    {
        if (!(_x in _containers)) then { _vehicle addItemCargoGlobal [_x, (_items_list select 1) select _forEachIndex] };
    } forEach (_items_list select 0);

    _magazine_list = (_lst_a3 select 2);
    {_vehicle addMagazineCargoGlobal [_x, (_magazine_list select 1) select _forEachIndex] } forEach (_magazine_list select 0);
};
