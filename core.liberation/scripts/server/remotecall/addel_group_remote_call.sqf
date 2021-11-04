if (!isServer && hasInterface) exitWith {};
params ["_group", "_action"];

if (isNull _group) exitWith {};
if (isNil "global_locked_group") then { global_locked_group = [] };

private _tmp_global_locked_group = [];
{
	if (!isNil "_x") then {
		if (!isNull _x && typeName _x == "GROUP" && count (units _x) > 0) then {
			_tmp_global_locked_group pushBack _x;
		};
	};
} foreach global_locked_group;

switch (_action) do {
	case "add" : {global_locked_group = _tmp_global_locked_group + [_group]};
	case "del" : {global_locked_group = _tmp_global_locked_group - [_group]};
	default {global_locked_group = _tmp_global_locked_group};
};

publicVariable "global_locked_group";