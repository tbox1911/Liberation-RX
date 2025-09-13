if (!GRLIB_Commander_mode || !isServer) exitWith {};
sleep 20;

GRLIB_IsVoteInProgress = false;
private _msg = "";

while {true} do {
    waitUntil {sleep 3; ((GRLIB_IsVoteInProgress && GRLIB_Commander_VoteEnabled) || GRLIB_Commander_AutoStart) && count active_sectors == 0 && count GRLIB_AvailAttackSectors > 0};
    if (GRLIB_Commander_VoteEnabled) then {
        _msg = format ["Voting for the next sector has begun, you have %1 seconds to vote!", GRLIB_Commander_VoteTime];
        [[GRLIB_side_friendly, "HQ"], _msg] remoteExec ["sideChat", 0];
    } else {
        _msg = format ["The next sector will be selected automatically, you have %1 seconds to prepare!", GRLIB_Commander_VoteTime];
        [[GRLIB_side_friendly, "HQ"], _msg] remoteExec ["sideChat", 0];
    };

    _timer = time + GRLIB_Commander_VoteTime;
    sleep 1;
    waitUntil {
        _time_left = round(_timer - time);
        if (_time_left % 10 == 0) then {
            _msg = format ["Selection in %1 seconds...", 1 max _time_left];
            [[GRLIB_side_friendly, "HQ"], _msg] remoteExec ["sideChat", 0];
        };
        sleep 1;
        (time >= _timer || !GRLIB_IsVoteInProgress);
    };

    if (GRLIB_IsVoteInProgress && count active_sectors == 0 && count GRLIB_AvailAttackSectors > 0) then {
        if (GRLIB_Commander_VoteEnabled) then {
            _msg = format ["Voting has ended!"];
            [[GRLIB_side_friendly, "HQ"], _msg] remoteExec ["sideChat", 0];
        };
        _votes = (GRLIB_Sector_Votes apply { _y }) select { _x in GRLIB_AvailAttackSectors };
        _tiedSectors = [];
        if (count _votes > 0) then {
            _uniqueSectors = [];
            {
                _uniqueSectors pushBackUnique _x;
            } forEach _votes;

            _maxCount = 0;
            {
                _sector = _x;
                _count = {_x isEqualTo _sector} count _votes;

                if (_count > _maxCount) then {
                    _maxCount = _count;
                    _tiedSectors = [_sector];
                } else {
                    if (_count == _maxCount) then {
                        _tiedSectors pushBackUnique _sector;
                    };
                };
            } forEach _uniqueSectors;
        } else {
            _tiedSectors = [] + GRLIB_AvailAttackSectors;
        };
        _winningSector = selectRandom _tiedSectors;
        _msg = format ["The invasion will proceed to %1!", markerText _winningSector];
        [[GRLIB_side_friendly, "HQ"], _msg] remoteExec ["sideChat", 0];
        [_winningSector] call start_sector;
    };

    GRLIB_IsVoteInProgress = false;
    GRLIB_Sector_Votes = createHashMap;
};