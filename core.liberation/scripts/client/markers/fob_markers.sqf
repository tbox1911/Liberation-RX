private [ "_marker", "_idx", "_respawn_trucks", "_markers_mobilespawns", "_vehicle" ];
private _markers = [];
private _markers_mobilespawns = [];
private _markers_defense = [];

waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "GRLIB_all_fobs"};

GRLIB_redraw_marker_fob = false;
while { true } do {
	waitUntil {sleep 1; GRLIB_MapOpen };
	if ( count _markers != count GRLIB_all_fobs || GRLIB_redraw_marker_fob) then {
		GRLIB_redraw_marker_fob = false;
		{ deleteMarkerLocal _x } foreach _markers;
		_markers = [];
		{
			_fobpos = _x;
			_near_outpost = (_fobpos in GRLIB_all_outposts);
			_marker = createMarkerLocal [format ["fobmarker%1", _forEachIndex], markers_reset];
			if (_near_outpost) then {
				_marker setMarkerTypeLocal "b_support";
				_marker setMarkerSizeLocal [ 1.2, 1.2 ];
				_marker setMarkerTextLocal format ["Outpost %1",military_alphabet select _forEachIndex];
				_marker setMarkerColorLocal "ColorYellow";
			} else {
				_marker setMarkerTypeLocal "b_hq";
				_marker setMarkerSizeLocal [ 1.7, 1.7 ];
				_marker setMarkerTextLocal format ["FOB %1",military_alphabet select _forEachIndex];
				_marker setMarkerColorLocal "ColorYellow";
			};
			_marker setMarkerPosLocal _fobpos;
			_markers pushback _marker;
		} forEach GRLIB_all_fobs;
	};

	_respawn_trucks = [] call F_getMobileRespawns;
	if ( count _markers_mobilespawns != count _respawn_trucks ) then {
		{ deleteMarkerLocal _x } foreach _markers_mobilespawns;
		_markers_mobilespawns = [];
		{
			_vehicle = _x;
			_marker = createMarkerLocal [format ["mobilespawn_%1", _forEachIndex], markers_reset];
			_marker setMarkerTypeLocal "mil_end";
			_marker setMarkerColorLocal "ColorYellow";
 			_marker setMarkerPosLocal (getpos _vehicle);
			_marker setMarkerTextLocal format ["%1 %2", [_vehicle] call F_getLRXName, mapGridPosition _vehicle];			
			_markers_mobilespawns pushback _marker;
		} forEach _respawn_trucks;
	};

	if ( count _markers_defense != count GRLIB_sector_defense ) then {
		{ deleteMarkerLocal _x } foreach _markers_defense;
		{
			private _sector = (_x select 0);
			private _marker = createMarkerLocal [format ["defense_%1", _sector], (markerPos _sector)];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "loc_defend";
			_marker setMarkerColorLocal "ColorGrey";
			//_marker setMarkerSizeLocal [100, 200];
			_markers_defense pushback _marker;
		} forEach GRLIB_sector_defense;
	};

	sleep 3;
};
