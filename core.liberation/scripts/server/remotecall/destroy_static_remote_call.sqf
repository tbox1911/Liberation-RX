if (!isServer && hasInterface) exitWith {};
params ["_unit", "_vehicle"];

private _bounty = [_unit] call F_getBounty;
[typeOf _vehicle, _bounty, _unit] remoteExec ["remote_call_ammo_bounty", 0];
[_unit, (_bounty select 0), 0] call ammo_add_remote_call;
[_unit, (_bounty select 1)] call F_addScore;

_vehicle setHitPointDamage ["HitHull", 1];
_vehicle setDamage [1, true, _unit];
