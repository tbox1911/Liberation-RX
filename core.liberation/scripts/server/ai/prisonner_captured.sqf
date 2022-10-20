params [ "_unit", "_unit_owner" ];

private _yield = 6;
if ( (typeof _unit) in all_resistance_troops ) then { _yield = 3 };
if ( (typeof _unit) == pilot_classname ) then { _yield = 30 };
if ( rank _unit == "COLONEL") then { _yield = 150 };

resources_intel = resources_intel + ( _yield + (round (random _yield)));
stats_prisonners_captured = stats_prisonners_captured + 1;
publicVariable "stats_prisonners_captured";

[ 0 ] remoteExec ["remote_call_intel", 0];

if (isPlayer _unit_owner) then {
	private _bonus = 5;
	if ( score _unit_owner <= GRLIB_perm_log) then { _bonus = 10 };
	if ( (typeof _unit) == pilot_classname ) then { _bonus = 20 };
	if ( rank _unit == "COLONEL") then { _bonus = 50 };
	[_unit_owner, _bonus] remoteExec ["addScore", 2];
	private _msg = format ["%1\nBonus Score + %2 Pts!", name _unit_owner, _bonus];
	[_msg] remoteExec ["hint", owner _unit_owner];
};
