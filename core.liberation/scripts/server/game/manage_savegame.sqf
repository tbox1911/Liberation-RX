//if (!isDedicated) exitWith {};

sleep 30;

private ["_current_uid", "_uid"];
private _known_uid = [];

while {true} do {
    _current_uid = (allPlayers select {!(_x isKindOf "HeadlessClient_F")}) apply { getPlayerUID _x };
    sleep 0.5;
    {
        _uid = _x;
        if (_uid != "" && isNull (_uid call BIS_fnc_getUnitByUID)) then {
            [_uid] call cleanup_uid;
            diag_log format ["--- LRX Player (%1) left the mission.", _uid];
        };
    } forEach (_known_uid - _current_uid);

    _known_uid = _current_uid;
    if (count _current_uid == 0 && !GRLIB_server_persistent) exitWith {
        diag_log "--- LRX Mission End ---";

        if (time < 300) then {
            diag_log format ["--- LRX Saving cooldown (no save done), %1sec remaining...", round (300 - time)];
        } else {
            [] call save_game_mp;
        };
        { deleteMarker _x } forEach allMapMarkers;
        { deleteVehicle _x } forEach allUnits;
        { deleteVehicle _x } forEach vehicles;
    };

    if (count _current_uid == 0 && GRLIB_server_persistent) then {
        [] call save_game_mp;
        waitUntil { sleep 30; count (allPlayers select {!(_x isKindOf "HeadlessClient_F")}) > 0 };
    };
    sleep 0.5;
};
