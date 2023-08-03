_unit = _this select 0;

private _militia_uniforms = [ 
  "U_Afghan01",
  "U_Afghan02",
  "U_Afghan03",
  "U_Afghan04",
  "U_Afghan05",
  "U_Afghan06"
];

removeUniform _unit;
_unit forceAddUniform (selectRandom _militia_uniforms);

_unit removeWeapon "launch_O_Titan_short_F";
_unit addWeapon "launch_MRAWS_green_F";
_unit addSecondaryWeaponItem "MRAWS_HEAT_F";

clearAllItemsFromBackpack _unit;
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HEAT_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HE_F";};