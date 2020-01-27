waituntil {sleep 1; !isNull player};
waitUntil {sleep 1; GRLIB_player_spawned};

_list_static = [];
{
	if (! ((_x select 0) in ["B_AAA_System_01_F","B_Ship_Gun_01_F"])) then {
		_list_static pushBack ( _x select 0 );
	};
} foreach (static_vehicles);

while { true } do {
	{
		if (isDamageAllowed _x) then {
			[[_x, false], "allowDamage"] call BIS_fnc_MP;
		};

		if ((vectorUp _x) select 2 < 0.70) then {
			_x setpos [(getposATL _x) select 0,(getposATL _x) select 1, 0.5];
			_x setVectorUp surfaceNormal position _x;
		};

	} forEach nearestObjects [player, _list_static, 250];

	// Clear waypoints
	[player] spawn clear_wpt;

	// Show Hint
	private _neartower = ((sectors_allSectors select {_x select [0,6] == "tower_" && !(_x in blufor_sectors) && player distance2D (getMarkerPos _x) <= 20})) select 0;
	if (!isNil "_neartower") then {
		_msg = format ["Use <t color='#FF0000'>Explosives</t> to destroy<br/>the <t color='#0000FF'>Radio Tower</t>."];
		[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
	};
	sleep 20;
};