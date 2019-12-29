_intel_obj = _this select 3;
if (isNull _intel_obj) exitWith {};
[ [ _intel_obj ] , "intel_remote_call" ] call BIS_fnc_MP;