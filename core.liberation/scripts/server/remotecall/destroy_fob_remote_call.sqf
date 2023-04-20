if (!isServer && hasInterface) exitWith {};

params [ "_thispos" ];

GRLIB_all_fobs = GRLIB_all_fobs - [_thispos];
publicVariable "GRLIB_all_fobs";

[_thispos] call destroy_fob;

stats_fobs_lost = stats_fobs_lost + 1;