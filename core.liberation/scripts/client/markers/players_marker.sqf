private _players_markers = [];
private _markertype = "EmptyIcon";

while {true} do {
	disableMapIndicators [false,true,false,false];
	waitUntil { sleep 1; show_teammates };
	disableMapIndicators [true,true,false,false];

	while { show_teammates } do {
		waitUntil {sleep 0.1; (visibleMap || dialog)};

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
					private _color = GRLIB_color_friendly;
					if (player == _nextunit) then { _color = GRLIB_color_friendly_bright };
					if (side group _nextunit == GRLIB_side_civilian) then { _color = GRLIB_color_civilian };
					_nextmarker setMarkerColorLocal _color;
					_nextmarker setMarkerDirLocal (getDir _nextunit);
					_nextmarker setMarkerAlphaLocal 1;
				};
 			} else {
				if (_nextunit getVariable ["PAR_busy", false]) then {
					_nextmarker setMarkerTextLocal format ["Medic. %1", name _nextunit];
				} else {
					_nextmarker setMarkerTextLocal format ["%1. %2", [_nextunit] call F_getUnitPositionId, name _nextunit];
				};
				if ([_nextunit] call PAR_is_wounded) then {
					_nextmarker setMarkerTypeLocal "MinefieldAP";
					private _color = GRLIB_color_enemy;
					if (_groupunit) then { _color = GRLIB_color_enemy_bright };
					_nextmarker setMarkerColorLocal _color;
				} else {
					_nextmarker setMarkerTypeLocal "mil_triangle";
					private _color = GRLIB_color_friendly;
					if !(_nextunit getVariable ["GRLIB_is_prisoner", true]) then { _color = GRLIB_color_civilian }
					else {
						if (_groupunit) then {
							_color = GRLIB_color_friendly_bright;
							if (side group _nextunit == GRLIB_side_civilian) then { _color = GRLIB_color_civilian };
						} else {
							_color = GRLIB_color_friendly;
							if (side group _nextunit == GRLIB_side_civilian) then { _color = "ColorGUER" };
						};
					};
					_nextmarker setMarkerColorLocal _color;
				};
			};
		} foreach (_players_list + _player_medics);

		{ deleteMarkerLocal _x } foreach (_players_markers - _players_markers_bak);
		_players_markers = _players_markers_bak;
	};
	sleep 1;
};
