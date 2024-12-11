waitUntil {sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil {sleep 1; !isNil "save_is_loaded" };

private [ "_fobbox", "_foblist" ];

private _fob_type = FOB_box_typename;
private _fob_pos = getPosATL base_boxspawn;
private _fob_dir = getdir base_boxspawn;

if ( GRLIB_fob_type == 1 ) then {
	_fob_type = FOB_truck_typename;
	_fob_pos = getPosATL huronspawn;
	_fob_dir = getdir huronspawn;
};

if ( GRLIB_fob_type == 2 ) then {
	_fob_type = FOB_boat_typename;
};

while { true } do {

	_foblist = {[_x] call is_public} count (entities _fob_type);

	if ( _foblist == 0 && count GRLIB_all_fobs == 0 ) then {
		_fobbox = _fob_type createVehicle _fob_pos;
		_fobbox allowdamage false;
		_fobbox setPosATL _fob_pos;
		_fobbox setdir _fob_dir;
		[_fobbox] call F_clearCargo;
		_fobbox enableSimulationGlobal true;
		_fobbox setVariable ["GRLIB_vehicle_owner", "public", true];
		sleep 3;
		_fobbox setDamage 0;
		_fobbox allowdamage true;
		if (GRLIB_ACE_enabled) then {
			[_fobbox] call F_aceInitVehicle;
		};
		waitUntil {
			sleep 1;
			!(alive _fobbox) || count GRLIB_all_fobs > 0
		};
		deleteVehicle _fobbox;
		sleep 30;
	};
	sleep 18;
};