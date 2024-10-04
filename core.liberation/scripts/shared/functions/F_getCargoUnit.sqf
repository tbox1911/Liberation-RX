params ["_unit"];

private _lst_a3 = [];

// weapons + attachment
{_lst_a3 pushBack _x} forEach (weaponsItems _unit);
//{_lst_a3 addItemCargoGlobal [_x, 1]} forEach (assignedItems _unit);

// headgear
_lst_a3 pushBack [(headgear _unit), 1];

// hmd
_lst_a3 pushBack [(hmd _unit), 1];

// goggles 
_lst_a3 pushBack [(goggles _unit), 1];

// items
//{_lst_a3 pushBack [_x, 1]} forEach (assignedItems _unit - [binocular _unit]);

// uniform
if (uniform _unit != "") then {
	_lst_a3 pushBack [uniform _unit, [getItemCargo (uniformContainer _unit), getMagazineCargo (uniformContainer _unit)], 0];
};

// vest
if (vest _unit != "") then {
	_lst_a3 pushBack [vest _unit, [getItemCargo (vestContainer _unit), getMagazineCargo (vestContainer _unit)], 0];
};

// backpack
if (backpack _unit != "") then {
	_lst_a3 pushBack [backpack _unit, [getItemCargo (backpackContainer _unit), getMagazineCargo (backpackContainer _unit)], 0];
};

_lst_a3;
