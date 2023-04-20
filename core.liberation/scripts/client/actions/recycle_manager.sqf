waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };
waituntil {sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};

while { true } do {
	private	_nearestfob = [] call F_getNearestFob;
	private	_fobdistance = 9999;
	if ( count _nearestfob == 3 ) then {
		_fobdistance = round (player distance2D _nearestfob);
	};
	private _nearfob = _fobdistance <= GRLIB_fob_range;
	if (_nearfob) then {
		private _nearrecycl = [nearestObjects [player, GRLIB_recycleable_classnames + GRLIB_vehicle_whitelist, 30], {
			(_x distance lhd) >= 1000 &&
			!([_x] call is_public) &&
			isNil {_x getVariable "GRLIB_recycle_action"}
		}] call BIS_fnc_conditionalSelect;

		{
			private _vehicle = _x;
			private _distvehclose = 5;
			if (typeOf _vehicle in vehicle_big_units) then {
				_distvehclose = _distvehclose * 3;
			};
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_RECYCLE_MANAGER" + "</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_recycle.sqf","",-950,false,true,"","[_target] call is_menuok && [_target] call is_recyclable",_distvehclose];

			// Fireworks
			if (typeOf _vehicle == "Land_CargoBox_V1_F") then {
				_vehicle addAction ["<t color='#60FF00'>" + localize "STR_RECYCLE_FIREWORKS" + "</t> <img size='1' image='res\ui_arsenal.paa'/>","scripts\client\actions\do_fireworks.sqf","",-951,false,true,"","[_target] call is_menuok && score player >= GRLIB_perm_max",_distvehclose];
			};
			_vehicle setVariable ["GRLIB_recycle_action", true];
		} forEach _nearrecycl;
	};
	sleep 5;
};
