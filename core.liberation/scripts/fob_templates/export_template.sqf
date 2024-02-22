// Dump FOB defense buildings position to Clipboard

private _fob = (player nearObjects [FOB_typename, 150] select 0);
if (isNil "_fob") exitWith {};
private _fob_pos = getPosATL _fob;
private _fob_dir = getDir _fob;

private _objects_to_save = [];
{ _objects_to_save pushBackUnique (_x select 0) } forEach (buildings + support_vehicles);

private _clipboard = "";
{ 
    if ( getObjectType _x >= 8 && _x distance2D _fob_pos > 14) then {
        private _dir = (getDir _x - _fob_dir);
		while { _dir > 360 } do { _dir = _dir - 360 };
		while { _dir < 0 } do { _dir = _dir + 360 };        
        private _msg = format ["[""%1"", [%2, %3, %4], %5],",
            typeOf _x, 
            round ((getPosATL _x select 0) - (_fob_pos select 0)),
            round ((getPosATL _x select 1) - (_fob_pos select 1)),
            round (getPosATL _x select 2),
            round (_dir)
        ];
        _clipboard = _clipboard + _msg;
    };
} foreach (nearestObjects [_fob_pos, _objects_to_save, GRLIB_fob_range]);

private _msg = [_clipboard, 0, (count _clipboard)-2] call BIS_fnc_trimString;	
copyToClipboard ("[" + _msg + "]");
hintSilent "Template dumped to Clipboard!"
