params ["_type", ["_sector", ""]];

private _ret = 0;
if (_sector == "") then {
    _ret = {(getObjectType _x >= 8) && (_x distance2D lhd > GRLIB_fob_range) && (_x distance2D ([_x] call F_getNearestFob) > GRLIB_fob_range) && (isNull attachedTo _x)} count (entities [[_type], [], false, true]);
} else {
    _ret = {(getObjectType _x >= 8) && (_x distance2D (markerPos _sector) <= GRLIB_sector_size) && (isNull attachedTo _x)} count (entities [[_type], [], false, true]);
};
_ret;