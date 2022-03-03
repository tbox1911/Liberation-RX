private _distvehclose = 5;
private _searchradius = 100;

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };

while { true } do {

	// Intel
	_near_intel = player nearEntities [[GRLIB_intel_laptop, GRLIB_intel_file], _searchradius];
	{
		_vehicle = _x;
		if (! (_vehicle getVariable ["GRLIB_intel_action", false]) ) then {
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_INTEL" + "</t>","scripts\client\actions\do_take_intel.sqf","",-849,true,true,"","[] call is_menuok",_distvehclose];
			_vehicle setVariable ["GRLIB_intel_action", true];
		};
	} forEach _near_intel;
	sleep 10;
};
