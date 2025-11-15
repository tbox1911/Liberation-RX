private  ["_vehicle", "_distvehclose"];

waituntil {sleep 1; GRLIB_player_configured};
waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "GRLIB_player_near_fob" };
sleep 10;

while {true} do {
	if (GRLIB_player_near_fob) then {
		private _nearrecycl = (nearestObjects [player, GRLIB_recycleable_classnames + GRLIB_vehicle_whitelist, 30]) select {
			(_x distance2D lhd > GRLIB_fob_range) &&
			(getObjectType _x >= 8) &&
			([player, _x] call is_owner) &&
			isNil {_x getVariable "GRLIB_recycle_action"}
		};

		{
			_vehicle = _x;
			_distvehclose = 5;
			if ([_vehicle, vehicle_big_units] call F_itemIsInClass) then {
				_distvehclose = _distvehclose * 3;
			};
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_RECYCLE_MANAGER" + "</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_recycle.sqf","",-505,false,true,"","GRLIB_player_is_menuok && [_target] call is_recyclable",_distvehclose];
			_vehicle setVariable ["GRLIB_recycle_action", true];
		} forEach _nearrecycl;
	};
	sleep 6;
};
