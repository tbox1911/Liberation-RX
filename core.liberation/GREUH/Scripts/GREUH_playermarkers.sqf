private _players_markers = [];
private _vehicles_markers = [];
private _markertype = "emptyicon";

while {true} do {

	disableMapIndicators [false,true,false,false];
	waitUntil { sleep 1; show_teammates };
	disableMapIndicators [true,true,false,false];

	while { show_teammates } do {
		waitUntil {sleep 0.1; visibleMap };

		// Players and units
		private _players_markers_bak = [];
		private _player_medics = (units GRLIB_side_civilian) select {
			alive _x && isNull objectParent _x &&
			(!isNil {_x getVariable "PAR_Grp_ID"})
		};
		private _players_list = (units GRLIB_side_friendly) select {
			alive _x && isNull objectParent _x &&
			(_x distance2D (markerPos GRLIB_respawn_marker) > GRLIB_capture_size) &&
			(!isNil {_x getVariable "PAR_Grp_ID"} || !isNil {_x getVariable "GRLIB_is_prisoner"})
		};

		{
			private _nextunit = _x;
			private _nextmarker = format ["playermarker_%1", (_nextunit call BIS_fnc_netId)];
			private _groupunit = (_nextunit in (units group player));
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
				_players_markers_bak pushback _marker;
			} else {
				_nextmarker setMarkerPosLocal (getPosATL _nextunit);
				_players_markers_bak pushback _nextmarker;
			};

 			if (isPlayer _nextunit) then {
				if ([_nextunit] call PAR_is_wounded) then {
					_nextmarker setMarkerAlphaLocal 0;
				} else {
					if (player == _nextunit) then {
						_nextmarker setMarkerColorLocal GRLIB_color_friendly_bright;
					};
					_nextmarker setMarkerDirLocal (getDir _nextunit);
					_nextmarker setMarkerAlphaLocal 1;
				};
 			} else {
				if (side group _nextunit == GRLIB_side_civilian) then {
					_nextmarker setMarkerTextLocal format ["Medic. %1", name _nextunit];
				} else {
					_nextmarker setMarkerTextLocal format ["%1. %2", [_nextunit] call F_getUnitPositionId, name _nextunit];
				};
				if ([_nextunit] call PAR_is_wounded) then {
					_nextmarker setMarkerTypeLocal "MinefieldAP";
					if (_groupunit) then {
						_nextmarker setMarkerColorLocal GRLIB_color_enemy_bright;
					} else {
						_nextmarker setMarkerColorLocal GRLIB_color_enemy;
					};
				} else {
					_nextmarker setMarkerTypeLocal "mil_triangle";
					if !(_nextunit getVariable ["GRLIB_is_prisoner", true]) then {
						_nextmarker setMarkerColorLocal "ColorCIV";
					} else {
						if (_groupunit) then {
							_nextmarker setMarkerColorLocal GRLIB_color_friendly_bright;
						} else {
							if (side group _nextunit == GRLIB_side_civilian) then {
								_nextmarker setMarkerColorLocal "ColorGUER";
							} else {
								_nextmarker setMarkerColorLocal GRLIB_color_friendly;
							};
						};
					};
				};
			};
		} foreach (_players_list + _player_medics);

		{ deleteMarkerLocal _x } foreach (_players_markers - _players_markers_bak);
		_players_markers = _players_markers_bak;

		// Vehicles
		private _vehicles_markers_bak = [];
		private _vehicles_list = vehicles select {
			(alive _x) && !(isObjectHidden _x) &&
			(count (crew _x) > 0) && (side _x == GRLIB_side_friendly) &&
			(isNil {_x getVariable "GRLIB_vehicle_init"}) &&
			(isNil {_x getVariable "GRLIB_mission_AI"}) &&
			!(typeOf _x in uavs_vehicles + static_vehicles_AI)
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
