params ["_vehicle", "_preset"];

if (isNil "_preset") then { _preset = vehicle_preset_inventory };
if (count _preset == 0) exitWith {};

private _items = [];
{
    if (_vehicle isKindOf (_x select 0)) then { _items = (_x select 1) };
} forEach _preset;
if (count _items == 0) exitWith {};

private ["_item"];
{
	_item = _x;
	if (typeName _item == "ARRAY") then { _item = selectRandom _item };
	if (_item != "") then {
		if (_vehicle canAdd _item) then {
			switch (true) do {
				case (_item isKindOf "Bag_Base"): {
					_vehicle addBackpackCargoGlobal [_item, 1];
				};
				case (_item isKindOf "Weapon_Base_F"): {
					_vehicle addWeaponCargoGlobal [_item, 1];
				};
				case (_item isKindOf "Magazine"): {
					_vehicle addMagazineCargoGlobal [_item, 1];
				};
				default {
					_vehicle addItemCargoGlobal [_item, 1];
				};
			};
		};
	};
} forEach _items;
