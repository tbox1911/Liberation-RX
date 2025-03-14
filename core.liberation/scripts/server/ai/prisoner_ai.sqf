params ["_unit", ["_friendly", false], ["_canmove", false]];

if (isNull _unit) exitWith {};
if !(isNull objectParent _unit) exitWith {};
if (_unit getVariable ["GRLIB_is_prisoner", false]) exitWith {};
if (surfaceIsWater (getPosATL _unit)) exitWith {};

sleep 3;
if (!alive _unit) exitWith {};

// Check locality
if (!local _unit) exitWith { [_unit, _friendly, _canmove] remoteExec ["prisoner_remote_call", 2] };

// Init priso
private _grp = createGroup [GRLIB_side_civilian, true];
[_unit] joinSilent _grp;

doStop _unit;
removeAllWeapons _unit;
//removeHeadgear _unit;
removeBackpack _unit;
removeVest _unit;
private _hmd = (hmd _unit);
_unit unassignItem _hmd;
_unit removeItem _hmd;
_unit setVariable ["GRLIB_can_speak", true, true];
_unit removeAllEventHandlers "HandleDamage";
_unit removeAllEventHandlers "GetInMan";
_unit removeAllEventHandlers "SeatSwitchedMan";
_unit removeAllEventHandlers "Take";
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
_unit setCaptive true;
[_unit] call F_fixPosUnit;

if (!_canmove) then {
	// Halt
	[_unit, "init"] remoteExec ["remote_call_prisoner", 0];
	sleep 7;
};

if (!alive _unit) exitWith {};
_unit setVariable ["GRLIB_is_prisoner", true, true];

// Wait
if (!_canmove) then {
	if (_friendly) then {
		waitUntil { sleep 1; (!alive _unit || side group _unit == GRLIB_side_friendly) };
	} else {
		private _timeout = (time + (30 * 60));
		waitUntil { sleep 1; (!alive _unit || side group _unit == GRLIB_side_friendly || time > _timeout) };
	};
	// Follow
	[_unit, "move"] remoteExec ["remote_call_prisoner", 0];
	sleep 3;
};

if (!alive _unit) exitWith {};

// Priso loop
if (isServer) then {
	[_unit, _friendly] spawn prisoner_ai_loop;
} else {
	[_unit, _friendly] remoteExec ["prisoner_ai_loop", 2];
};