private _distveh = 30;
private _distvehclose = 5;
private _searchradius = 100;

private _nearrecycl = [];
private _recycleable_blacklist = [];
private _recycleable_classnames = ["LandVehicle","Air","Ship","Slingload_01_Base_F", "Pod_Heli_Transport_04_base_F"];
{_recycleable_classnames pushBack ( _x select 0 )} foreach (static_vehicles + support_vehicles + buildings + opfor_recyclable);
_recycleable_classnames = _recycleable_classnames + GRLIB_vehicle_whitelist;

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };
waituntil {sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};

while { true } do {
	_nearrecycl = [nearestObjects [player, _recycleable_classnames, _searchradius], {
		(_x distance lhd) >= 1000 &&
		!(typeOf _x in _recycleable_blacklist) &&
		!([_x] call is_public) &&
		isNil {_x getVariable "GRLIB_recycle_action"}
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		_distvehclose = 5;
		if (typeOf _vehicle in vehicle_big_units) then {
			_distvehclose = _distvehclose * 3;
		};
		_vehicle addAction ["<t color='#FFFF00'>-- RECYCLE</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_recycle.sqf","",-950,false,true,"","[_target] call is_menuok && [_target] call is_recyclable",_distvehclose];

		// Fireworks
		if (typeOf _vehicle == "Land_CargoBox_V1_F") then {
			_vehicle addAction ["<t color='#60FF00'>-- FIREWORKS !</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\do_fireworks.sqf","",-951,false,true,"","[_target] call is_menuok && [player] call F_getScore >= GRLIB_perm_max",_distvehclose];
		};
		_vehicle setVariable ["GRLIB_recycle_action", true];
	} forEach _nearrecycl;

	sleep 10;
};