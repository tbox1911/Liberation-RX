params ["_player"];
if (score _player < 20) exitWith {};

diag_log format ["--- Player %1, Squad Saved", name _player];
private _uid = _player getVariable ["PAR_Grp_ID","1"];
private _bros = allUnits select {!isPlayer _x && (_x getVariable ["PAR_Grp_ID","0"]) == _uid};
private _ai_group = [];
{
	if (lifeState _x != "INCAPACITATED") then { _ai_group pushback [typeOf _x, rank _x, [_x] call F_getLoadout] };
	deleteVehicle _x;
} forEach _bros;

private _new = true;
private _uid = getPlayerUID _player;
{
	if (_x select 0 == _uid) exitWith {
		_x set [1, [player] call F_getLoadout];
		_x set [2, _ai_group ];
		_new = false;
	};
} foreach GRLIB_player_context;

if (_new) then {
	GRLIB_player_context pushback [ getPlayerUID player, [player] call F_getLoadout, _ai_group ];
};
