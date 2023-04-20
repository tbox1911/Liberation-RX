private [ "_marker", "_nextgroup" ];
if (GRLIB_fancy_info == 0) exitWith {};

waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1;	!isNil "blufor_sectors"};
private _hostile_markers = [];

while { true } do {
	{ deleteMarkerLocal _x } foreach _hostile_markers;
	_hostile_markers = [];

	{
		_nextgroup = _x;
		if (side _nextgroup == GRLIB_side_enemy) then {
			if ( [(getpos leader _nextgroup), GRLIB_side_friendly, GRLIB_radiotower_size] call F_getNearestTower != "" ) then {
				_marker = createMarkerLocal [format ["hostilegroup%1",_x], markers_reset];
				_marker setMarkerColorLocal GRLIB_color_enemy_bright;
				_marker setMarkerTypeLocal "mil_warning";
				_marker setMarkerSizeLocal [0.65, 0.65];
				_marker setMarkerPosLocal ([getPosATL (leader _nextgroup), floor(random 50), floor(random 360)] call BIS_fnc_relPos);
				_hostile_markers pushback _marker;
			};
		};
	} foreach allGroups;

	sleep (30 + floor(random 60));
};