params ["_type"];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};
private _enemy_nearby = [player, GRLIB_sector_size, GRLIB_side_enemy] call F_getUnitsCount;
if (_enemy_nearby > 0 || (behaviour player) in [ "COMBAT", "STEALTH"]) exitWith {};

private _data = [];
switch (_type) do {
    // case 1 : {
    // };
    case 2 : {
        _data = [] call F_notice_weather;
    };
    case 3 : {
        _data = [] call F_notice_news;
    };
    case 4 : {
        _data = [] call F_notice_hof;
    };
    case 5 : {
        _data = [] call F_notice_good;
    };
    case 6 : {
        _data = [] call F_notice_bad;
    };
    case 7 : {
        _data = [] call F_notice_ammo;
    };
};
if (count _data > 0) then { _data spawn BIS_fnc_dynamicText };
