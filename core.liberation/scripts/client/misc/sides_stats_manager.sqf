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
		if (_mission == "STR_RESISTANCE" && !isNil "GRLIB_A3W_Mission_MR_OPFOR") then {
			_opf = { alive _x && _x distance2D (markerPos _sector) < (GRLIB_sector_size * 2) } count GRLIB_A3W_Mission_MR_OPFOR;
			_res = { alive _x && _x distance2D (markerPos _sector) < GRLIB_sector_size } count GRLIB_A3W_Mission_MR_BLUFOR;
			if (_opf > 0) then {_msg = format ["Status:\nResistance: %1\nEnemy squad: %2", _res, _opf]};
		};

		// Others
		if (_mission in _stats_marker) then {
			_opf = { alive _x && _x distance2D (markerPos _sector) < GRLIB_sector_size && !(isNil {_x getVariable "GRLIB_mission_AI"})} count (units GRLIB_side_enemy);
			if (_opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", _opf]};
		};
	};

	// Special Delivery
	if ( !isNil "GRLIB_A3W_Mission_SD" ) then {
		_res = (GRLIB_A3W_Mission_SD select 1) select 3;
		if (player distance2D _res < GRLIB_capture_size) then {
			_opf = { alive _x && _x distance2D _res < GRLIB_sector_size && !(isNil {_x getVariable "GRLIB_mission_AI"})} count (units GRLIB_side_enemy);
			if (_opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", _opf]};
		};
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