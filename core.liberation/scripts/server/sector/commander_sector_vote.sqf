if (!GRLIB_Commander_mode || !isServer) exitWith {};
sleep 60;
while {true} do {
    waitUntil {sleep 3; ((GRLIB_IsVoteInProgress && GRLIB_Commander_VoteEnabled) || GRLIB_Commander_AutoStart) && GRLIB_LRX_params_loaded && !GRLIB_connCalculating && active_sectors isEqualTo [] && !(GRLIB_AvailAttackSectors isEqualTo [])};
    if (GRLIB_Commander_VoteEnabled) then {
        [GRLIB_side_friendly, "HQ"] sideChat format ["Voting for the next sector has begun, you have %1 seconds to vote!", GRLIB_Commander_VoteTime];
    } else {
        [GRLIB_side_friendly, "HQ"] sideChat format ["The next sector will be selected automatically, you have %1 seconds to prepare!", GRLIB_Commander_VoteTime];
    };
    sleep GRLIB_Commander_VoteTime;
    if (active_sectors isEqualTo [] && !(GRLIB_AvailAttackSectors isEqualTo [])) then {
        if (GRLIB_Commander_VoteEnabled) then {
            [GRLIB_side_friendly, "HQ"] sideChat format ["Voting has ended!"];
        };
        _votes = (GRLIB_Sector_Votes apply { _y }) select { _x in GRLIB_AvailAttackSectors };
        _tiedSectors = [];
        if (!(_votes isEqualTo [])) then {
            GRLIB_AvailAttackSectors = [];
            publicVariable "GRLIB_AvailAttackSectors";
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
            _tiedSectors = +GRLIB_AvailAttackSectors;
        };
        _winningSector = selectRandom _tiedSectors;
        [GRLIB_side_friendly, "HQ"] sideChat format ["The invasion will proceed to %1!", markerText _winningSector];
        [_winningSector] call start_sector;
        sleep 30;
        _sectorPos = getMarkerPos _winningSector;
        {
            if ((!(_x isEqualTo _winningSector)) && {(((getMarkerPos _x) distance2D _sectorPos) < GRLIB_Commander_radius)}) then {
                [_x] call start_sector;
                sleep 30;
            };
        } forEach opfor_sectors;
    };
    GRLIB_IsVoteInProgress = false;
    GRLIB_Sector_Votes = createHashMap;
};