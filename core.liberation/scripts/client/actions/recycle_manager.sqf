private _distveh = 15;
private _distvehclose = 5;

private _nearrecycl = [];
private _recycleable_blacklist = [huron_typename,"myLARsBox"];
private _recycleable_classnames = ["LandVehicle","Air","Ship","Slingload_01_Base_F"];
{_recycleable_classnames pushBack ( _x select 0 )} foreach (static_vehicles + support_vehicles + buildings);
_recycleable_classnames = _recycleable_classnames + GRLIB_vehicle_whitelist;

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };
waituntil {sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};

while { true } do {
	_nearrecycl = [nearestObjects [player, _recycleable_classnames, _distveh], {
		(_x distance lhd) >= 1000 &&
		!(typeOf _x in _recycleable_blacklist)
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		if (! (_vehicle getVariable ["GRLIB_recycle_action", false]) ) then {
			_vehicle addAction ["<t color='#FFFF00'>-- RECYCLE --</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_recycle.sqf","",-950,false,true,"","[_target] call is_menuok && [_target] call F_is_recyclable",_distvehclose];

			// XP AmmoBox
			if (typeOf _vehicle == ammobox_i_typename) then {
				_vehicle addAction ["<t color='#60FF00'>-- ADD 50 XP --</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\do_recycle_xp.sqf","",-951,false,true,"","[_target] call is_menuok && [_target] call F_is_recyclable",_distvehclose];
			};

			_vehicle setVariable ["GRLIB_recycle_action", true];
		};
	} forEach _nearrecycl;

	sleep 2;
};