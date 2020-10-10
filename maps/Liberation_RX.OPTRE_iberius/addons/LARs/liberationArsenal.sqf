// A blacklist for Liberation West no Thermic
// Directly call by init box "myLARsBox"

if (isDedicated) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_limited_arsenal"};
if (!GRLIB_enable_arsenal) exitWith { removeAllActions myLARsBox };

//Blacklist
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\liberationBlacklist.sqf";

//[ myBox, [ whitelist, blacklist ], targets, name, condition ] call LARs_fnc_blacklistArsenal;
[_this, [GRLIB_whitelisted_from_arsenal, GRLIB_blacklisted_from_arsenal], false, "Liberation", { true }] call LARs_fnc_blacklistArsenal;

