waitUntil {sleep 1; !isNil "GRLIB_all_fobs"};
waitUntil {sleep 1; !isNil "GRLIB_init_server"};

// Truck no fob box
if (GRLIB_fob_type == 1) exitWith {};

private [ "_box", "_boxlist" ];
private _box_type = FOB_box_typename;

// Boat replace fob box
if (GRLIB_fob_type == 2) then {
	_box_type = FOB_boat_typename;
};
sleep 8;

private _box_pos = getPosATL base_boxspawn;
private _box_dir = getdir base_boxspawn;

while {true} do {
	_boxlist = {[_x] call is_public} count (entities _box_type);
	if ( _boxlist == 0 && count GRLIB_all_fobs == 0 ) then {
		_box = _box_type createVehicle _box_pos;
		_box allowdamage false;
		_box setPosATL _box_pos;
		_box setdir _box_dir;
		[_box] call F_clearCargo;
		_box enableSimulationGlobal true;
		_box setVariable ["GRLIB_vehicle_owner", "public", true];
		sleep 3;
		_box setDamage 0;
		_box allowdamage true;
		if (GRLIB_ACE_enabled) then {
			[_box] call F_aceInitVehicle;
		};
		waitUntil {
			sleep 1;
			!(alive _box) || count GRLIB_all_fobs > 0
		};
		deleteVehicle _box;
		sleep 30;
	};
	sleep 8;
};