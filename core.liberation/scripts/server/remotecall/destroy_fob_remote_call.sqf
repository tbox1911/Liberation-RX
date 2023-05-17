if (!isServer && hasInterface) exitWith {};
params [ "_fob_pos" ];

[_fob_pos, 5] remoteExec ["remote_call_fob", 0];
sleep 2;
[_fob_pos] call destroy_fob;
