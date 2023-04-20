params ["_type", ["_sector", objNull]];

private _ret = 0;
if (isNull _sector) then {
    _ret = {(_x distance2D lhd > GRLIB_fob_range)} count (entities [[_type], [], false, true]);
} else {
    _ret = {(_x distance2D lhd > GRLIB_fob_range) && (_x distance2D (markerPos _sector) <= GRLIB_sector_size)} count (entities [[_type], [], false, true]);
};
_ret;