if ( GRLIB_fob_type == 1 ) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil {sleep 1; !isNil "save_is_loaded" };
sleep 8;

private ["_huron"];

while { true } do {
	if (isNull GRLIB_vehicle_huron ) then {
		_huron = huron_typename createVehicle (getPosATL huronspawn);
		_huron allowdamage false;
		_huron addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_huron setVariable ["GRLIB_vehicle_owner", "public", true];
		_huron setDir (getDir huronspawn);
		_huron setPosATL (getPosATL huronspawn);
		sleep 1;
		_huron AnimateDoor ["Door_rear_source", 1, true];
		[_huron] call F_clearCargo;
		[_huron] call F_fixModVehicle;
		sleep 3;
		_huron setDamage 0;
		_huron allowdamage true;
		if (GRLIB_ACE_enabled) then { [_huron, 200] call ace_cargo_fnc_setSpace };
		GRLIB_vehicle_huron = _huron;
		publicVariable "GRLIB_vehicle_huron";
	};
	waitUntil { sleep 1; !alive GRLIB_vehicle_huron };
	stats_spartan_respawns = stats_spartan_respawns + 1;
	sleep 10;
	deleteVehicle GRLIB_vehicle_huron;	
	sleep 3;
};