params ["_unit"];

private _playername = "";
private _clantag = squadParams _unit select 0 select 0;
if (!isNil "_clantag") then {
    if (_clantag != "") then { _playername = "[" + _clantag + "] " };
};
_playername = _playername + (name _unit);
_playername;
