if (!isServer && hasInterface) exitWith {};
params ["_player"];

waitUntil {sleep 0.2; !isNil {_player getVariable ["PAR_Grp_ID", nil]}};

 // HCI Command IA
hcRemoveAllGroups _player;
if ( _player == ([] call F_getCommander) ) then {
	private _myveh = [vehicles, {
		!([_x, "LHD", GRLIB_sector_size] call F_check_near) &&
		[_player, _x] call is_owner &&
		_x getVariable ["GRLIB_vehicle_manned", false] &&
		count (crew _x) > 0
	}] call BIS_fnc_conditionalSelect;

	{ _player hcSetGroup [group _x] } foreach _myveh;
};

private _grp = _player getVariable ["my_squad", nil];
if (!isNil "_grp") then { _player hcSetGroup [_grp] };
{_player hcSetGroup [group _x]} forEach ([vehicles, {(typeOf _x) in uavs && [_player, _x] call is_owner}] call BIS_fnc_conditionalSelect);

// Recover Squad
[_player, getPlayerUID _player] spawn load_context;
