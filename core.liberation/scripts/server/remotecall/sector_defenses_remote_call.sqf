if (!isServer && hasInterface) exitWith {};

params ["_sector", "_defense"];

if (_defense == 0) exitWith { GRLIB_sector_defense deleteAt _sector };

GRLIB_sector_defense set [_sector, _defense];

publicVariable "GRLIB_sector_defense";
