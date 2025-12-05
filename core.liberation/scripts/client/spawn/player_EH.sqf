params ["_unit"];

// LRX unit Event Handlers

// General Event Handlers
_unit addEventHandler ["InventoryClosed", {
	params ["_unit", "_container"];
	[_unit] call F_filterLoadout;
	if (_unit == player) then {
		hintSilent format ["Inventory value:\n%1 AMMO.", ([_unit] call F_loadoutPrice)];
		if (GRLIB_filter_arsenal == 4 && _container == GRLIB_personal_box) then { [] spawn save_personal_arsenal };
	};
}];

_unit addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	_ret = false;
	playsound "ZoomIn";
	if (!alive _container) exitWith { _ret };
	if (!([_unit, _container] call is_owner) || locked _container > 1) then {
		closeDialog 106;
		_ret = true;
	};
	_ret;
}];

_unit addEventHandler ["WeaponAssembled", {
	params ["_unit", "_weapon"];
	if (typeOf _weapon in uavs_vehicles) then { [_weapon] spawn F_forceCrew };
}];

_unit addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];
	if !([_item] call is_allowed_item) then {
		_unit removeWeapon _item;
		_unit removeItem _item;
		_unit unlinkItem _item;
	};
}];

// Cannot DisAssemble
_unit enableWeaponDisassembly false;

// Player Event Handlers
if (_unit == player) then {
	// ACE specific
	if (GRLIB_ACE_enabled) then {
		["ace_arsenal_displayClosed", {
			[player] call F_filterLoadout;
			[player] spawn F_payLoadout;
		}] call CBA_fnc_addEventHandler;
	};

	// Backup Weapon state
	_unit removeAllEventHandlers "WeaponChanged";
	_unit addEventHandler ["WeaponChanged", {
		params ["_unit", "_oldWeapon", "_newWeapon", "_oldMode", "_newMode", "_oldMuzzle", "_newMuzzle", "_turretIndex"];
		if (isNull objectParent _unit) then {
			if (_newWeapon == primaryWeapon _unit) then {
				PAR_weapons_state = [_newWeapon, _newMuzzle, _newMode];
			};
		};
	}];

};
