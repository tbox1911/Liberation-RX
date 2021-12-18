if (!isServer && hasInterface) exitWith {};
params ["_player", "_extra_units"];
private ["_grp", "_pid", "_squad", "_myveh"];

waitUntil {sleep 0.2; !isNil {_player getVariable ["PAR_Grp_ID", nil]}};

 // HCI Command IA
hcRemoveAllGroups _player;
if ( _player == [] call F_getCommander ) then {
	_myveh = [vehicles, {
		(_x distance lhd) >= 1000 &&
		[_player, _x] call is_owner &&
		_x getVariable ["GRLIB_vehicle_manned", false] &&
		count (crew _x) > 0
	}] call BIS_fnc_conditionalSelect;

	{ _player hcSetGroup [group _x] } foreach _myveh;
};
_grp = _player getVariable ["my_squad", nil];
if (!isNil "_grp") then { _player hcSetGroup [_grp] };
{_player hcSetGroup [group _x]} forEach ([vehicles, {(typeOf _x) in uavs && [_player, _x] call is_owner}] call BIS_fnc_conditionalSelect);

// IA Recall
_pid = _player getVariable ["PAR_Grp_ID","1"];
_squad = (units GRLIB_side_friendly) select {(_x getVariable ["PAR_Grp_ID","0"]) == _pid};
if (count _squad > 1) then {
    {
        if ( !(_x in units _player) ) then {
            if ( count (units _player) < (GRLIB_squad_size + _extra_units) ) then { 
                [_x] joinSilent _player;
                sleep 0.2;
            };
        };
    } forEach _squad;
    private _msg = format ["Server recover %1 AI in %2 Team", count _squad, name _player];
    [gamelogic, _msg] remoteExec ["globalChat",  owner _player];
};
[group _player, _player] remoteExec ["selectLeader", owner _player];
