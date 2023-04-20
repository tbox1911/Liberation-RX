params [ "_unit" ];

if (!GRLIB_limited_arsenal) exitWith {};

private _checkItem = {
    params ["_item"];
    private _ret = true;
    if ( [GRLIB_MOD_signature, _item] call F_startsWith || (_item in GRLIB_whitelisted_from_arsenal)) then { _ret = false };
    _ret;
};

{
    private _item = _x;
    if (_item in ([handgunWeapon _unit])) then {_unit removeWeapon _item};
    if (_item in ([primaryWeapon _unit])) then {_unit removeWeapon _item};
    if (_item in ([secondaryWeapon _unit])) then {_unit removeWeapon _item};
    if (_item in ([uniform _unit])) then {removeUniform _unit};
    if (_item in ([vest _unit])) then {removeVest _unit};
    if (_item in ([headgear _unit])) then {removeHeadgear _unit};
    if (_item in ([backpack _unit])) then {removeBackpack _unit};
    if (_item in ([binocular _unit])) then {_unit removeWeapon _item};
    if (_item in ([hmd _unit])) then {_unit unassignItem _item; _unit removeItem  _item};
    if (_item in (primaryWeaponItems _unit)) then {_unit removePrimaryWeaponItem _item};
    { if (_x == _item) then {_unit removeItem _item} } forEach ((vestItems _unit)+(uniformItems _unit)+(backpackItems _unit)+(items _unit));
} forEach GRLIB_blacklisted_from_arsenal;

if (!isNil "GRLIB_MOD_signature") then {
    if ([handgunWeapon _unit] call _checkItem) then {_unit removeWeapon (handgunWeapon _unit)};
    if ([primaryWeapon _unit] call _checkItem) then {_unit removeWeapon (primaryWeapon _unit)};
    if ([secondaryWeapon _unit] call _checkItem) then {_unit removeWeapon (secondaryWeapon _unit)};
    if ([uniform _unit] call _checkItem) then {removeUniform _unit};
    if ([vest _unit] call _checkItem) then {removeVest _unit};
    if ([headgear _unit] call _checkItem) then {removeHeadgear _unit};
    if ([backpack _unit] call _checkItem) then {removeBackpack _unit};
    if ([binocular _unit] call _checkItem) then {_unit removeWeapon (binocular _unit)};
    if ([hmd _unit] call _checkItem) then {_unit unassignItem (hmd _unit); _unit removeItem (hmd _unit)};
    { if ([_x] call _checkItem) then {_unit removePrimaryWeaponItem _x} } forEach primaryWeaponItems _unit;
    { if ([_x] call _checkItem) then {_unit removeItem _x} } forEach ((vestItems _unit)+(uniformItems _unit)+(backpackItems _unit)+(items _unit));
};
[_unit] call F_correctLaserBatteries;
[_unit] call F_correctHEGL;