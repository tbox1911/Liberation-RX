private _players_markers = [];
private _vehicles_markers = [];
private _markertype = "emptyicon";

while { true } do {

	disableMapIndicators [false,true,false,false];
	waitUntil { sleep 1; show_teammates };
	disableMapIndicators [true,true,false,false];

	while { show_teammates } do {
		waitUntil {sleep 1; GRLIB_MapOpen };

		// Players and units
		private _marked_players_bak = [];
		private _players_list = (units GRLIB_side_friendly - units group chimeraofficer) select { alive _x && isNull objectParent _x };
		{
			private _nextunit = _x;
			private _nextmarker = format ["playermarker_%1", (_nextunit call BIS_fnc_netId)];
			// in cache ?
			if (_players_markers find _nextmarker < 0) then {
				_marker = createMarkerLocal [_nextmarker, getPosATL _nextunit];
				if (isPlayer _nextunit) then {
					_marker setMarkerTextLocal ([_nextunit] call get_player_name);
					_marker setMarkerSizeLocal [ 0.75, 0.75 ];
					_marker setMarkerTypeLocal "mil_start";
				} else {
					_marker setMarkerSizeLocal [ 0.6, 0.6 ];
				};
				_marker setMarkerColorLocal GRLIB_color_friendly;
				_marked_players_bak pushback _marker;
			} else {
				_nextmarker setMarkerPosLocal (getPosATL _nextunit);
				_marked_players_bak pushback _nextmarker;
			};
 			if (isPlayer _nextunit) then {
				_nextmarker setMarkerDirLocal (getDir _nextunit);
 			} else {
				_nextmarker setMarkerTextLocal format ["%1. %2", [_nextunit] call F_getUnitPositionId, name _nextunit];
				if (_nextunit getVariable ["PAR_isUnconscious", false]) then {
					_nextmarker setMarkerTypeLocal "MinefieldAP";
					_nextmarker setMarkerColorLocal GRLIB_color_enemy_bright;
				} else {
					_nextmarker setMarkerTypeLocal "mil_triangle";
					_nextmarker setMarkerColorLocal GRLIB_color_friendly;
				};
			};
		} foreach _players_list;

		{ deleteMarkerLocal _x } foreach (_players_markers - _marked_players_bak);
		_players_markers = _marked_players_bak;

		// Vehicles
		private _vehicles_markers_bak = [];
		private _vehicles_list = vehicles select {
			(alive _x) && !(isObjectHidden _x) &&
			(count (crew _x) > 0) && (side _x == GRLIB_side_friendly) &&
			!(typeOf _x in (uavs + static_vehicles_AI))
		};
		{
			private _nextvehicle = _x;
			private _nextmarker = format ["vehiclemarker_%1", (_nextvehicle call BIS_fnc_netId)];
			// in cache ?
			if (_vehicles_markers find _nextmarker < 0) then {
				_marker = createMarkerLocal [_nextmarker, getPosATL _nextvehicle];
				_marker setMarkerTypeLocal "mil_arrow2";
				_marker setMarkerSizeLocal [0.75,0.75];
				_marker setMarkerColorLocal GRLIB_color_friendly;
				_vehicles_markers_bak pushback _marker;
			} else {
				_nextmarker setMarkerPosLocal (getPosATL _nextvehicle);
				_vehicles_markers_bak pushback _nextmarker;
			};

			private _datcrew = crew _nextvehicle;
			private _vehiclename = "";
			{
				if (isPlayer _x) then {
					_vehiclename = _vehiclename + (name _x);
				} else {
					_vehiclename = _vehiclename + (format [ "%1", [_x] call F_getUnitPositionId]);
				};

				if( (_datcrew find _x) != ((count _datcrew) - 1) ) then {
					_vehiclename = _vehiclename + ",";
				};
				_vehiclename = _vehiclename + " ";
			} foreach  _datcrew;
			_vehiclename = _vehiclename + "(" + ([_nextvehicle] call F_getLRXName) + ")";
			_nextmarker setMarkerTextLocal _vehiclename;
			_nextmarker setMarkerDirLocal (getDir _nextvehicle);
		} foreach _vehicles_list;

		{ deleteMarkerLocal _x } foreach (_vehicles_markers - _vehicles_markers_bak);
		_vehicles_markers = _vehicles_markers_bak;
	};

	sleep 1;
};
