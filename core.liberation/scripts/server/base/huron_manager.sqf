if ( GRLIB_fob_type == 1 ) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil {sleep 1; !isNil "save_is_loaded" };

firstloop = true;
huron = objNull;
_savedhuron = objNull;

while { true } do {

	{
		if ( typeof _x == huron_typename ) then {
			_savedhuron = _x;
		};
	} foreach vehicles;

	if ( firstloop && !isNull _savedhuron ) then {
		huron = _savedhuron;
	} else {
			huron = huron_typename createVehicle ( getpos huronspawn );
			huron addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			huron allowdamage false;
			huron setposasl (getposasl huronspawn vectorAdd [0,0,GRLIB_spawn_altitude]);
			huron setDir 0;
	};

	firstloop = false;

	huron AnimateDoor ["Door_rear_source", 1, true];
	publicVariable "huron";
	clearWeaponCargoGlobal huron;
	clearMagazineCargoGlobal huron;
	clearItemCargoGlobal huron;
	clearBackpackCargoGlobal huron;
	huron setDamage 0;
	sleep 0.5;
	huron enableSimulationGlobal true;
	huron setDamage 0;
	sleep 1.5;

	huron setDamage 0;
	huron allowdamage true;

	if ( alive huron ) then {
		waitUntil {
			sleep 1;
			!alive huron;
		};
		stats_spartan_respawns = stats_spartan_respawns + 1;
		sleep 15;
	};

	if (huron distance lhd < 500) then {
		deletevehicle huron;
	};
	sleep 10;
};