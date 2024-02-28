private ["_msg", "_all_sectors", "_sector", "_list", "_opf", "_res", "_mission"];
private	_cleanup_counter = 0;
private _stats_marker = [
	"STR_AIRWRECK",
	"STR_HOSTILE_OFFICER",
	"STR_OUTPOST",
	"STR_ROADBLOCK",
	"STR_SEARCH_INTEL",
	"STR_INSURGENCY",
	"STR_INVASION",
	"STR_VEHICLECAP",
	"STR_WEAPCACHE"
];

while { true } do {
	_msg = "";
	_all_sectors = (allMapMarkers select {_x select [0,13] == "side_mission_" && ((markerPos _x) distance2D player) <= GRLIB_capture_size});
	_sector = [_all_sectors, player] call F_nearestPosition;
	if (_sector != "") then {
		_mission = _sector select [13];
		_opf = 0;

		// Resistance
		if (_mission == "STR_RESISTANCE" && !isNil "GRLIB_A3W_Mission_MR") then {
			{_opf = _opf + count (units _x select {alive _x})} forEach GRLIB_A3W_Mission_MR;
			_list = (markerPos _sector) nearEntities ["CAManBase", GRLIB_capture_size];
			_res = _list select {
				side _x == GRLIB_side_friendly &&
				(_x getVariable ["GRLIB_A3W_Mission_MR1", false])
			};
			_msg = format ["Status:\nResistance: %1\nEnemy squad: %2", count _res, _opf];
		};

		// Others
		if (_mission in _stats_marker) then {
			_list = (markerPos _sector) nearEntities ["CAManBase", GRLIB_capture_size];
			_opf = _list select { side _x == GRLIB_side_enemy };
			if (count _opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", count _opf]};
		};
	};

	// Special Delivery
	if ( !isNil "GRLIB_A3W_Mission_SD" ) then {
		_res = (GRLIB_A3W_Mission_SD select 1) select 3;
		_list = _res nearEntities ["CAManBase", GRLIB_capture_size];
		_opf = _list select { side _x == GRLIB_side_enemy };
		if (count _opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", count _opf]};
	};

	if (_msg != "") then {
		hintSilent _msg;
		_cleanup_counter = 2;
	};

	if (underwater vehicle player) then {
		hintSilent format ["Oxygen Remaining: %1%2", round(100 * getOxygenRemaining player), "%"];
		_cleanup_counter = 2;
	};

	if (_cleanup_counter > 0) then {
		_cleanup_counter = _cleanup_counter - 1;
		if (_cleanup_counter == 0) then { hintSilent "" };
	};

	sleep 5;
};