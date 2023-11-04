params ["_vehicle", ["_full", false]];

private _lst_a3 = [];

// Weapons + Attachments
{
	_lst_a3 pushBack _x;
} foreach (weaponsItemsCargo _vehicle);

// Magazines
private _mag_cargo = getMagazineCargo _vehicle;
private _indx = 0;
{
	_lst_a3 pushBack [_x, (_mag_cargo select 1) select _indx];
	_indx = _indx + 1;
} forEach (_mag_cargo select 0);

if (_full) then {
	// All Containers
	private _containers = [];
	{
		_lst_a3 pushBack [(_x select 0), [getItemCargo (_x select 1), getMagazineCargo (_x select 1)], 0];
		_containers pushBack (_x select 0);
	} forEach (everyContainer _vehicle);

	// Items
	private _item_cargo = getItemCargo _vehicle;
	private _indx = 0;
	{
		if !(_x in _containers) then {
			_lst_a3 pushBack [_x, (_item_cargo select 1) select _indx];
		};
		_indx = _indx + 1;
	} forEach (_item_cargo select 0);
};

_lst_a3;
