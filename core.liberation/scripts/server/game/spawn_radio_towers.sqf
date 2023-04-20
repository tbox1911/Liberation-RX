waitUntil {sleep 1; !isNil "sectors_tower" };

{
	_nextower = "Land_Communication_F" createVehicle (markerPos _x);
	_nextower setpos (markerpos _x);
	_nextower setVectorUp [0,0,1];
	//_nextower addEventHandler ["HandleDamage", { 0 }];
} foreach sectors_tower;