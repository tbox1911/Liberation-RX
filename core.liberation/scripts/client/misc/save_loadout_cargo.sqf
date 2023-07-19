params ["_box", "_unit"];

// store player stuff in the box
// headgear
_box addItemCargo [(headgear _unit), 1];

// items
{_box addItemCargo [_x, 1]} forEach (assignedItems _unit - [binocular _unit]);

// uniform
if (uniform _unit != "") then {
	_box addItemCargo [(uniform _unit), 1];
	_uniform = (everyContainer _box) select (count everyContainer _box) - 1 select 1;
	{_uniform addItemCargo [_x, 1]} forEach (uniformItems _unit);
};

// vest
if (vest _unit != "") then {
	_box addItemCargo [(vest _unit), 1];
	_vest = (everyContainer _box) select (count everyContainer _box) - 1 select 1;
	{_vest addItemCargo [_x, 1]} forEach (vestItems _unit);
};

// weapons + attachment
{_box addWeaponWithAttachmentsCargo [_x, 1]} forEach weaponsItems _unit;
//{_box addItemCargo [_x, 1]} forEach (assignedItems _unit);

// backpack
if (backpack _unit != "") then {
	_box addBackpackCargo [(Backpack _unit), 1];
	_backpack = firstBackpack _box;
	clearItemCargo _backpack;
	clearWeaponCargo _backpack;
	clearMagazineCargo _backpack;
	clearItemCargo _backpack;
	{_backpack addItemCargo [_x, 1]} forEach (backpackItems _unit);
};

// Cleanup
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

private _msg = format [localize "STR_LOADOUT_CARGO_STORED", ([_box] call F_getLRXName)];
hintSilent _msg;
systemchat _msg;