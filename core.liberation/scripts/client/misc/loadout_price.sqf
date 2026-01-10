GRLIB_saved_loadouts = [];

private _saved_loadouts = profileNamespace getVariable ["bis_fnc_saveInventory_data", []];
private _saved_loadouts_ace = profileNamespace getVariable ["ace_arsenal_saved_loadouts", []];
private ["_unit", "_name", "_price", "_loadout_loaded"];

if (GRLIB_ACE_enabled) then {
	if (!isNil "_saved_loadouts_ace") then {
		_unit = "B_Soldier_VR_F" createVehicle zeropos;
		_unit allowDamage false;
		{
			if (_forEachIndex % 1 == 0 && _forEachIndex < 40) then {
				_name = _x select 0;
				_loadout_loaded = _x select 1;
				[_unit, _loadout_loaded] call CBA_fnc_setLoadout;
				_price = [_unit] call F_loadoutPrice;
				GRLIB_saved_loadouts pushback [_name, _price, _loadout_loaded];
			};
		} foreach _saved_loadouts_ace;
		deleteVehicle _unit;
    };
} else {
    if (!isNil "_saved_loadouts") then {
        _unit = "B_Soldier_VR_F" createVehicle zeropos;
        _unit allowDamage false;
        {
            if (_forEachIndex % 2 == 0 && _forEachIndex < 40) then {
                _name = _x;
                [_unit, [profileNamespace, _name]] call bis_fnc_loadInventory;
                _price = [_unit] call F_loadoutPrice;
                GRLIB_saved_loadouts pushback [_name, _price, ""];
            };
        } foreach _saved_loadouts;
        deleteVehicle _unit;
    };
};
