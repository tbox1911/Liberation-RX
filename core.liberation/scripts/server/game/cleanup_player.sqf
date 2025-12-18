params ["_unit", "_uid"];

if (isNull _unit) exitWith {};

private _name = name _unit;

diag_log format ["--- LRX Cleanup player %1 (%2)", _name, _uid];

// Remove Dog
private _my_dog = _unit getVariable ["my_dog", nil];
if (!isNil "_my_dog") then { deleteVehicle _my_dog };

// PAR remove Grave Box
private _grave_box = _unit getVariable ["PAR_grave_box", nil];
if (!isNil "_grave_box") then { deleteVehicle _grave_box };

// Delete Body
removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

private _text = format ["Bye bye %1, see you soon...", _name];
[gamelogic, _text] remoteExec ["globalChat", -2];
