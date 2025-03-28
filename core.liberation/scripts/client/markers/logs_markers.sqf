// Log Marker creation/delete to server log

// create
addMissionEventHandler ["MarkerCreated",{
	params ["_marker", "_channelNumber", "_owner", "_local"];
	if (!(_local)) exitWith {};
	if (_channelNumber == -1) exitWith {};
	private _text = markerText _marker;
	if (count _text == 0) exitWith {};
	private _channel = "None";
	switch (_channelNumber) do {
		case 0: {_channel = "Global"};
		case 1: {_channel = "Side"};
		case 2: {_channel = "Command"};
		case 3: {_channel = "Group"};
		case 4: {_channel = "Vehicle"};
		case 5: {_channel = "Direct"};
		default {_channel = "Custom"};
	};
	private _msg = format [localize "STR_LOG_MARKER_CREATE", name player, _text, _channel, markerPos _marker];
	[_msg] remoteExec ["diag_log", 2];
}];

// delete
addMissionEventHandler ["MarkerDeleted",{
	params ["_marker", "_local"];
	if (!(_local)) exitWith {};
	if (markerChannel _marker == -1) exitWith {};
	private _text = markerText _marker;
	if (count _text == 0) exitWith {};
	private _msg = format [localize "STR_LOG_MARKER_DELETE", name player, _text, markerPos _marker];
	[_msg] remoteExec ["diag_log", 2];
}];
