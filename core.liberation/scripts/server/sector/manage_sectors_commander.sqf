if !(GRLIB_Commander_mode) exitWith {};
waitUntil {sleep 1; !isNil "blufor_sectors"};

private _roundPos = {
    params ["_x", "_y"];
    _x = (floor (_x * 100)) / 100;
    _y = (floor (_y * 100)) / 100;
    [_x, _y]
};

private _sectors_positions = sectors_allSectors apply {
    [(MarkerPos _x) call _roundPos, _x];
};

private _fobMarks = GRLIB_all_fobs apply {
    [_x call _roundPos, [_x] call F_getFobName];
};
_sectors_positions append _fobMarks;
_sectors_positions sort true;


private _opfor_sectors = (sectors_allSectors - blufor_sectors);
private _fob_sectors = GRLIB_all_fobs apply { [_x] call F_getFobName };
private _blufor_sectors = blufor_sectors + _fob_sectors;
private _newConnections = createHashMap;

GRLIB_AvailAttackSectors = [];

private _tolerance = 0.01;
{
    _pos = _x#0;
    _name = _x#1;
    {
        _pos1 = _x#0;
        _name1 = _x#1;
        _dist = _pos distance2D _pos1;
        if (((_dist) > _tolerance) &&
            {
                (_sectors_positions findIf {
                    _pos2 = _x#0;
                    _dist1 = _pos distance2D _pos2;
                    _dist2 = _pos2 distance2D _pos1;
                    _distT = _dist - _tolerance;
                    (_dist2 < _distT) && (_dist1 < _distT) && (_dist2 > _tolerance) && (_dist1 > _tolerance);
                } == -1)
            }
        ) then {
            _mdist = _dist/2;
            _dir = _pos getDir _pos1;
            _mpos = (_pos getPos [_mdist, _dir]) call _roundPos;
            _newConnections set [_mpos, [_dir, _mdist]];
            if (_name in _blufor_sectors && _name1 in _opfor_sectors) then {
                GRLIB_AvailAttackSectors pushBackUnique _name1;
            };
        };
    } forEach _sectors_positions;
} forEach _sectors_positions;

// Only broadcast a smaller list (Will always be smaller than opfor_sectors list for example)
publicVariable "GRLIB_AvailAttackSectors";

_connectMarkers = +GRLIB_connectMarkers;
{
    _pos = _x;
    _duplicatingConnection = false;
    {
        _pos1 = _x;
        _dist = _pos distance2D _pos1;
        if (_dist < 1) then {
            _duplicatingConnection = true;
            _newConnections deleteAt _pos1;
        };
    } forEach _newConnections;
    if (!_duplicatingConnection) then {
        // Delete old connections
        deleteMarker _y;
        _connectMarkers deleteAt _pos;
    };
} forEach _connectMarkers;

{
    _mpos = _x;
    _marker = createMarkerLocal [format ["line_%1_%2", _mpos#0, _mpos#1], _mpos];
    _connectMarkers set [_mpos, _marker];
    _marker setMarkerPosLocal _mpos;
    _marker setMarkerBrushLocal "Solid";
    _marker setMarkerShapeLocal "RECTANGLE";
    _direction = _y#0;
    _marker setMarkerDirLocal _direction;
    _distance = _y#1;
    _marker setMarkerSizeLocal [8, _distance];
    _marker setMarkerAlphaLocal 0.5;
    _marker setMarkerColor "ColorBlack";
} forEach _newConnections;

GRLIB_connectMarkers = _connectMarkers;
