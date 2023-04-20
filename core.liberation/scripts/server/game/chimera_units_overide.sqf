if (!isServer) exitWith {};

private [ "_unit_model", "_cloth", "_items", "_weapon", "_mag",  "_src_class", "_dst_class", "_veh_lst", "_veh", "_src_pos", "_src_dir" ];

// repaint man units 
private _chimera_soldiers = [];
allUnits apply { if ((getPosATL _x) distance2D lhd < 500 && !isPlayer _x) then {_chimera_soldiers pushback _x} };
{
    _unit_model = selectRandom blufor_squad_inf;
    _cloth = getText(configfile >> "CfgVehicles" >> _unit_model >> "uniformClass");
    _items = getArray (configfile >> "CfgVehicles" >> _unit_model >> "linkedItems");
    _weapon = (getArray (configfile >> "CfgVehicles" >> _unit_model >> "weapons") - ["Throw","Put"]) select 0;
    _mag = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines" ) select 0;
    //diag_log format ["DBG: %1 %2 %3 %4", _unit_model, _items, _weapon, _mag];
    _unit = _x;
    _unit forceAddUniform _cloth;
    removeAllWeapons _unit;
    removeAllAssignedItems _unit;
    {_unit linkItem _x} forEach _items;
    for "_i" from 1 to 3 do {_unit addItem _mag};
    for "_i" from 1 to 3 do {_unit addItemToVest _mag};
    _unit addWeapon _weapon;
    for "_i" from 1 to 3 do {_unit addItemToVest _mag};
} forEach _chimera_soldiers;


// repaint vehicle
if (!isNil "chimera_vehicle_overide") then {
    {
        _src_class = _x select 0;
        _dst_class = _x select 1;
        _veh_lst = [ vehicles, { alive _x && _x distance lhd < 500 && typeOf _x == _src_class }] call BIS_fnc_conditionalSelect;

        {
            _src_pos = (getPosATL _x) vectorAdd [0, 0, 0.2];
            _src_dir = getDir _x;
            deleteVehicle _x;
            sleep 0.1;
            _veh = _dst_class createVehicle _src_pos;
            _veh allowDamage false;
            _veh setPosATL _src_pos;
            _veh setDir _src_dir;
            _veh setVariable ["GRLIB_vehicle_owner", "public", true];
            sleep 0.1;
            _veh allowDamage true;
            if (GRLIB_ACE_enabled) then {
                if (_src_class == "B_Heli_Light_01_F") then {
                    [_veh, 15] call ace_cargo_fnc_setSpace;
                };
                if (_src_class == "B_Heli_Transport_01_F") then {
                    [_veh, 30] call ace_cargo_fnc_setSpace;
                };
            };
        } forEach _veh_lst;

    } forEach chimera_vehicle_overide;
};
