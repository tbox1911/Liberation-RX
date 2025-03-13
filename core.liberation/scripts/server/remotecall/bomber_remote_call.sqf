if (!isServer && hasInterface) exitWith {};
params ["_unit", "_range"];

if (isNil "_unit") exitWith {};

if (local _unit) then {
    [_unit, _range] spawn bomber_ai;
} else {
	[_unit, _range] remoteExec ["bomber_ai", owner _unit];
};
