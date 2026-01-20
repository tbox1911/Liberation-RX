params ["_unit"];

private _class_overide = toLower (typeOf _unit);
if (_class_overide in militia_loadout_overide) then {
    private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_east, _class_overide];
	[_path, _unit] call F_getTemplateFile;    
} else {
    // Global overide militia default loadout
    _unit linkItem "ItemMap";
    _unit linkItem "ItemCompass";
};

if (floor random 100 >= 60) then {
    _unit addPrimaryWeaponItem "acc_flashlight";
};