params [ "_unit" ];

// Filters disabled 
if (GRLIB_filter_arsenal == 0) exitWith {};

if !([handgunWeapon _unit] call is_allowed_item) then {_unit removeWeapon (handgunWeapon _unit)};
if !([primaryWeapon _unit] call is_allowed_item) then {_unit removeWeapon (primaryWeapon _unit)};
if !([secondaryWeapon _unit] call is_allowed_item) then {_unit removeWeapon (secondaryWeapon _unit)};
if !([uniform _unit] call is_allowed_item) then {removeUniform _unit};
if !([vest _unit] call is_allowed_item) then {removeVest _unit};
if !([headgear _unit] call is_allowed_item) then {removeHeadgear _unit};
if !([backpack _unit] call is_allowed_item) then {removeBackpack _unit};
if !([binocular _unit] call is_allowed_item) then {_unit removeWeapon (binocular _unit)};
if !([hmd _unit] call is_allowed_item) then {_unit unlinkItem (hmd _unit)};
{ if !([_x] call is_allowed_item) then {_unit unlinkItem _x} } forEach assignedItems _unit;
{ if !([_x] call is_allowed_item) then {_unit removePrimaryWeaponItem _x} } forEach primaryWeaponItems _unit;
{ if !([_x] call is_allowed_item) then {_unit removeItem _x} } forEach ((vestItems _unit)+(uniformItems _unit)+(backpackItems _unit)+(items _unit));

[_unit] call F_correctLaserBatteries;
[_unit] call F_correctHEGL;
