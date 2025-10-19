params [["_full", true]];
private ["_marker"];
private _marker_debug = false;
if (!isNil "GRLIB_LRX_debug") then { _marker_debug = true };

waitUntil {sleep 1; !isNil "opfor_sectors"};

if (_full) then {
	// Game markers
	_marker = createMarkerLocal ["zone_capture", markers_reset];
	_marker setMarkerColorLocal "ColorUNKNOWN";
	_marker setMarkerShapeLocal "Ellipse";
	_marker setMarkerBrushLocal "SolidBorder";
	_marker setMarkerSizeLocal [ GRLIB_capture_size, GRLIB_capture_size ];

	_marker = createMarkerLocal ["spawn_marker", markers_reset];
	_marker setMarkerColorLocal "ColorGreen";
	_marker setMarkerTypeLocal "Select";

	// Base markers color
	if (GRLIB_fob_type == 0) then {
		"huronmarker" setMarkerColorLocal GRLIB_color_friendly;
		"huronmarker" setMarkerTextLocal "Huron";
	} else {
		deleteMarkerLocal "huronmarker";
	};
	"base_chimera" setMarkerColorLocal GRLIB_color_friendly;

	// LRX Markers
	GRLIB_Marker_SRV = [];
	GRLIB_Marker_ATM = [];
	GRLIB_Marker_FUEL = [];
	GRLIB_Marker_SHOP = [];

	// Objects too long to search (atm, phone, etc ..)
	[] call compileFinal preprocessFileLineNumbers "fixed_position.sqf";
	waituntil {sleep 1; !isNil "GRLIB_marker_init"};
};

// ATM Markers
{
	_marker = createMarkerLocal [format ["marked_atm%1", _forEachIndex], _x];
	_marker setMarkerColorLocal "ColorGreen";
	_marker setMarkerTypeLocal "mil_dot";
	if (_marker_debug) then {
		_marker setMarkerTextLocal format ["%1 %2", localize "STR_MARKER_ATM", _x];
	} else {
		_marker setMarkerTextLocal localize "STR_MARKER_ATM";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_ATM;

// SRV Markers
{
	_marker = createMarkerLocal [format ["marked_car%1", _forEachIndex], _x];
	_marker setMarkerColorLocal "ColorBlue";
	_marker setMarkerTypeLocal "mil_dot";
		if (_marker_debug) then {
		_marker setMarkerTextLocal format ["%1 %2", localize "STR_MARKER_SELL", _x];
	} else {
		_marker setMarkerTextLocal localize "STR_MARKER_SELL";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_SRV;

// FUEL Marker
{
	_marker = createMarkerLocal [format ["marked_fuel%1", _forEachIndex], _x];
	_marker setMarkerColorLocal "ColorYellow";
	_marker setMarkerTypeLocal "mil_dot";
	if (_marker_debug) then {
		_marker setMarkerTextLocal format ["%1 %2", localize "STR_MARKER_FUEL", _x];
	} else {
		_marker setMarkerTextLocal localize "STR_MARKER_FUEL";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_FUEL;

// SHOP Marker
{
	_marker = createMarkerLocal [format ["marked_shop%1", _forEachIndex], _x];
	_marker setMarkerColorLocal "ColorPink";
	_marker setMarkerTypeLocal "mil_dot";
	if (_marker_debug) then {
		_marker setMarkerTextLocal format ["%1 %2", localize "STR_MARKER_SHOP", _x];
	} else {
		_marker setMarkerTextLocal localize "STR_MARKER_SHOP";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_SHOP;

// REP Marker
{
	_marker = createMarkerLocal [format ["marked_rep%1", _forEachIndex], _x];
	_marker setMarkerColorLocal "ColorOrange";
	_marker setMarkerTypeLocal "mil_dot";
	if (_marker_debug) then {
		_marker setMarkerTextLocal format ["%1 %2", localize "STR_MARKER_REP", _x];
	} else {
		_marker setMarkerTextLocal localize "STR_MARKER_REP";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_REP;
