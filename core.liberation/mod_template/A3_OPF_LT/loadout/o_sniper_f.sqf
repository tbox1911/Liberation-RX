_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

#include "loadout_init.sqf"
private _pmc_weapon = [ 
    "srifle_DMR_02_sniper_F",
    "srifle_DMR_02_F",
    "srifle_DMR_02_camo_F"
];

private _pmc_optic = [ 
    "optic_KHS_tan",
    "optic_KHS_blk",
    "optic_KHS_old"
];

_unit addGoggles (selectRandom _pmc_goggles);
_unit addWeapon (selectRandom _pmc_weapon);
_unit addPrimaryWeaponItem (selectRandom _pmc_optic);
_unit addPrimaryWeaponItem "acc_flashlight";
_unit forceAddUniform (selectRandom _pmc_uniforms);
_unit addVest (selectRandom _pmc_vest);
_unit addBackpack (selectRandom _pmc_backpack);
_unit addHeadgear (selectRandom _pmc_headgear);
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
