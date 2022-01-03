params ["_unit", "_item", "_max"];
private ["_magType"];
private _stop = true;

_magType = getArray( configFile >> "CfgWeapons" >> _item >> "magazines" ) select 0;
for [{_i=0}, {_i<_max && _stop}, {_i=_i+1}] do {
    if (_unit canAdd _magType && loadAbs _unit < 980) then {
        _unit addMagazines [_magType, 1];
    } else {
        _stop = false;
        //_unit groupchat "Inventory is full !!";
    };
};
_stop;
