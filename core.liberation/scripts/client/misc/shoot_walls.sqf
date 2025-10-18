waitUntil {sleep 1; GRLIB_player_spawned};

while {true} do {
    waitUntil { sleep 0.01; !visibleMap && !dialog && alive player && isNull objectParent player && currentWeapon player != "" };

    if (inputAction "defaultAction" > 0) then {
        private _tree = count (nearestTerrainObjects [player, ["Tree","Small Tree"], 10]);
        private _bush = count (nearestTerrainObjects [player, ["Bush"], 5]);

        if (_tree == 0 && _bush == 0) then {
            private _dir = player weaponDirection (currentWeapon player);
            private _start = (eyePos player) vectorAdd (_dir vectorMultiply -0.3);
            private _end = _start vectorAdd (_dir vectorMultiply 1.3);
            // drawLine3D [ASLtoAGL _start, ASLtoAGL _end, [0,1,0,1]];

            if (lineIntersects [_start, _end, player]) then {
                player forceWeaponFire ["",""];
                player setWeaponReloadingTime [player, currentMuzzle player, 1000];
                hintSilent "Shot blocked! (object detected)";
                playSound "click";
            };
        };
    };
};
