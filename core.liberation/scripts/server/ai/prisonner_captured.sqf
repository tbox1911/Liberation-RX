params [ "_unit", "_unit_owner" ];
private _resistance_prisonner_intel_yield = 5;
private _csat_prisonner_intel_yield = 10;

private _yield = _csat_prisonner_intel_yield;
if ( ( typeof _unit ) in all_resistance_troops ) then {
	_yield = _resistance_prisonner_intel_yield;
};
resources_intel = resources_intel + _yield;
stats_prisonners_captured = stats_prisonners_captured + 1;
publicVariable "stats_prisonners_captured";

[ 0 ] remoteExec ["remote_call_intel", 0];

if (isPlayer _unit_owner) then {
	{
		[getPlayerUID _x, prisoner_score] remoteExec ["F_addPlayerScore", 2];
		[getPlayerUID _x, prisoner_ammo] remoteExec ["F_addPlayerAmmo", 2];
	} forEach allPlayers;
	
	_msg = format ["%1 brought in a prisoner. %2 rank and %3 ammo for everybody.", name _unit_owner, prisoner_score, prisoner_ammo];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
		
	/*
	private _bonus = 5;
	if ( score _unit_owner <= GRLIB_perm_log) then { _bonus = 10 };
	[_unit_owner, _bonus] remoteExec ["addScore", 2];
	
	_unit_owner setVariable ["GREUH_ammo_count", ( (_unit_owner getVariable ["GREUH_ammo_count", 0]) + _bonus ), true];
	
	private _msg = format ["%1\nBonus Score + %2 Pts!", name _unit_owner, _bonus];
	[_msg] remoteExec ["hint", owner _unit_owner];
	*/
};
