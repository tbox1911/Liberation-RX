params ["_unit"];
private _maxpri = 10;           // maximum magazines unit can take (primary weapon)
private _minpri = 6;            // minimal magazines before unit need to reload
private _remove_items = [       // remove all items from inventory
    "R3F_FlashBang_mag"
];

{ _unit removeMagazines _x} foreach _remove_items;

private _needammo1 = [_unit, primaryWeapon _unit, _minpri] call F_UnitNeedAmmo;
if (_needammo1) then {
    _needammo1 = [_unit, primaryWeapon _unit, _maxpri] call F_UnitAddAmmo;
};
