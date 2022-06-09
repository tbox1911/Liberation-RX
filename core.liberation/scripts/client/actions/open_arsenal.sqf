if (FAC_MSU_ACTIVE) then {
	_fac = group player getVariable ["BIS_dg_fac", true];
	    // gibt true wenn keine Gruppe oder Fraktion festgelegt.
	if (_fac == "Nofaction") exitWith {
		hint "Bitte erstelle eine Gruppe im groupmanager, und wähle deine Fraktion in den Gruppendetails!";
	};

	_prc = format ["FAC_MSU\%1\arsenal.sqf", _fac];
	    // [] call compile preprocessFileLineNumbers _prc;

	_handle = player execVM _prc;
	waitUntil {
		scriptDone _handle
	};

	_box = missionnamespace getVariable ["myLARsBox", objNull];
	[_box, false] call ace_arsenal_fnc_initBox;
	[_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
	[_box, arsenal] call ace_arsenal_fnc_addVirtualitems;
	[_box, items_allFac] call ace_arsenal_fnc_addVirtualitems;
	[_box, equipment] call ace_arsenal_fnc_addVirtualitems;
	[_box, player, false] call ace_arsenal_fnc_openBox;

	    // filter and pay loadout
	[player] call F_filterloadout;
	[player] call F_payloadout;
} else {
	load_loadout = 0;
	edit_loadout = 0;
	respawn_loadout = 0;
	load_from_player = -1;
	exit_on_load = 0;

	GRLIB_backup_loadout = [player] call F_getloadout;
	player setVariable ["GREUH_stuff_price", ([player] call F_loadoutPrice)];
    
	if (isNil "global_arsenal") then {
		global_arsenal = false
	};

	if (global_arsenal) then {
        _glob_box = missionnamespace getVariable ["myLARsBox", objNull];
		[_glob_box, player, false] call ace_arsenal_fnc_openBox;
	} else {
		_box = missionnamespace getVariable ["myLARsBox", objNull];
		[_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
		[_box, true] call ace_arsenal_fnc_initBox;
		[_box, item_blacklist] call ace_arsenal_fnc_removeVirtualitems;
		[_box, player, false] call ace_arsenal_fnc_openBox;
	};


	    // filter and pay loadout
	[player] call F_filterloadout;
	[player] call F_payloadout;
};
