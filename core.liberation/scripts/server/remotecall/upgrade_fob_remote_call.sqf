if (!isServer && hasInterface) exitWith {};
params [ "_fob_pos" ];

GRLIB_all_outposts = GRLIB_all_outposts - [_fob_pos];
publicVariable "GRLIB_all_outposts";

[_fob_pos, 6] remoteExec ["remote_call_fob", 0];
