params [ "_unit" ];

// Filters disabled 
if (GRLIB_filter_arsenal == 0) exitWith {};

private _checkKickItem = { !([_this select 0] call is_allowed_item) };

if ([handgunWeapon _unit] call _checkKickItem) then {_unit removeWeapon (handgunWeapon _unit)};
if ([primaryWeapon _unit] call _checkKickItem) then {_unit removeWeapon (primaryWeapon _unit)};
if ([secondaryWeapon _unit] call _checkKickItem) then {_unit removeWeapon (secondaryWeapon _unit)};
if ([uniform _unit] call _checkKickItem) then {removeUniform _unit};
if ([vest _unit] call _checkKickItem) then {removeVest _unit};
if ([headgear _unit] call _checkKickItem) then {removeHeadgear _unit};
if ([binocular _unit] call _checkKickItem) then {_unit removeWeapon (binocular _unit)};
if ([hmd _unit] call _checkKickItem) then {_unit unassignItem (hmd _unit); _unit removeItem (hmd _unit)};
{ if ([_x] call _checkKickItem) then {_unit removePrimaryWeaponItem _x} } forEach primaryWeaponItems _unit;
{ if ([_x] call _checkKickItem) then {_unit removeItem _x} } forEach ((vestItems _unit)+(uniformItems _unit)+(backpackItems _unit)+(items _unit));

private _backpack = [backpack _unit];
if (_backpack != mobile_respawn_bag && isNil (_backpack getVariable ["GRLIB_mobile_respawn_bag", nil])) then {
	if (_backpack call _checkKickItem) then {removeBackpack _unit};
};

[_unit] call F_correctLaserBatteries;
[_unit] call F_correctHEGL;