// Mission spawn trop proche d'un secteur capture
params ['_markers'];
private _list=[];
private _radius = (GRLIB_sector_size * 0.85);

{
	private _item = true;
	private _position = getMarkerPos (_x select 0);
	{
		private _markpos = getMarkerPos _x;
		//if (getMarkerPos _x distance _position <= 500) exitWith {_item = false};
		if ((_position distance2D _markpos) <= _radius || (_position distance2D ([_position] call F_getNearestFob)) <= _radius) exitWith {_item = false};
	} forEach blufor_sectors;
	if (_item) then {_list pushback _x};
} forEach _markers;

_list;
