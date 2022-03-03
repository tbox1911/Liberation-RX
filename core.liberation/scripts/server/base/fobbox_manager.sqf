waitUntil {sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil {sleep 1; !isNil "save_is_loaded" };

private [ "_fobbox", "_foblist" ];

_fob_type = FOB_box_typename;
if ( GRLIB_fob_type == 1 ) then {
	_fob_type = FOB_truck_typename;
};

while { true } do {

	_foblist = [entities _fob_type, {[_x] call is_public}] call BIS_fnc_conditionalSelect;

	if ( count _foblist == 0 && count GRLIB_all_fobs == 0 ) then {
		_fobbox = _fob_type createVehicle (getPosATL base_boxspawn);
		_fobbox allowdamage false;
		_fobbox setPosATL (getPosATL base_boxspawn);
		_fobbox setdir (getdir base_boxspawn);
		_fobbox setMass 3000;
		clearWeaponCargoGlobal _fobbox;
		clearMagazineCargoGlobal _fobbox;
		clearItemCargoGlobal _fobbox;
		clearBackpackCargoGlobal _fobbox;
		_fobbox enableSimulationGlobal true;
		_fobbox setVariable ["GRLIB_vehicle_owner", "public", true];
		sleep 3;
		_fobbox setDamage 0;
		_fobbox allowdamage true;

		waitUntil {
			sleep 1;
			!(alive _fobbox) || count GRLIB_all_fobs > 0
		};
		sleep 30;
		deleteVehicle _fobbox;
	};
	sleep 10;
};