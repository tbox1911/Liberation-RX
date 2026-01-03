if (!isDedicated) exitWith {};

sleep 60;
private _current_uid = 0;

while {true} do {
    _current_uid = count (allPlayers select {!(_x isKindOf "HeadlessClient_F")});
    if (_current_uid == 0 && !GRLIB_server_persistent) exitWith {
        diag_log "--- LRX Mission End ---";
        if (time < 300) then {
            diag_log format ["--- LRX Saving cooldown (no save done), %1sec remaining...", round (300 - time)];
        } else {
            [] call save_game_mp;
        };
        // { deleteMarker _x } forEach allMapMarkers;
        // { deleteVehicle _x } forEach allUnits;
        // { deleteVehicle _x } forEach vehicles;
    };

    if (_current_uid == 0 && GRLIB_server_persistent) then {
        [] call save_game_mp;
        waitUntil { sleep 30; count (allPlayers select {!(_x isKindOf "HeadlessClient_F")}) > 0 };
    };
    sleep 0.2;
};
