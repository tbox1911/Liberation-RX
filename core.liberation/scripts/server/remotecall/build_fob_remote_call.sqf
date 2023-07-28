if (!isServer && hasInterface) exitWith {};
params ["_fob", "_owner"];

[_fob, _owner] call fob_init;

private _fob_pos = getPosATL _fob;
GRLIB_all_fobs pushback _fob_pos;
if (typeOf _fob == FOB_outpost) then { GRLIB_all_outposts pushBack _fob_pos };

publicVariable "GRLIB_all_fobs";
publicVariable "GRLIB_all_outposts";

[ _fob_pos, 0 ] remoteExec ["remote_call_fob", 0];
sleep 1;
stats_fobs_built = stats_fobs_built + 1;