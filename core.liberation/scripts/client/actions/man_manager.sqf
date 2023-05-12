private  ["_unit"];
private _distvehclose = 5;
private _searchradius = 100;

waitUntil {sleep 1; !isNil "build_confirmed" };

while { true } do {

	// Man
	private _near_man = [player nearEntities [["Man"], _searchradius], {
 		(alive _x) && vehicle _x == _x &&
		(_x getVariable ['GRLIB_can_speak', false]) &&
		isNil {_x getVariable "GRLIB_speak_action"}
	}] call BIS_fnc_conditionalSelect;

	{
		_unit = _x;
		if (!isNil {_unit getVariable "GRLIB_is_prisonner"} ) then {
			_unit addAction ["<t color='#FFFF00'>" + localize "STR_SECONDARY_CAPTURE" + "</t>","scripts\client\actions\do_capture.sqf","",999,true,true,"","[_target] call is_menuok_veh && (_target getVariable ['GRLIB_is_prisonner', false])",_distvehclose];
		} else {
			_unit addAction ["<t color='#00AA00'>" + localize "STR_MAN_MANAGER" + "</t> <img size='1' image='\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa'/>", "scripts\client\misc\speak_manager.sqf","",999,true,true,"","[_target] call is_menuok_veh && (_target getVariable ['GRLIB_can_speak', false])",_distvehclose];
		};
		_unit setVariable ["GRLIB_speak_action", true];
	} forEach _near_man;
	sleep 10;
};
