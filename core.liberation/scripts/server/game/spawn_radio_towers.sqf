waitUntil {sleep 1; !isNil "sectors_tower" };

{
	_nextower = Radio_tower createVehicle (markerPos _x);
	_nextower setpos (markerpos _x);
	_nextower setVectorUp [0,0,1];
	_nextower setVariable ["GRLIB_Radio_Tower", true, true];
	//_nextower addEventHandler ["HandleDamage", { 0 }];
} foreach sectors_tower;