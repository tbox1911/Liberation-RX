waitUntil {sleep 1; !isNil "GRLIB_init_server"};
waitUntil {sleep 1; !isNil "GRLIB_all_fobs"};

private _markers = [];
private _markers_def = [];
private _markers_build = [];
GRLIB_redraw_marker_fob = true;

sleep 2;
while {true} do {
	// FOB markers
	if (count _markers != count GRLIB_all_fobs || GRLIB_redraw_marker_fob) then {
		{ deleteMarker _x } foreach _markers;
		_markers = [];
		{
			_fobpos = _x;
			_near_outpost = (_fobpos in GRLIB_all_outposts);
			_marker = createMarkerLocal [format ["fobmarker%1", mapGridPosition _fobpos], markers_reset];
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
			_marker setMarkerDrawPriority -1;
			_marker setMarkerPos _fobpos;
			_markers pushback _marker;
		} forEach GRLIB_all_fobs;
	};

	// Defended sectors markers
	if (count _markers_def != count GRLIB_sector_defense || GRLIB_redraw_marker_fob) then {
		{ deleteMarker _x } foreach _markers_def;
		_markers_def = [];
		{
			private _sector = _x;
			private _def = GRLIB_sector_defense get _sector;
			if (markerPos _sector isEqualTo [0,0,0]) then {
				[_sector, 0] call sector_defenses_remote_call;
			} else {
				private _marker = createMarkerLocal [format ["defense_%1", _sector], markers_reset];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "loc_defend";
				private _color = "ColorGrey";
				switch (_def) do {
					case 1:	{ _color = "#(0.75, 0.75, 0.75, 1.00)" };	// "ColorWhite"
					case 2:	{ _color = "#(0.50, 0.50, 0.50, 1.00)" };	// "ColorGrey"
					case 3:	{ _color = "#(0.25, 0.25, 0.25, 1.00)" };	// "ColorBlack"
				};
				_marker setMarkerColorLocal _color;
				_marker setMarkerDrawPriority 1;
				_marker setMarkerPos (markerPos _sector);
				_markers_def pushback _marker;
			};
		} forEach (keys GRLIB_sector_defense);
	};

	// Facility Buildings
	if ((round time) % 600 == 0 || GRLIB_redraw_marker_fob) then {
		{ deleteMarker _x } foreach _markers_build;
		_markers_build = [];
		{
			private _fobpos = _x;
			private _facility_buildings = [];
			_facility_buildings append (_fobpos nearObjects [Warehouse_typename, GRLIB_fob_range]);
			_facility_buildings append (_fobpos nearObjects [medic_heal_typename, GRLIB_fob_range]);
			_facility_buildings append (_fobpos nearObjects [storage_medium_typename, GRLIB_fob_range]);
			_facility_buildings append (_fobpos nearObjects [storage_large_typename, GRLIB_fob_range]);
			{
				private _bulding = _x;
				private _building_class = typeOf _bulding;
				private _color = "ColorGrey";
				private _type = "";
				private _text = [_building_class] call F_getLRXName;

				if (_building_class == medic_heal_typename) then {
					_type = "loc_Hospital";
					_color = "ColorGreen";
				};
				if (_building_class == Warehouse_typename) then {
					_type = "loc_container";
					_color = "ColorBlue";
				};
				if (_building_class in [storage_medium_typename, storage_large_typename]) then {
					_type = "loc_container";
					_color = "ColorBrown";
				};
				if (_type != "") then {
					private _marker = createMarkerLocal [format ["defense_%1", (_bulding call BIS_fnc_netId)], markers_reset];
					_marker setMarkerShapeLocal "ICON";
					_marker setMarkerTypeLocal _type;
					_marker setMarkerColorLocal _color;
					_marker setMarkerTextLocal _text;
					//_marker setMarkerDrawPriority 1;
					_marker setMarkerPos (getPosATL _bulding);
					_markers_build pushback _marker;
				};
			} forEach _facility_buildings;
		} forEach GRLIB_all_fobs;
	};

	// Hurron
	if !(isNull GRLIB_vehicle_huron) then {
		"huronmarker" setMarkerPos (getPosATL GRLIB_vehicle_huron);
	};

	GRLIB_redraw_marker_fob = false;
	publicVariable "GRLIB_redraw_marker_fob";
	sleep 3;
};
