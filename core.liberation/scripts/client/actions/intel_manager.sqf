private  ["_vehicle"];
private ["_near_intel"];
private _distvehclose = 5;
private _searchradius = 20;

waituntil {sleep 1; GRLIB_player_configured};
waitUntil {sleep 1; !isNil "build_confirmed" };

while {true} do {

	// Intel
	_near_intel = nearestObjects [player, GRLIB_intel_items + GRLIB_ide_traps, _searchradius];
	{
		if (!(_x getVariable ["GRLIB_intel_action", false]) && (_x getVariable ["GRLIB_intel_search", false]) ) then {
			_x setVariable ["GRLIB_intel_action", true];
			removeAllActions _x;
			[
				_x,
				"<t color='#FFFF00'>" + localize "STR_INTEL" + "</t>",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
				"!(isActionMenuVisible) && _this distance2D _target < 3",
				"_caller distance2D _target < 3",
				{},
				{},
				{ [_target, player] remoteExec ["intel_remote_call", 2] },
				{},
				[],
				10,
				12,
				true,
				false				
			] call BIS_fnc_holdActionAdd;
		};
	} forEach _near_intel;
	sleep 10;
};
