params [ "_unit", "_unit_owner" ];

private _yield = 6;
if ( (typeof _unit) in all_resistance_troops ) then { _yield = 3 };
if ( (typeof _unit) == pilot_classname ) then { _yield = 30 };
if ( rank _unit == "COLONEL") then { _yield = 50 };
_yield = _yield + (round (random _yield));

resources_intel = resources_intel + _yield;
publicVariable "resources_intel";
stats_prisonners_captured = stats_prisonners_captured + 1;
publicVariable "stats_prisonners_captured";

[ 0 ] remoteExec ["remote_call_intel", 0];

if (isPlayer _unit_owner) then {
	private _bonus = 10;
	if ( [_unit_owner] call F_getScore > GRLIB_perm_log) then { _bonus = 5 };
	if ( (typeof _unit) == pilot_classname ) then { _bonus = 20 };
	if ( rank _unit == "COLONEL") then { _bonus = 50 };
	_bonus = _bonus + (round (random _bonus));
	[_unit_owner, _bonus] call F_addScore;
	private _msg = format ["Well done %1!\n\nIntel Stars + %2\nBonus Score + %3 XP", name _unit_owner, _yield, _bonus];
	[_msg] remoteExec ["hint", owner _unit_owner];
};
