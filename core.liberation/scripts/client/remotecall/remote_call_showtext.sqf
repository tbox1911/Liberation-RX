if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_type"];

private _enemy_nearby = [player, GRLIB_sector_size, GRLIB_side_enemy] call F_getUnitsCount;
if (_enemy_nearby > 0 || (behaviour player) in [ "COMBAT", "STEALTH"]) exitWith {};

private _data = [];
private _last_news = 0;
switch (_type) do {
    // case 1 : {
    // };
    case 2 : {
        _data = [] call F_notice_weather;
        _last_news = 2;
    };
    case 3 : {
        _data = [] call F_notice_news;
        _last_news = 1;
    };
    case 4 : {
        _data = [] call F_notice_hof;
        _last_news = 0;
    };
    case 5 : {
        _data = [] call F_notice_good;
        _last_news = 4;
    };
    case 6 : {
        _data = [] call F_notice_bad;
        _last_news = 0;
    };
    case 7 : {
        _data = [] call F_notice_ammo;
        _last_news = 3;
    };
};
if (count _data > 0) then {
    GRLIB_LastNews = -1;
    _data spawn BIS_fnc_dynamicText;
    sleep 10;
    GRLIB_LastNews = _last_news;    
};
