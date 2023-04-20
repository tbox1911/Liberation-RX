private _distveh = 30;
private _distvehclose = 5;
private _searchradius = 100;

private _nearrecycl = [];
private _recycleable_blacklist = [huron_typename,"myLARsBox"];
private _recycleable_classnames = ["LandVehicle","Air","Ship","Slingload_01_Base_F"];
{_recycleable_classnames pushBack ( _x select 0 )} foreach (static_vehicles + support_vehicles + buildings + opfor_recyclable);
_recycleable_classnames = _recycleable_classnames + GRLIB_vehicle_whitelist;

private _big_unit = [
	"Land_Cargo_Tower_V1_F",
	"B_T_VTOL_01_infantry_F",
	"B_T_VTOL_01_vehicle_F",
	"Land_SM_01_shed_F",
	"Land_Hangar_F"
];

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };
waituntil {sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};

while { true } do {
	_nearrecycl = [nearestObjects [player, _recycleable_classnames, _searchradius], {
		(_x distance lhd) >= 1000 &&
		!(typeOf _x in _recycleable_blacklist) &&
		isNil {_x getVariable "GRLIB_recycle_action"}
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		_distvehclose = 5;
		if (typeOf _vehicle in _big_unit) then {
			_distvehclose = _distvehclose * 4;
		};
		_vehicle addAction ["<t color='#FFFF00'>-- RECYCLE</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_recycle.sqf","",-950,false,true,"","[_target] call is_menuok && [_target] call F_is_recyclable",_distvehclose];

		// Fireworks
		if (typeOf _vehicle == "Land_CargoBox_V1_F") then {
			_vehicle addAction ["<t color='#60FF00'>-- FIREWORKS !</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\do_fireworks.sqf","",-951,false,true,"","[_target] call is_menuok && score player >= GRLIB_perm_max",_distvehclose];
		};
		_vehicle setVariable ["GRLIB_recycle_action", true];
	} forEach _nearrecycl;

	sleep 10;
};