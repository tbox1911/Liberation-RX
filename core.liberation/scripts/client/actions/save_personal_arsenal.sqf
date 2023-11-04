private _pos = GRLIB_personal_box getVariable ["GRLIB_personal_box_pos", (markerPos GRLIB_respawn_marker)];
if (GRLIB_personal_box distance2D _pos > 20) then {
	GRLIB_personal_box setPos _pos;
};

private _addItem = {
	params ["_item", "_list"];
	private _index = _list apply {_x select 0} find _item; 
	if (_index > -1) then {
		_old = _list select _index select 1; 
		(_list select _index) set [1, _old + 1];
	} else {
		_list append [[_item, 1]];
	};
	_list;
 };

// Build Arsenal list

private _new_arsenal = [];
// Weapons + Attachments
{
	_new_arsenal pushBack _x;
} foreach (weaponsItemsCargo GRLIB_personal_box);

// All Containers
private _containers = [];
{
	_new_arsenal pushBack [(_x select 0), [getItemCargo (_x select 1), getMagazineCargo (_x select 1)], 0];
	_containers pushBack (_x select 0);
} forEach (everyContainer GRLIB_personal_box);

// Items
private _item_cargo = getItemCargo GRLIB_personal_box;
private _indx = 0;
{
	if !(_x in _containers) then {
		_new_arsenal pushBack [_x, (_item_cargo select 1) select _indx];
	};
	_indx = _indx + 1;
} forEach (_item_cargo select 0);

// Magazines
private _mag_cargo = getMagazineCargo GRLIB_personal_box;
{
	_new_arsenal pushBack [_x, (_mag_cargo select 1) select (_forEachIndex - 1)];
} forEach (_mag_cargo select 0);

GRLIB_personal_arsenal = _new_arsenal;
profileNamespace setVariable ["GRLIB_personal_arsenal", GRLIB_personal_arsenal]; 
saveProfileNamespace;
