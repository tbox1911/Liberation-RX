params ["_target", "_caller", "_actionId", "_arguments"];
if (isNil "_target") exitWith {};

private _radius = 30;
{
	// All items
	private _items = (itemCargo _x);

	// Containers
	{
		private _src_name = (_x select 0);
		private _src_obj = (_x select 1);
		private _container = [_target, _src_name] call F_addContainerCargo;
		[_container] call F_clearCargo;
		{_container addItemCargoGlobal [_x, 1]} forEach (ItemCargo _src_obj + magazineCargo _src_obj + weaponCargo _src_obj);
		_items = _items - [_src_name];
	} forEach (everyContainer _x);

	// Items
	{ _target addItemCargoGlobal [_x, 1] } forEach _items;

	// Weapons
	{_target addWeaponWithAttachmentsCargoGlobal [_x, 1]} forEach (weaponsItems _x);

	// Magazine
	{ _target addMagazineCargoGlobal [_x, 1] } forEach (magazineCargo _x);

	deleteVehicle _x;

	// dead body
	private _body = ((getPos _x) nearEntities ["CAManBase", 2]) select { !alive _x };
	if (count _body > 0) then {
		[(_body select 0)] spawn {
			params ["_body"];
			hidebody _body;
			sleep 5;
			deleteVehicle _body;
		};
	};
	sleep 0.1;
} forEach (nearestObjects [_target, ["GroundWeaponHolder", "WeaponHolderSimulated"], _radius]);
