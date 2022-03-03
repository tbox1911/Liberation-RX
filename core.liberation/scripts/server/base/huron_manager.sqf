if ( GRLIB_fob_type == 1 ) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil {sleep 1; !isNil "save_is_loaded" };

private [ "_huronlist" ];

huron = objNull;

/*
while { true } do {

	_huronlist = [entities huron_typename, {
		(_x getVariable ["GRLIB_vehicle_ishuron", false])
	}] call BIS_fnc_conditionalSelect;

	if ( count _huronlist == 0) then {
		huron = huron_typename createVehicle ( getPosATL huronspawn );
		huron allowdamage false;
		huron addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		huron setVariable ["GRLIB_vehicle_owner", "public", true];
		huron setVariable ["GRLIB_vehicle_ishuron", true, true];
		huron setPosATL (getPosATL huronspawn);
		huron setDir (getDir huronspawn);
		sleep 0.5;
		huron AnimateDoor ["Door_rear_source", 1, true];
		publicVariable "huron";
		clearWeaponCargoGlobal huron;
		clearMagazineCargoGlobal huron;
		clearItemCargoGlobal huron;
		clearBackpackCargoGlobal huron;
		huron enableSimulationGlobal true;
		sleep 3;
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
		deletevehicle huron;	
	};
	sleep 10;
};
*/