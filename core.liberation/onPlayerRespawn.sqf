params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

GRLIB_player_configured = false;
[_newUnit] call clean_unit;
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
    selectPlayer _unit;
    _unit setVariable ["my_dog", (_newUnit getVariable ["my_dog", nil])];
    _unit setVariable ["my_squad", (_newUnit getVariable ["my_squad", nil])];
    _unit setVariable ["GRLIB_player_context_loaded", (_newUnit getVariable ["GRLIB_player_context_loaded", false]), true];
    _unit setVariable ["GRLIB_squad_context_loaded", (_newUnit getVariable ["GRLIB_squad_context_loaded", false]), true];
    [] spawn compile preprocessFileLineNumbers "GREUH\scripts\GREUH_version.sqf";
    sleep 0.2;
    deleteVehicle _newUnit;
};

// Player Loadout
if !(_unit getVariable ["GRLIB_player_context_loaded", false]) then {
    [_unit] remoteExec ["load_player_context_remote_call", 2];
    sleep 3;
};

[_unit] call player_loadout;
waitUntil { sleep 0.5; startgame == 1 };

[_unit] call PAR_EventHandler;
[_unit] call PAR_Player_Init;
_unit setvariable ["PAR_grave_box", PAR_grave_box, true];

// // Reset group
// if (GRLIB_Undercover_mode == 1) then {
//     if (side GRLIB_player_group == GRLIB_side_civilian && !(isNil {player getVariable "GRLIB_unit_detected"})) then {
//         private _player_units = (units GRLIB_player_group);
//         GRLIB_player_group = createGroup [GRLIB_side_friendly, true];
//         waitUntil {
//             [player] joinSilent GRLIB_player_group;
//             sleep 0.5;
//             (player in (units GRLIB_player_group));
//         };
//         [GRLIB_player_group, "add"] remoteExec ["addel_group_remote_call", 2];
//         _player_units joinSilent GRLIB_player_group;
//         { _x setVariable ["PAR_Grp_AI", GRLIB_player_group] } forEach PAR_AI_bros;
//     };
// };