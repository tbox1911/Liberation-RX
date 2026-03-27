if (!isServer && hasInterface) exitWith {};
params ["_unit", ["_slow", true]];

if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};

if (local _unit) then {
	[_unit, _slow] spawn F_ejectUnit;
} else {
	[_unit, _slow] remoteExec ["F_ejectUnit", owner _unit];
};
