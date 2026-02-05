params ["_newUnit", "_oldUnit"];

GRLIB_player_configured = false;
[_newUnit] call clean_unit;
_newUnit switchMove "";
waitUntil { sleep 0.1; !isNil "GRLIB_player_group" };

private _unit = objNull;

// Player Init
if (GRLIB_side_friendly == WEST) then {
    _unit = _newUnit;
    [_unit] joinSilent GRLIB_player_group;
} else {
    private _class = typeOf player;
    if (GRLIB_side_friendly == EAST) then { _class = "O" + (_class select [1]) };
    if (GRLIB_side_friendly == INDEPENDENT) then { _class = "I" + (_class select [1]) };
    _unit = GRLIB_player_group createUnit [_class, position player, [], 1, "NONE"];
    [_unit] joinSilent GRLIB_player_group;
    [_unit] call clean_unit;
    [_unit, [profileName,profileName,profileName]] remoteExec ["setName", 0];
    _unit switchMove "";
    selectPlayer _unit;
    if (!isNull _oldUnit) then {
        // Set player variables
        _unit setVariable ["my_dog", (_oldUnit getVariable ["my_dog", nil])];
        _unit setVariable ["my_squad", (_oldUnit getVariable ["my_squad", nil])];
        _unit setVariable ["GRLIB_player_context_loaded", (_oldUnit getVariable ["GRLIB_player_context_loaded", false]), true];
        _unit setVariable ["GRLIB_squad_context_loaded", (_oldUnit getVariable ["GRLIB_squad_context_loaded", false]), true];
        _unit setVariable ["GRLIB_virtual_garage", (_oldUnit getVariable ["GRLIB_virtual_garage", []]), true];
        _unit setVariable ["GRLIB_personal_arsenal", (_oldUnit getVariable ["GRLIB_personal_arsenal", []]), true];
        _unit setVariable ["GRLIB_player_box", (_oldUnit getVariable ["GRLIB_player_box", []]), true];     
        _unit setVariable ["GRLIB_player_box_content", (_oldUnit getVariable ["GRLIB_player_box_content", []]), true];
        _unit setVariable ["GREUH_score_count", (_oldUnit getVariable ["GREUH_score_count", 0]), true];
        _unit setVariable ["GREUH_score_last", (_oldUnit getVariable ["GREUH_score_last", 0]), true];
        _unit setVariable ["GREUH_ammo_count", (_oldUnit getVariable ["GREUH_ammo_count", 0]), true];
        _unit setVariable ["GREUH_fuel_count", (_oldUnit getVariable ["GREUH_fuel_count", 0]), true];
        _unit setVariable ["GREUH_reput_count", (_oldUnit getVariable ["GREUH_reput_count", 0]), true];
        _unit setVariable ["GREUH_kills_inf", (_oldUnit getVariable ["GREUH_kills_inf", 0]), true];
        _unit setVariable ["GREUH_kills_soft", (_oldUnit getVariable ["GREUH_kills_soft", 0]), true];
        _unit setVariable ["GREUH_kills_armor", (_oldUnit getVariable ["GREUH_kills_armor", 0]), true];
        _unit setVariable ["GREUH_kills_air", (_oldUnit getVariable ["GREUH_kills_air", 0]), true];
        _unit setVariable ["GREUH_killed", (_oldUnit getVariable ["GREUH_killed", 0]), true];
        _unit setVariable ["GRLIB_TFAR_SW_config", (_oldUnit getVariable ["GRLIB_TFAR_SW_config", []]), true];
        _unit setVariable ["GRLIB_TFAR_LR_config", (_oldUnit getVariable ["GRLIB_TFAR_LR_config", []]), true];
    };
    [_unit] call player_EHP;
    [] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_version.sqf";
    sleep 0.2;
    deleteVehicle _newUnit;
};

// Player Loadout
if !(_unit getVariable ["GRLIB_player_context_loaded", false]) then {
    [_unit] remoteExec ["load_player_context_remote_call", 2];
    sleep 1;
};
waitUntil { sleep 0.5; (_unit getVariable ["GRLIB_player_context_loaded", false]) };

[_unit] spawn player_loadout;
waitUntil { sleep 0.5; startgame == 1 };

[_unit] call player_EH;
[_unit] spawn player_init;
_unit setvariable ["PAR_grave_box", PAR_grave_box, true];

// Keep player first / Reset group
if (count (units GRLIB_player_group) > 1) then {
	[player] joinSilent grpNull;
	[player] joinSilent GRLIB_player_group;
	GRLIB_player_group selectLeader player;
	{
        if (side _x != GRLIB_side_civilian) then { [_x] joinSilent GRLIB_player_group };
        _x setVariable ["PAR_Grp_AI", GRLIB_player_group];
    } forEach PAR_AI_bros;
};

// Remove old unit
removeAllWeapons _oldUnit;
deleteVehicle _oldUnit;
