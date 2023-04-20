params ["_intel_obj"];
if (isNil "_intel_obj") exitWith {};
[ _intel_obj, player ] remoteExec ["intel_remote_call", 2];