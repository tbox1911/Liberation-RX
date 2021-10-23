if (!isServer && hasInterface) exitWith {};
params ["_player"];

if (isNil "_player") exitWith {};

// HCI Command IA
hcRemoveAllGroups _player;
if ( _player == [] call F_getCommander ) then {
	private _myveh = [vehicles, {
		(_x distance lhd) >= 1000 &&
		[_player, _x] call is_owner &&
		_x getVariable ["GRLIB_vehicle_manned", false] &&
		count (crew _x) > 0
	}] call BIS_fnc_conditionalSelect;

	{ _player hcSetGroup [group _x] } foreach _myveh;
};
private _grp = _player getVariable ["my_squad", nil];
if (!isNil "_grp") then { _player hcSetGroup [_grp] };
{_player hcSetGroup [group _x]} forEach ([vehicles, {(typeOf _x) in uavs && [_player, _x] call is_owner}] call BIS_fnc_conditionalSelect);

// IA Recall
private _grp = group _player;
private _squad = allUnits select {(_x getVariable ["PAR_Grp_ID","0"]) == (_player getVariable ["PAR_Grp_ID","1"])};
{
	if ( !(_x in units _grp) ) then {
		if ( count (units _grp) < (GRLIB_squad_size + GRLIB_squad_size_bonus) ) then { [_x] joinSilent _grp};
		sleep 0.2;
	};
} forEach _squad;
