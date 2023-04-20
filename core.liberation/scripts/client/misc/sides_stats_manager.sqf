waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };
private ["_msg", "_sector", "_opf", "_default"];
private	_cleanup_counter = 0;

while { true } do {
	_sector = [(allMapMarkers select {_x select [0,12] == "side_mission" && markerPos _x distance2D player <= GRLIB_capture_size}), player] call F_nearestPosition;
	if (typeName _sector == "STRING") then {
		_opf = 0;
		_msg = "";

		// Resistance
		if ( _sector find "Resistance" > 0 && !isnil "GRLIB_A3W_Mission_MR" && !isnil "GRLIB_A3W_Mission_MRR" ) then {
			{_opf = _opf + count (units _x select {alive _x})} forEach GRLIB_A3W_Mission_MR;
			_res = count (units GRLIB_A3W_Mission_MRR select {alive _x});
			_msg = format ["Status:\nResistance: %1\nEnemy squad: %2", _res, _opf];
		};

		// Delivery
		if ( _sector find "A3W_Mission_SD" > 0 && !isnil "GRLIB_A3W_Mission_SD" ) then {
			_last_man = GRLIB_A3W_Mission_SD select (count GRLIB_A3W_Mission_SD) - 1;
			_opf = [(getPos _last_man) nearEntities ["Man", (GRLIB_sector_size/2)], {(alive _x) && (side _x == GRLIB_side_enemy)}] call BIS_fnc_conditionalSelect;
			if (count _opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", count _opf]};
		};

		_default = false;
		_side_name = ["Invasion", "Cache", "Wreck", "Capture"];
		{if ( (_sector find _x) > 0 ) exitwith {_default = true}} forEach _side_name;
		if ( _default ) then {
			_opf = [(getMarkerPos _sector) nearEntities ["Man", (GRLIB_sector_size/2)], {(alive _x) && (side _x == GRLIB_side_enemy)}] call BIS_fnc_conditionalSelect;
			if (count _opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", count _opf]};
		};

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