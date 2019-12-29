waituntil {sleep 1;!isNull player};
private ["_msg", "_pos", "_sector", "_opf", "_default"];
while { true } do {
	_pos = getPos player;
	_sector = (allMapMarkers select {_x select [0,13] == "side_mission_" && (getMarkerPos _x) distance2D _pos < (GRLIB_sector_size/2)}) select 0;

	if (!isnil "_sector") then {
		_text = markerText _sector;
		_opf = 0;
		_msg = "";
		if ( _text find "Resistance" > 0 && !isnil "GRLIB_A3W_Mission_MR" && !isnil "GRLIB_A3W_Mission_MRR" ) then {
			{_opf = _opf + count (units _x select {alive _x})} forEach GRLIB_A3W_Mission_MR;
			_res = count (units GRLIB_A3W_Mission_MRR select {alive _x});
			_msg = format ["Status:\nResistance: %1\nEnemy squad: %2", _res, _opf];
		};

		_default = false;
		_side_name = ["Invasion", "Cache", "Wreck"];
		{if ( (_text find _x) > 0 ) exitwith {_default = true}} forEach _side_name;
		if ( _default ) then {
			_opf = [(getMarkerPos _sector) nearEntities ["Man", (GRLIB_sector_size/2)], {(alive _x) && (side _x == GRLIB_side_enemy)}] call BIS_fnc_conditionalSelect;
			_msg = format ["Status:\nEnemy squad: %1", count (_opf)];
		};

		hintSilent _msg;
	};
	sleep 3;
};