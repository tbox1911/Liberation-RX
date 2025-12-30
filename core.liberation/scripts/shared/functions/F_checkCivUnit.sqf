params ["_unit"];

if (!alive _unit) exitWith { true };
(
    !GRLIB_player_near_lhd &&
    handgunWeapon _unit == "" &&
    primaryWeapon _unit == "" &&
    secondaryWeapon _unit == "" &&
    ([uniform _unit, "uniform"] call F_checkCivItem) &&
    ([vest _unit, "vest"] call F_checkCivItem) &&
    ([backpack _unit, "backpack"] call F_checkCivItem)
)
