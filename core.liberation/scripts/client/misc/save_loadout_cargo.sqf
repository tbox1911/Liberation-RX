params ["_box", "_unit"];

// store player stuff in the box

private _addContainerCargo = {
	params ["_box", "_item"];
	private _old_content = everyContainer _box;
	if (_item isKindOf "Bag_Base") then {
		_box addBackpackCargoGlobal [_item, 1];
	} else {
		_box addItemCargoGlobal [_item, 1];
	};
	sleep 0.1;
	((everyContainer _box) - _old_content) select 0 select 1; 
};

// headgear
_box addItemCargoGlobal [(headgear _unit), 1];

// hmd
_box addItemCargoGlobal [(hmd _unit), 1];

// items
//{_box addItemCargoGlobal [_x, 1]} forEach (assignedItems _unit - [binocular _unit]);

// uniform
if (uniform _unit != "" && isPlayer _unit) then {
	private _uniform = [_box, (uniform _unit)] call _addContainerCargo;
	{_uniform addItemCargoGlobal [_x, 1]} forEach (uniformItems _unit);
	removeUniform _unit;
};

// vest
if (vest _unit != "") then {
	private _vest = [_box, (vest _unit)] call _addContainerCargo;
	{_vest addItemCargoGlobal [_x, 1]} forEach (vestItems _unit);
	removeVest _unit;
};

// weapons + attachment
{_box addWeaponWithAttachmentsCargo [_x, 1]} forEach weaponsItems _unit;
//{_box addItemCargoGlobal [_x, 1]} forEach (assignedItems _unit);

// backpack
if (backpack _unit != "") then {
	private _backpack = [_box, (backpack _unit)] call _addContainerCargo;
	clearItemCargo _backpack;
	clearWeaponCargo _backpack;
	clearMagazineCargo _backpack;
	{_backpack addItemCargoGlobal [_x, 1]} forEach (backpackItems _unit);
	removeBackpackGlobal _unit;
};

// Cleanup
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeHeadgear _unit;
removeGoggles _unit;

private _msg = format [localize "STR_LOADOUT_CARGO_STORED", name _unit, ([_box] call F_getLRXName)];
hintSilent _msg;
systemchat _msg;
