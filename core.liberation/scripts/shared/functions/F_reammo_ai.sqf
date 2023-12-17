params ["_unit"];
if (isNil "_unit") exitWith {};

private _primary_weapon = primaryWeapon _unit;
private _secondary_weapon = secondaryWeapon _unit;
if (_primary_weapon == "") exitWith {};
private _maxpri = 10;           // maximum magazines unit can take (primary weapon)
private _minpri = 6;            // minimal magazines before unit need to reload
private _maxsec = 3;            // maximum magazines unit can take (secondary weapon)
private _minsec = 1;            // minimal magazines before unit need to reload

private _remove_items = [
    "R3F_FlashBang_mag"
];

{ _unit removeMagazines _x } foreach _remove_items;

if ( _primary_weapon find "LMG" >= 0 || _primary_weapon find "MMG" >= 0 || _primary_weapon find "RPK12" >= 0 ) then { _minpri = 1; _maxpri = 3 };
private _needammo1 = [_unit, _primary_weapon, _minpri] call F_UnitNeedAmmo;
if (_needammo1) then {
    [_unit, _primary_weapon, _maxpri] call F_UnitAddAmmo;
};

if (!isNull (unitBackpack _unit) && _secondary_weapon != "") then {
    private _needammo2 = [_unit, _secondary_weapon, _minsec] call F_UnitNeedAmmo;
    if (_needammo2) then {
        clearAllItemsFromBackpack _unit;
        [_unit, _secondary_weapon, _maxsec] call F_UnitAddAmmo;
    };
};