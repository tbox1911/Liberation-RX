waitUntil {sleep 1; !isNil "GRLIB_all_fobs"};
waitUntil {sleep 1; !isNil "GRLIB_init_server"};
sleep 2;

// Heli
private _huron_type = huron_typename;
private _huron_pos = getPosATL huronspawn;
private _huron_dir = getdir huronspawn;

// Truck
if (GRLIB_fob_type == 1) then {
	_huron_type = FOB_truck_typename;
};

while {true} do {
	if (GRLIB_fob_type in [1,2]) then { waitUntil {sleep 1; count GRLIB_all_fobs == 0}};
	if (isNull GRLIB_vehicle_huron ) then {
		private _huron = _huron_type createVehicle _huron_pos;
		_huron allowdamage false;
		_huron addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_huron setVariable ["GRLIB_vehicle_owner", "lrx", true];
		_huron setDir _huron_dir;
		_huron setPosATL _huron_pos;
		sleep 1;
		[_huron] call F_clearCargo;
		[_huron] call F_fixModVehicle;
		sleep 3;
		_huron setDamage 0;
		_huron allowdamage true;
		if (GRLIB_ACE_enabled) then {
			_huron setVariable ["ace_cargo_hasCargo", true, true];
			_huron setVariable ["ace_cargo_space", 200, true];
		};
		if (_huron_type isKindOf "Helicopter_Base_F") then {
			_huron AnimateDoor ["Door_rear_source", 1, true];
			[_huron, "add"] call mobile_respawn_remote_call;
		};
		GRLIB_vehicle_huron = _huron;
		publicVariable "GRLIB_vehicle_huron";
	};
	waitUntil { sleep 1; !alive GRLIB_vehicle_huron };
	stats_spartan_respawns = stats_spartan_respawns + 1;
	sleep 10;
	deleteVehicle GRLIB_vehicle_huron;	
	sleep 3;
};