// uns_US_25ID_MGAASG - AASoldier
_unit = _this select 0;

_unit addWeapon "uns_sa7";
_unit addSecondaryWeaponItem "uns_sa7mag";

removeBackpack _unit;
_unit addBackpack "UNS_Alice_4";
for "_i" from 1 to 2 do {_unit addItemToBackpack "uns_sa7mag";};
