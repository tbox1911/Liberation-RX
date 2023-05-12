private _r = 0;
{if ((((toLower _x) splitString "_" select 0) find str(parseText GRLIB_r1)) != -1) then {_r=_r+1}} forEach [missionName, localize "STR_MISSION_TITLE", briefingName];
{if (((toLower _x) find str(parseText GRLIB_r2)) != -1) then {_r=_r+1}} forEach [missionName, localize "STR_MISSION_TITLE", briefingName];
(_r mod 6 == 0)