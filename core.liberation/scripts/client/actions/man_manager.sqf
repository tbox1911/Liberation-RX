private _distvehclose = 5;
private _searchradius = 100;

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };

while { true } do {

	// Man
	_near_man = [player nearEntities [["Man"], _searchradius], {
 		(alive _x) && vehicle _x == _x &&
		!(_x in [playableUnits + switchableUnits]) &&
		(side _x == GRLIB_side_civilian || side _x == GRLIB_side_resistance) &&
		isNil {_x getVariable "GRLIB_speak_action"}
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#00AA00'>" + localize "STR_MAN_MANAGER" + "</t> <img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>", "scripts\client\misc\speak_manager.sqf","",999,true,true,"","[_target] call is_menuok && (_target getVariable ['GRLIB_can_speak', false])",_distvehclose];
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_CAPTURE" + "</t>","scripts\client\actions\do_capture.sqf","",999,true,true,"","[_target] call is_menuok && (_target getVariable ['GRLIB_is_prisonner', false])",_distvehclose];
		_vehicle setVariable ["GRLIB_speak_action", true];
	} forEach _near_man;
	sleep 10;
};
