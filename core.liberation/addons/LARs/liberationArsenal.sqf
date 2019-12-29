// A blacklist for Liberation West no Thermic
// Directly call by init box "myLARsBox"

if (isDedicated) exitWith {};
waitUntil {sleep 0.5; !(isNil "GRLIB_blacklisted_from_arsenal") };

//[ myBox, [ whitelist, blacklist ], targets, name, condition ] call LARs_fnc_blacklistArsenal;
[_this, [west, GRLIB_blacklisted_from_arsenal], false, "Liberation", { true }] call LARs_fnc_blacklistArsenal;
waitUntil {sleep 0.5; !(isNil "LARs_initBlacklist")};

//[ box, arsenalName, [ white, black ], _targets ] call LARs_fnc_updateArsenal
[_this, "Liberation", [GRLIB_whitelisted_from_arsenal], false] call LARs_fnc_updateArsenal;
