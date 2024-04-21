// store unit stuff in the box

params ["_box", "_unit"];

// weapons + attachment
{_box addWeaponWithAttachmentsCargoGlobal [_x, 1]} forEach weaponsItems _unit;
//{_box addItemCargoGlobal [_x, 1]} forEach (assignedItems _unit);

// headgear
_box addItemCargoGlobal [(headgear _unit), 1];

// hmd
_box addItemCargoGlobal [(hmd _unit), 1];

// items
//{_box addItemCargoGlobal [_x, 1]} forEach (assignedItems _unit - [binocular _unit]);

// uniform
if (uniform _unit != "" && isPlayer _unit) then {
	private _uniform = [_box, (uniform _unit)] call F_addContainerCargo;
	[_uniform] call F_clearCargo;
	{_uniform addItemCargoGlobal [_x, 1]} forEach (uniformItems _unit);
	removeUniform _unit;
};

// vest
if (vest _unit != "") then {
	private _vest = [_box, (vest _unit)] call F_addContainerCargo;
	[_vest] call F_clearCargo;
	{_vest addItemCargoGlobal [_x, 1]} forEach (vestItems _unit);
	removeVest _unit;
};

// backpack
if (backpack _unit != "") then {
	private _backpack = [_box, (backpack _unit)] call F_addContainerCargo;
	[_backpack] call F_clearCargo;
	{_backpack addItemCargoGlobal [_x, 1]} forEach (backpackItems _unit);
	removeBackpackGlobal _unit;
};

// Cleanup
removeAllWeapons _unit; 
removeAllAssignedItems _unit; 
removeHeadgear _unit; 
removeGoggles _unit;

private _msg = format [localize "STR_LOADOUT_CARGO_STORED", name _unit, ([_box] call F_getLRXName)];
hintSilent _msg;
systemchat _msg;
