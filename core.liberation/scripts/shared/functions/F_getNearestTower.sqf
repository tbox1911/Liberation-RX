params ["_postosearch", "_side", ["_limit", GRLIB_radiotower_size]];

private _sector_to_return = "";
private _sectors_to_search = (sectors_tower - blufor_sectors);
if (_side == GRLIB_side_friendly) then {
	_sectors_to_search = sectors_tower arrayIntersect blufor_sectors;
};
_sectors_to_search = _sectors_to_search select { (markerPos _x) distance2D _postosearch < _limit };
if (count _sectors_to_search == 0) exitWith { _sector_to_return };

private _sectors_to_search_sorted = [_sectors_to_search, [_postosearch], {(markerPos _x) distance2D _input0}, 'ASCEND'] call BIS_fnc_sortBy;
if (count _sectors_to_search_sorted > 0) then { _sector_to_return = _sectors_to_search_sorted select 0 };

_sector_to_return;
