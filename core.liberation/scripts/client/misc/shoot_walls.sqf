waitUntil {sleep 1; GRLIB_player_spawned};

while {true} do {
    sleep 0.01;

    if (alive player && currentWeapon player != "") then {
        private _start = eyePos player;
        private _end = _start getPos [1.3, getDir player];
        _end set [2, _start select 2];

        if (inputAction "defaultAction" > 0 && lineIntersects [_start, _end, player]) then {
            player setWeaponReloadingTime [player, currentMuzzle player, 1000];
            hintSilent "Shot blocked! (object detected)";
            playSound "click";
        };
    };
};
