private [ "_marker", "_nextbase", "_nextvehicle", "_nextmarker", "_sector_pos", "_nearest_sector", "_near_fob" ];

waitUntil {sleep 1; !isNil "blufor_sectors"};

private _getMarkerType = {
	params ["_marker"];
	private _type = "n_art";
	if (_marker in sectors_bigtown) then { _type = "n_service"};
	if (_marker in sectors_tower) then { _type = "loc_Transmitter"};
	if (_marker in sectors_factory) then { _type = "loc_Fuelstation"};
	if (_marker in sectors_military) then { _type = "o_support"};
	_type;
};

private _vehicle_unlock_markers = [];
private _cfg = configFile >> "cfgVehicles";
if (!GRLIB_hide_opfor) then {
	{
		_nextvehicle = _x select 0;
		_nextbase = _x select 1;
		_marker = createMarkerLocal [format ["vehicleunlockmarker%1",_nextbase], [ markerpos _nextbase select 0, (markerpos _nextbase select 1) + 125]];
		_marker setMarkerTextLocal ( getText (_cfg >> _nextvehicle >> "displayName") );
		_marker setMarkerColorLocal GRLIB_color_enemy;
		_marker setMarkerTypeLocal "mil_pickup";
		_vehicle_unlock_markers pushback [ _marker, _nextbase ];
	} foreach GRLIB_vehicle_to_military_base_links;
};

private _sector_count = -1;
private _dist = 0;
sleep 1;

while { GRLIB_endgame == 0 } do {
	waitUntil {sleep 1; GRLIB_MapOpen && (count blufor_sectors + count GRLIB_all_fobs) != _sector_count};

	if (GRLIB_hide_opfor && count opfor_sectors > 3) then {
		{
			_sector_pos = markerPos _x;
			_dist = [_sector_pos, false] call F_getNearestBluforObjective select 1;
			if (_dist <= GRLIB_radiotower_size) then {
				_x setMarkerColorLocal GRLIB_color_enemy;
				_x setMarkerTypeLocal ([_x] call _getMarkerType);
			} else {
				_x setMarkerTypeLocal "Empty";
			};
		} foreach opfor_sectors;
		{
			_x setMarkerColorLocal GRLIB_color_friendly;
			_x setMarkerTypeLocal ([_x] call _getMarkerType);
		} foreach blufor_sectors;
	} else {
		{
			_x setMarkerColorLocal GRLIB_color_enemy;
			_x setMarkerTypeLocal ([_x] call _getMarkerType);
		} foreach opfor_sectors;
		{
			_x setMarkerColorLocal GRLIB_color_friendly;
			_x setMarkerTypeLocal ([_x] call _getMarkerType);
		} foreach blufor_sectors;
	};

	{
		_nextmarker = _x;
		(_nextmarker select 0) setMarkerColorLocal GRLIB_color_enemy;
		{
			if ( _x == (_nextmarker select 1) ) exitWith { (_nextmarker select 0) setMarkerColorLocal GRLIB_color_friendly; };
		} foreach blufor_sectors;
	} foreach _vehicle_unlock_markers;

	_sector_count = (count blufor_sectors + count GRLIB_all_fobs);
	sleep 4;
};