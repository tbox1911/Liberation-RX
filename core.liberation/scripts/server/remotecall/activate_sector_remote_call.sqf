params ["_unit", "_sector"];

if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};

if (alive _unit && [_unit] call F_getCommander && _sector in GRLIB_AvailAttackSectors) then {
    GRLIB_IsVoteInProgress = false;
    [_sector] call start_sector;
};
