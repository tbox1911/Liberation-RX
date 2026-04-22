params [ "_unit", "_unit_owner", "_friendly" ];

private _intel = 6;
if (typeof _unit in militia_squad) then { _intel = 3 };
if (typeof _unit == pilot_classname) then { _intel = 12 };
resources_intel = resources_intel + _intel;
publicVariable "resources_intel";
stats_prisoners_captured = stats_prisoners_captured + 1;
publicVariable "stats_prisoners_captured";

[0, _friendly] remoteExec ["remote_call_intel", 0];

if (isPlayer _unit_owner) then {
	private _bonus = ((GRLIB_rank_level find (rank _unit)) * 7);
	if ([_unit_owner] call F_getScore > GRLIB_perm_log) then { _bonus = round (_bonus * 0.80) };
	if (typeof _unit == pilot_classname) then { _bonus = 25 };
	[_unit_owner, _bonus] call F_addScore;
	private _msg = format ["Well done %1!\n\nIntel Stars + %2\nBonus Score + %3 XP", name _unit_owner, _intel, _bonus];
	[_msg] remoteExec ["hint", owner _unit_owner];
};

sleep 300;
deleteVehicle _unit;