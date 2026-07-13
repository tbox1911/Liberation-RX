params ["_pos"];

if (isNil "_pos") then { _pos = getPosASL player };
if (_pos distance2D lhd <= 200) exitWith {
    player setPosATL ((getPosATL lhd) vectorAdd [floor(random 5), floor(random 5), 0.3]);
    player setVariable ["GRLIB_action_inuse", false, true];
};

private _near_sign = nearestObjects [_pos, [FOB_sign], 200] select 0;
if (isNil "_near_sign") exitWith { player setVariable ["GRLIB_action_inuse", false, true] };

private _unit_list = units group player;
private _my_squad = player getVariable ["my_squad", nil];
if (!isNil "_my_squad") then { { _unit_list pushBack _x } forEach units _my_squad };
private _list_redep = _unit_list select {
    !(isPlayer _x) && (isNull objectParent _x) &&
    (_x distance2D player <= 40) && !(captive _x)
};

player allowDamage false;
{ _x allowDamage false } forEach _list_redep;

private _destdir = getDir _near_sign;
private _destpos = getPosASL _near_sign;
private _alt = (_destpos select 2) + 0.1;
_destpos = _destpos getPos [6, (_destdir-180)];
_destpos set [2, _alt];
player setDir _destdir;
player setPosASL _destpos;
sleep 1;
{
    _x setPosASL ([getPosASL player, 5] call F_getRandomPos);
	sleep 0.5;
} forEach _list_redep;

sleep 1;
player allowDamage true;
{ _x allowDamage true } forEach _list_redep;
player setVariable ["GRLIB_action_inuse", false, true];
