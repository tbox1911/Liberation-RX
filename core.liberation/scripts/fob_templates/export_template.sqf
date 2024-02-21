// Dump FOB defense buildings position to Clipboard

private _fob_pos = [] call F_getNearestFob;
private _objects_to_save = [];
private _msg = "";
private _clipboard = "";
{ _objects_to_save pushBackUnique (_x select 0) } forEach (buildings + support_vehicles);
_objects_to_save = _objects_to_save - [ "SignAd_Sponsor_F"];

{ 
    if ( getObjectType _x >= 8 ) then {
        _msg = format ["[""%1"", [%2, %3, %4], %5],",
        typeof _x, 
        [ (getpos _x select 0) - (getpos player select 0), 2 ] call BIS_fnc_cutDecimals, 
        [ (getpos _x select 1) - (getpos player select 1), 2 ] call BIS_fnc_cutDecimals,
        [ (getposatl _x select 2), 2 ] call BIS_fnc_cutDecimals, 
        [ getdir _x , 2 ] call BIS_fnc_cutDecimals ];
        _clipboard = _clipboard + _msg;
    };
} foreach (nearestObjects [_fob_pos, _objects_to_save, GRLIB_fob_range]);

_msg = [_clipboard, 0, (count _clipboard)-2] call BIS_fnc_trimString;	
copyToClipboard ("[" + _msg + "]");
hintSilent "Template dumped to clipboard!"
