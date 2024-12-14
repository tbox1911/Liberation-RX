waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "GRLIB_all_fobs"};

private _markers = [];
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

	if !(isNull GRLIB_vehicle_huron) then {
		"huronmarker" setMarkerPosLocal (getPosATL GRLIB_vehicle_huron);
	};
	sleep 3;
};
