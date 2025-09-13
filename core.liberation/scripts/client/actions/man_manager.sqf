private  ["_unit"];
private _distvehclose = 5;
private _searchradius = 50;

waituntil {sleep 1; GRLIB_player_configured};
waitUntil {sleep 1; !isNil "build_confirmed" };
sleep 5;

while {true} do {
	// Man
	private _near_man = (player nearEntities ["CAManBase", _searchradius]) select {
 		isNull objectParent _x &&
		(_x getVariable ["GRLIB_can_speak", false]) &&
		isNil {_x getVariable "GRLIB_speak_action"}
	};

	{
		_x addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_CAPTURE" + "</t>","scripts\client\actions\do_capture.sqf","",999,true,true,"","[_target] call GRLIB_checkCapture", _distvehclose];
		_x addAction ["<t color='#00AA00'>" + localize "STR_MAN_MANAGER" + "</t> <img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>", "scripts\client\actions\do_speak.sqf",nil,999,true,true,"","[_target] call GRLIB_checkSpeak",_distvehclose];
		_x setVariable ["GRLIB_speak_action", true];
	} forEach _near_man;
	sleep 5;
};
