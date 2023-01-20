params ["_vehicle"];

private _container = [];
private _lst_a3 = [weaponsItemsCargo _vehicle];

if ( (typeOf _vehicle) == playerbox_typename) then {
    {
		_container pushBack [_x select 0, [getItemCargo (_x select 1), getMagazineCargo (_x select 1)]];
	} forEach (everyContainer _vehicle);

    _lst_a3 = _lst_a3 + [getItemCargo _vehicle, getMagazineCargo _vehicle, _container];
};

_lst_a3;
