params ["_unit"];

private _blacklist = missionNamespace getVariable ["GRLIB_blacklisted_from_arsenal", []];
private _is_allowed = {
    params ["_item"];
    private _ret = true; 
    if (_blacklist find _item >= 0) then {
        _ret = false;
    } else {
        { if (_item find _x >= 0) exitWith { _ret = false } } foreach _blacklist;
    };
    _ret;
};

if !([handgunWeapon _unit] call _is_allowed) then {_unit removeWeapon (handgunWeapon _unit)};
if !([primaryWeapon _unit] call _is_allowed) then {_unit removeWeapon (primaryWeapon _unit)};
if !([secondaryWeapon _unit] call _is_allowed) then {_unit removeWeapon (secondaryWeapon _unit)};
if !([uniform _unit] call _is_allowed) then {removeUniform _unit};
if !([vest _unit] call _is_allowed) then {removeVest _unit};
if !([headgear _unit] call _is_allowed) then {removeHeadgear _unit};
if !([backpack _unit] call _is_allowed) then {removeBackpack _unit};
if !([binocular _unit] call _is_allowed) then {_unit removeWeapon (binocular _unit)};
if !([hmd _unit] call _is_allowed) then {_unit unlinkItem (hmd _unit)};
{ if !([_x] call _is_allowed) then {_unit unlinkItem _x} } forEach assignedItems _unit;
{ if !([_x] call _is_allowed) then {_unit removePrimaryWeaponItem _x} } forEach primaryWeaponItems _unit;
{ if !([_x] call _is_allowed) then {_unit removeItem _x} } forEach ((vestItems _unit)+(uniformItems _unit)+(backpackItems _unit)+(items _unit));
