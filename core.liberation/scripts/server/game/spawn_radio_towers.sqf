uiSleep 3;
if (isNil "blufor_sectors") exitWith {};
{
	_nextower = "Land_Communication_F" createVehicle (markerPos _x);
	_nextower setpos (markerpos _x);
	_nextower setVectorUp [0,0,1];
	//_nextower addEventHandler ["HandleDamage", { 0 }];
	if ( !(_x in blufor_sectors) ) then {
		[markerPos _x, 25] call createlandmines;
	};
} foreach sectors_tower;