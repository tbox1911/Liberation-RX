if (!isServer && hasInterface) exitWith {};

params [ "_thispos" ];

[_thispos, 2] remoteExec ["remote_call_fob", 0];
sleep 2;
[_thispos] spawn destroy_fob;

GRLIB_all_fobs = GRLIB_all_fobs - [_thispos];
publicVariable "GRLIB_all_fobs";

stats_fobs_lost = stats_fobs_lost + 1;