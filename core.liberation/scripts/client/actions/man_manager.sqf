private _distvehclose = 5;

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };

while { true } do {

	// Man
	_near_man = [player nearEntities [["Man"], _distvehclose], {
 			(alive _x) && vehicle _x == _x &&
			side _x != GRLIB_side_enemy
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		if (! (_vehicle getVariable ["GRLIB_speak_action", false]) ) then {
			_vehicle addAction ["<t color='#00AA00'>-- SPEAK</t> <img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>", "scripts\client\misc\speak_manager.sqf","",999,true,true,"","[_target] call is_menuok && (_target getVariable ['GRLIB_can_speak', false])",_distvehclose];
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_CAPTURE" + "</t>","scripts\client\actions\do_capture.sqf","",999,true,true,"","[_target] call is_menuok && (_target getVariable ['GRLIB_is_prisonner', false])",_distvehclose];
			_vehicle setVariable ["GRLIB_speak_action", true];
		};
	} forEach _near_man;
	sleep 2;
};
