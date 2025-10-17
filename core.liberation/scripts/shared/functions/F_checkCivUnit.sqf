params ["_unit"];
(
    !GRLIB_player_near_lhd &&
    handgunWeapon _unit == "" &&
    primaryWeapon _unit == "" &&
    secondaryWeapon _unit == "" &&
    ((vest _unit) == "" || (vest _unit) select [0,8] == "V_Safety") &&
    ((uniform _unit) == "" || (uniform _unit) select [0,4] == "U_C_") &&
    ((backpack _unit) == "" || (backpack _unit) select [0,5] == "B_Civ")
)