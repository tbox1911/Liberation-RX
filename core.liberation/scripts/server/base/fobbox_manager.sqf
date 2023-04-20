waitUntil {sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil {sleep 1; !isNil "save_is_loaded" };

private [ "_fobbox" ];

_fob_type = FOB_box_typename;
if ( GRLIB_fob_type == 1 ) then {
	_fob_type = FOB_truck_typename;
};

while { true } do {
	_fobbox = entities [[FOB_box_typename, FOB_truck_typename], [], false, false];

	if ( count GRLIB_all_fobs == 0 && count _fobbox == 0) then {
		_fobbox = _fob_type createVehicle (getpos base_boxspawn);
		_fobbox setposasl (getposasl base_boxspawn vectorAdd [0,0,GRLIB_spawn_altitude]);
		_fobbox setdir (getdir base_boxspawn);
		_fobbox setMass 3000;
		clearWeaponCargoGlobal _fobbox;
		clearMagazineCargoGlobal _fobbox;
		clearItemCargoGlobal _fobbox;
		clearBackpackCargoGlobal _fobbox;
		_fobbox enableSimulationGlobal true;
		_fobbox setDamage 0;
		sleep 3;
		waitUntil {
			sleep 1;
			!(alive _fobbox) || count GRLIB_all_fobs > 0
		};
		sleep 30;
		deleteVehicle _fobbox;
	};
	sleep 10;
};