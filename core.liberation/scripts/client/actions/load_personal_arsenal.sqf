// Load Arsenal from user profile and fill the Arsenal box

private _addContainerCargo = {
	params ["_box", "_item"];
	private _old_content = everyContainer _box;
	if (_item isKindOf "Bag_Base") then {
		_box addBackpackCargo [_item, 1];
	} else {
		_box addItemCargo [_item, 1];
	};
	sleep 0.1;
	((everyContainer _box) - _old_content) select 0 select 1; 
};

{ 
	if (count _x == 2) then {
		GRLIB_personal_box addItemCargo [(_x select 0), (_x select 1)];
	};
	if (count _x == 3) then {
		private _class = (_x select 0);	
		private _container = [GRLIB_personal_box, _class] call _addContainerCargo;
		[_container] call F_clearCargo;
		private _items = (_x select 1) select 0;
		{
			_container addItemCargo [_x, (_items select 1) select (_forEachIndex - 1)];
		} forEach (_items select 0);
		private _mag = (_x select 1) select 1;
		{
			_container addItemCargo [_x, (_mag select 1) select (_forEachIndex - 1)];
		} forEach (_mag select 0);		
	};
	if (count _x == 7) then {
		GRLIB_personal_box addWeaponWithAttachmentsCargo [_x, 1];
	};
} forEach GRLIB_personal_arsenal;
