private ["_marker", "_nextbase", "_nextvehicle", "_nextmarker", "_sector_pos", "_close_sectors", "_opfor_sectors"];

waitUntil {sleep 1; !isNil "GRLIB_init_server"};

private _getMarkerType = {
	params ["_marker"];
	if (_marker in sectors_capture) exitWith { "n_art" };
	if (_marker in sectors_tower) exitWith { "loc_Transmitter" };
	if (_marker in sectors_factory) exitWith { "loc_Fuelstation" };
	if (_marker in sectors_military) exitWith { "o_support" };
	if (_marker in sectors_bigtown) exitWith { "n_service" };
	"n_art";
};

private _vehicle_unlock_markers = [];
private _cfg = configFile >> "cfgVehicles";
if (!GRLIB_hide_opfor) then {
	{
		_nextvehicle = _x select 0;
		_nextbase = _x select 1;
		_marker = createMarkerLocal [format ["vehicleunlockmarker%1",_nextbase], [ markerpos _nextbase select 0, (markerpos _nextbase select 1) + 125]];
		_marker setMarkerTextLocal ( getText (_cfg >> _nextvehicle >> "displayName") );
		_marker setMarkerTypeLocal "mil_pickup";
		_marker setMarkerColor GRLIB_color_enemy;
		_vehicle_unlock_markers pushback [ _marker, _nextbase ];
	} foreach GRLIB_vehicle_to_military_base_links;
};

private _sector_count = -1;
private _dist = 0;
sleep 5;

while { GRLIB_endgame == 0 } do {
	waitUntil {sleep 1; (count blufor_sectors + count GRLIB_all_fobs) != _sector_count};
	opfor_sectors = (sectors_allSectors - blufor_sectors);

	if (GRLIB_hide_opfor && count opfor_sectors > 3 && !GRLIB_Commander_mode) then {
		{
			_sector_pos = markerPos _x;
			_close_sectors = (blufor_sectors select { (markerPos _x) distance2D _sector_pos < GRLIB_radiotower_size });
			_close_sectors append (GRLIB_all_fobs select { _x distance2D _sector_pos < GRLIB_radiotower_size });
			if (count _close_sectors > 0) then {
				_x setMarkerTypeLocal ([_x] call _getMarkerType);
				_x setMarkerColor GRLIB_color_enemy;
			} else {
				_x setMarkerType "Empty";
			};
		} foreach opfor_sectors;
		{
			_x setMarkerTypeLocal ([_x] call _getMarkerType);
			_x setMarkerColor GRLIB_color_friendly;
		} foreach blufor_sectors;
	} else {
		{
			_x setMarkerTypeLocal ([_x] call _getMarkerType);
			_x setMarkerColor GRLIB_color_enemy;
		} foreach opfor_sectors;
		{
			_x setMarkerTypeLocal ([_x] call _getMarkerType);
			_x setMarkerColor GRLIB_color_friendly;
		} foreach blufor_sectors;
	};

	if (count _vehicle_unlock_markers > 0) then {
		{
			if ((_x select 1) in blufor_sectors) then {
				(_x select 0) setMarkerColor GRLIB_color_friendly;
			} else {
				(_x select 0) setMarkerColor GRLIB_color_enemy;
			};
		} foreach _vehicle_unlock_markers;
	};
	_sector_count = (count blufor_sectors + count GRLIB_all_fobs);
};