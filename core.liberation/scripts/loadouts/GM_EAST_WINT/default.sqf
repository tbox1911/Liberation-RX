_unit = _this select 0;

// Overide default loadout for specific type
private _militia_loadout_overide = [
];

if (typeOf _unit in _militia_loadout_overide) then {
    _loadouts_folder = format ["scripts\loadouts\%1", GRLIB_mod_east];
    [_unit] compile preprocessFileLineNumbers (format ["%1\%2.sqf", _loadouts_folder, toLower (typeOf _unit)]);
} else {
    // Global overide militia default loadout

    // removeHeadgear _unit;
    // removeGoggles _unit;
    // sleep 0.5;
    // _unit forceAddUniform (selectRandom _militia_uniforms);
    // _unit addHeadgear "H_Booniehat_oli";
    // _unit addGoggles "G_Balaclava_lowprofile";
    // _unit addVest "V_BandollierB_oli";
    // _unit addWeapon "srifle_DMR_03_woodland_F";
    // _unit addPrimaryWeaponItem "optic_Hamr";
    // _unit addPrimaryWeaponItem "bipod_03_F_oli";
    // _unit addWeapon "hgun_P07_F";
    _unit linkItem "ItemMap";
    _unit linkItem "ItemCompass";
};

if ( floor(random 100) < 40 ) then {
    _unit addPrimaryWeaponItem "acc_flashlight";
};