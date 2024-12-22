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

	// Hide all markers
	{ _x setMarkerTypeLocal "Empty" } foreach opfor_sectors;

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
		_marker setMarkerTextLocal format ["ATM %1", _x];
	} else {
		_marker setMarkerTextLocal "ATM";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_ATM;

// SRV Markers
{
	_marker = createMarkerLocal [format ["marked_car%1", _forEachIndex], _x];
	_marker setMarkerColorLocal "ColorBlue";
	_marker setMarkerTypeLocal "mil_dot";
		if (_marker_debug) then {
		_marker setMarkerTextLocal format ["SELL %1", _x];
	} else {
		_marker setMarkerTextLocal "SELL";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_SRV;

// FUEL Marker
{
	_marker = createMarkerLocal [format ["marked_fuel%1", _forEachIndex], _x];
	_marker setMarkerColorLocal "ColorYellow";
	_marker setMarkerTypeLocal "mil_dot";
	if (_marker_debug) then {
		_marker setMarkerTextLocal format ["FUEL %1", _x];
	} else {
		_marker setMarkerTextLocal "FUEL";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_FUEL;

// SHOP Marker
{
	_marker = createMarkerLocal [format ["marked_shop%1", _forEachIndex], _x];
	_marker setMarkerColorLocal "ColorPink";
	_marker setMarkerTypeLocal "mil_dot";
	if (_marker_debug) then {
		_marker setMarkerTextLocal format ["SHOP %1", _x];
	} else {
		_marker setMarkerTextLocal "SHOP";
	};
	_marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_SHOP;
