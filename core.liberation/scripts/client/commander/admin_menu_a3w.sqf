// the LRX Admin Tool by pSiKO
//
// debug side missions

createDialog "liberation_admin_a3w";
waitUntil { dialog };
disableSerialization;

private _display = findDisplay 5202;
private _debug_list = _display displayCtrl 1623;
private _debug_marker_list = _display displayCtrl 1627;
private _mission_list = _display displayCtrl 1618;
private _delay_list = _display displayCtrl 1611;
private _timeout_list = _display displayCtrl 1612;

// Clear listbox
lbClear _debug_list;
lbClear _debug_marker_list;
lbClear _mission_list;
lbClear _delay_list;
lbClear _timeout_list;

// Enable / Disable
{
	_debug_list lbAdd format["%1", _x];
	_debug_marker_list lbAdd format["%1", _x];
} forEach ["Enabled", "Disabled"];

// Build Mission list
{
	_mission_list lbAdd format["%1", (_x select 0) splitString "_" select 1];
} forEach SideMissions;

// Build Timer list
{
	_delay_list lbAdd format["%1", _x];
	_timeout_list lbAdd format["%1", _x];
} forEach [1, 2, 5, 10, 15, 20, 30, 60];

// Saved selection
if (isNil "LRX_A3W_CONFIG") then {
	_debug_list lbSetCurSel 0;
	_debug_marker_list lbSetCurSel 1;
	_mission_list lbSetCurSel 0;
	_delay_list lbSetCurSel 0;
	_timeout_list lbSetCurSel 2;
} else {
	_debug_list lbSetCurSel (LRX_A3W_CONFIG select 0);
	_debug_marker_list lbSetCurSel (LRX_A3W_CONFIG select 1);
	_mission_list lbSetCurSel (LRX_A3W_CONFIG select 2);
	_delay_list lbSetCurSel (LRX_A3W_CONFIG select 3);
	_timeout_list lbSetCurSel (LRX_A3W_CONFIG select 4);
};

// Tooltips
_debug_list ctrlSetToolTip localize "STR_TOOLTIP_DEBUG_MODE";
_debug_marker_list ctrlSetToolTip localize "STR_TOOLTIP_MARKER_DEBUG_MODE";
_mission_list ctrlSetToolTip localize "STR_TOOLTIP_SELECTED_MISSION";
_delay_list ctrlSetToolTip localize "STR_TOOLTIP_SIDE_MISSION_DELAY";
_timeout_list ctrlSetToolTip localize "STR_TOOLTIP_SIDE_MISSION_TIMEOUT";

apply_a3w_conf = 0;
while { alive player && dialog } do {
	if (apply_a3w_conf == 1) then {
		apply_a3w_conf = 0;
		(_display displayCtrl 1610) ctrlEnable false;
		private _a3w_debug = _debug_list lbText (lbCurSel _debug_list);
		private _a3w_debug_marker = _debug_marker_list lbText (lbCurSel _debug_marker_list);
		private _a3w_mission = _mission_list lbText (lbCurSel _mission_list);
		private _a3w_delay = _delay_list lbText (lbCurSel _delay_list);
		private _a3w_timeout = _timeout_list lbText (lbCurSel _timeout_list);

		//diag_log format ["%1 %2 %3 %4 %5", _a3w_debug, _a3w_debug_marker, _a3w_mission, _a3w_delay, _a3w_timeout];

		A3W_debug = false;
		if (_a3w_debug == "Enabled") then {
			A3W_debug = true;
		};
		A3W_debug_marker = false;
		if (_a3w_debug_marker == "Enabled") then {
			A3W_debug_marker = true;
		} else {
			{ deleteMarker _x } forEach (allMapMarkers select {_x select [0,8] == "a3w_dbg_"});
		};
		A3W_mission = format ["mission_%1", _a3w_mission];
		A3W_Mission_delay = (parseNumber _a3w_delay * 60);
		A3W_Mission_timeout = (parseNumber _a3w_timeout * 60);

		publicVariable 'A3W_debug';
		publicVariable 'A3W_mission';
		publicVariable 'A3W_debug_marker';
		publicVariable 'A3W_Mission_delay';
		publicVariable 'A3W_Mission_timeout';

		LRX_A3W_CONFIG = [
			(lbCurSel _debug_list),
			(lbCurSel _debug_marker_list),
			(lbCurSel _mission_list),
			(lbCurSel _delay_list),
			(lbCurSel _timeout_list)
		];
		systemChat localize "STR_LRX_MISSION_CONFIG_SET";
		sleep 1;
		(_display displayCtrl 1610) ctrlEnable true;
	};
	sleep 0.5;
};
closeDialog 0;
