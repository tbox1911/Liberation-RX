waitUntil {	sleep 0.1; !isNil "GRLIB_secondary_starting"};
waitUntil {	sleep 0.1; !isNil "GRLIB_secondary_in_progress"};

private _mission_list = [
	"STR_SECONDARY_MISSION0",
	"STR_SECONDARY_MISSION1",
	"STR_SECONDARY_MISSION2",
	"STR_SECONDARY_MISSION3"
];

if (GRLIB_secondary_in_progress >= 0 ) exitWith {
	gamelogic globalChat format [localize "STR_SECONDARY_MISSION_IN_PROGRESS", localize (_mission_list select GRLIB_secondary_in_progress)];
};

createDialog "liberation_secondary";
waitUntil { dialog };

{
	lbAdd [ 101, localize _x ];
} foreach _mission_list;

private [ "_oldchoice", "_images", "_briefings", "_missioncost" ];

private _images = [
	"res\secondary\fob_hunting.jpg",
	"res\secondary\convoy_hijack.jpg",
	"res\secondary\sar.jpg",
	"res\secondary\final_situation.jpg"
];

private _briefings = [
	"STR_SECONDARY_BRIEFING0",
	"STR_SECONDARY_BRIEFING1",
	"STR_SECONDARY_BRIEFING2",
	"STR_SECONDARY_BRIEFING3"
];

dostartsecondary = 0;
private _oldchoice = -1;
lbSetCurSel [ 101, 0 ];

while { dialog && alive player && dostartsecondary == 0 } do {

	if ( _oldchoice != lbCurSel 101 ) then {
		_oldchoice = lbCurSel 101;
		ctrlSetText [ 106, _images select _oldchoice ];
		((findDisplay 6842) displayCtrl (102)) ctrlSetStructuredText parseText localize (_briefings select _oldchoice);
	};

	_missioncost = GRLIB_secondary_missions_costs select _oldchoice;

	if ( ( _missioncost <= resources_intel ) && ( !GRLIB_secondary_starting ) )  then {
		ctrlEnable [ 103, true ];
		((findDisplay 6842) displayCtrl (103)) ctrlSetTooltip "";
	} else {
		ctrlEnable [ 103, false ];
		if ( _missioncost > resources_intel ) then {
			((findDisplay 6842) displayCtrl (103)) ctrlSetTooltip (localize "STR_SECONDARY_NOT_ENOUGH_INTEL");
		};
		if ( GRLIB_secondary_starting ) then {
			((findDisplay 6842) displayCtrl (103)) ctrlSetTooltip (localize "STR_SECONDARY_IN_PROGRESS");
		};
	};

	if ( GRLIB_secondary_in_progress >= 0 ) then {
		lbSetCurSel [ 101, GRLIB_secondary_in_progress ];
		ctrlEnable [ 101, false ];
	} else {
		ctrlEnable [ 101, true ];
	};

	ctrlSetText [ 107, format [ localize "STR_SECONDARY_INTEL", resources_intel ] ];
	uiSleep 0.1;
};

if ( dostartsecondary == 1 ) then {
	[lbCurSel 101, false, getPlayerUID player] remoteExec ["start_secondary_remote_call", 2];
	private _msg = format ["Player %1 Start Secondary Mission: %2.",name player, localize (_mission_list select (lbCurSel 101))];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
};

if ( dialog ) then {
	closeDialog 0;
};