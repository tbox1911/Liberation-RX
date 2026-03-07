params ["_pos", "_side", ["_radius", GRLIB_radiotower_size]];

private _towers = (sectors_tower - blufor_sectors);
if (_side == GRLIB_side_friendly) then { _towers = (sectors_tower - opfor_sectors) };

_towers = _towers select { (markerPos _x) distance2D _pos <= _radius };
if (count _towers == 0) exitWith { "" };

if (count _towers > 1) then {
	_towers = [_towers, [_pos], {(markerPos _x) distance2D _input0}, 'ASCEND'] call BIS_fnc_sortBy;
};

(_towers select 0);
