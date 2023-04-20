// A custom Arsenal for Liberation RX
// from: https://github.com/LarrowZurb/BlacklistArsenal
// Directly call by init box "myLARsBox"

if (isDedicated) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_limited_arsenal"};
if (!GRLIB_enable_arsenal) exitWith { removeAllActions myLARsBox };

//Blacklist - no Thermic
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\liberationBlacklist.sqf";

//[ myBox, [ whitelist, blacklist ], targets, name, condition ] call LARs_fnc_blacklistArsenal;
[_this, [GRLIB_side_friendly, "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
waitUntil {sleep 0.5; !(isNil "LARs_initBlacklist")};

//[ box, arsenalName, [ white, black ], _targets ] call LARs_fnc_updateArsenal
[_this, "Liberation", ["GRLIB_whitelisted_from_arsenal"], false] call LARs_fnc_updateArsenal;
