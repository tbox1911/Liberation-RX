params ["_convoy_markers"];

if (count _convoy_markers == 0) exitWith {[]};

private _destinations_markers = [];
private ["_pos", "_nearestroad", "_land"];
{
	_pos = (markerPos _x);
	_nearestroad = [_pos, 200] call BIS_fnc_nearestRoad;
	_land = !(surfaceIsWater _pos);
	if (_land) then {
		if (isNull _nearestroad) then {
			_destinations_markers pushback ([_pos, 100] call F_getRandomPos);
		} else {
			_destinations_markers pushback (getpos _nearestroad);
		};
	};
} foreach _convoy_markers;

_destinations_markers;
