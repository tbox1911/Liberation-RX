if (!isServer && hasInterface) exitWith {};
params ["_fob", "_owner"];

[_fob, _owner] call fob_init;

private _fob_pos = getPosATL _fob;
GRLIB_all_outposts = GRLIB_all_outposts - [_fob_pos];
publicVariable "GRLIB_all_outposts";

[_fob_pos, 6] remoteExec ["remote_call_fob", 0];
