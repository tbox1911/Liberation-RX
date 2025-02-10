if (!isServer && hasInterface) exitWith {};
params ["_unit", "_friendly", "_canmove"];

if (isNil "_unit") exitWith {};

if (local _unit) then {
    [_unit, _friendly, _canmove] spawn prisoner_ai;
} else {
	[_unit, _friendly, _canmove] remoteExec ["prisoner_ai", owner _unit];
};
