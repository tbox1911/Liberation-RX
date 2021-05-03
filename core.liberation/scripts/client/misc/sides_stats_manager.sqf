waituntil {sleep 1;!isNull player};
private ["_msg", "_pos", "_sector", "_opf", "_default"];
while { true } do {
	_pos = getPos player;
	_sector = [GRLIB_sector_size, _pos, sectors_missions] call F_getNearestSector;

	if (!isnil "_sector") then {
		_text = markerText _sector;
		_opf = 0;
		_msg = "";

		// Resistance
		if ( _text find "Resistance" > 0 && !isnil "GRLIB_A3W_Mission_MR" && !isnil "GRLIB_A3W_Mission_MRR" ) then {
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
		_side_name = ["Invasion", "Cache", "Wreck"];
		{if ( (_text find _x) > 0 ) exitwith {_default = true}} forEach _side_name;
		if ( _default ) then {
			_opf = [(getMarkerPos _sector) nearEntities ["Man", (GRLIB_sector_size/2)], {(alive _x) && (side _x == GRLIB_side_enemy)}] call BIS_fnc_conditionalSelect;
			if (count _opf > 0) then {_msg = format ["Status:\nEnemy squad: %1", count _opf]};
		};

		hintSilent _msg;
	};

	if (underwater vehicle player) then {
		hintSilent format ["Oxygen Remaining: %1%2", round(100 * getOxygenRemaining player), "%"];
	};
	sleep 5;
};