private ["_msg", "_all_sectors", "_sector", "_opf", "_res", "_default"];
private	_cleanup_counter = 0;

while { true } do {
	_msg = "";
	_all_sectors = (allMapMarkers select {_x select [0,12] == "side_mission" && ((markerPos _x) distance2D player) <= GRLIB_capture_size});
	_sector = [_all_sectors, player] call F_nearestPosition;
	if (_sector != "") then {
		_default = true;
		_opf = 0;

		// Resistance
		if ( _sector find "Resistance" > 0 && !isNil "GRLIB_A3W_Mission_MR") then {
			{_opf = _opf + count (units _x select {alive _x})} forEach GRLIB_A3W_Mission_MR;
			_res = count (units GRLIB_side_friendly select { alive _x && (_x distance2D (markerPos _sector) <= GRLIB_capture_size) && (_x getVariable ["GRLIB_A3W_Mission_MR1", false])});
			_msg = format ["Status:\nResistance: %1\nEnemy squad: %2", _res, _opf];
			_default = false;
		};

		// Others
		if ( _default ) then {
			_opf = (units GRLIB_side_enemy) select {(alive _x) && (_x distance2D (markerPos  _sector) < GRLIB_capture_size)};
			if (count _opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", count _opf]};
		};
	};

	// Special Delivery
	if ( !isNil "GRLIB_A3W_Mission_SD" ) then {
		_res = (GRLIB_A3W_Mission_SD select 1) select 3;
		_opf = (units GRLIB_side_enemy) select {(alive _x) && (_x distance2D _res < GRLIB_capture_size)};
		if (count _opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", count _opf]};
	};

	if (_msg != "") then {
		hintSilent _msg;
		_cleanup_counter = 2;
	};

	if (underwater vehicle player && _msg != "") then {
		hintSilent format ["Oxygen Remaining: %1%2", round(100 * getOxygenRemaining player), "%"];
		_cleanup_counter = 2;
	};

	if (_cleanup_counter > 0) then {
		_cleanup_counter = _cleanup_counter - 1;
		if (_cleanup_counter == 0) then { hintSilent "" };
	};

	sleep 5;
};