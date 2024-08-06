_unit = _this select 0;

if ( (typeOf _unit) in militia_loadout_overide ) then {
    private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_east, toLower (typeOf _unit)];
	[_path, _unit] call F_getTemplateFile;    
} else {
    // Global overide militia default loadout
    _unit linkItem "ItemMap";
    _unit linkItem "ItemCompass";
};

if (floor random 100 < 40) then {
    _unit addPrimaryWeaponItem "acc_flashlight";
};