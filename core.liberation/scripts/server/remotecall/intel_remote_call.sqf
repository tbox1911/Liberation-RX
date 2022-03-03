if (!isServer && hasInterface) exitWith {};
params [ "_intel_object", "_unit_owner" ];
if ( isNil "_intel_object" ) exitWith {};

_intel_yield = 8;
deleteVehicle _intel_object;
resources_intel = resources_intel + (floor (_intel_yield + (random _intel_yield)));

[ 1 ] remoteExec ["remote_call_intel", 0];

if (isPlayer _unit_owner) then {
	private _bonus = 5;
	[_unit_owner, _bonus] remoteExec ["addScore", 2];
	
	_unit_owner setVariable ["GREUH_ammo_count", ( (_unit_owner getVariable ["GREUH_ammo_count", 0]) + _bonus ), true];
	
	private _msg = format ["%1\nBonus Score + %2 Pts!", name _unit_owner, _bonus];
	[_msg] remoteExec ["hint", owner _unit_owner];
};
