params ["_pos"];

if (isNil "_pos") then { _pos = getPosASL player };
if (_pos distance2D lhd <= 200) exitWith {
    player setPosATL ((getPosATL lhd) vectorAdd [floor(random 5), floor(random 5), 1]);
    player setVariable ["GRLIB_action_inuse", false, true];
};

private _near_sign = nearestObjects [_pos, [FOB_sign], 200] select 0;
if (isNil "_near_sign") exitWith { player setVariable ["GRLIB_action_inuse", false, true] };

private _unit_list = units group player;
private _my_squad = player getVariable ["my_squad", nil];
if (!isNil "_my_squad") then { { _unit_list pushBack _x } forEach units _my_squad };
private _list_redep = _unit_list select {
    !(isPlayer _x) && (isNull objectParent _x) &&
    (_x distance2D player <= 30) &&
    lifestate _x != 'INCAPACITATED'
};

player allowDamage false;
private _destdir = getDir _near_sign;
private _destpos = getPosASL _near_sign;
private _alt = (_destpos select 2) + 1;
_destpos = _destpos getPos [6, (_destdir-180)];
_destpos set [2, _alt];
player setDir _destdir;
player setPosASL _destpos;
sleep 1;
player allowDamage true;

{
    _destpos = ([player, 3] call F_getRandomPos);
    _destpos set [2, _alt];
	_x setPosASL _destpos;
	sleep 0.5;
} forEach _list_redep;
sleep 3;
player setVariable ["GRLIB_action_inuse", false, true];
