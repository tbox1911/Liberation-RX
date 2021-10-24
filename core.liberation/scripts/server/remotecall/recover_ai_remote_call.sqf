if (!isServer && hasInterface) exitWith {};
params ["_player", "_extra_units"];
if (isNil "_player") exitWith {};
private ["_grp", "_pid", "_squad", "_myveh"];

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
_grp = group _player;
_pid = _player getVariable ["PAR_Grp_ID","1"];
_squad = allUnits select {(_x getVariable ["PAR_Grp_ID","0"]) == _pid};
if (count _squad > 2) then {
    diag_log format ["--- LRX Recover Player %1 AIs (%2)", name _player, count _squad];
    {
        if ( !(_x in units _grp) ) then {
            if ( count (units _grp) < (GRLIB_squad_size + _extra_units) ) then { 
                [_x] joinSilent _grp;
                sleep 0.2;
            };
        };
    } forEach _squad;
};
_grp selectLeader _player;
