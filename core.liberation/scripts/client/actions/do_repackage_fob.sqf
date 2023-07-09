private ["_fob_box"];
private _fob_pos = [] call F_getNearestFob;

//only one at time
private _fob_hq = player nearobjects [FOB_typename, GRLIB_fob_range] select 0;
if (isNil "_fob_hq") exitWith {};

private _fob_name = [_fob_pos] call F_getFobName;
private _fob_owner = [_fob_pos] call F_getFobOwner;
if ((getPlayerUID player != _fob_owner) && !([] call is_admin)) exitWith { hintSilent localize "STR_HINT_FOB_WRONG_OWNER" };

build_confirmed = 1;
dorepackage = 0;
createDialog "liberation_repackage_fob";
waitUntil { dialog };
while { dialog && alive player && dorepackage == 0 } do {
	sleep 0.5;
};

if ( dorepackage > 0 ) then {
	closeDialog 0;
	waitUntil { !dialog };

	private _spawnpos = [4, (getPosATL player), 50, 30, false] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
	if ( count _spawnpos == 0 ) exitWith { hint "Cannot find enough place to repack FOB!" };

	playsound "Land_Carrier_01_blast_deflector_down_sound";
	if ( dorepackage == 1 ) then {
		_fob_box = FOB_box_typename createVehicle _spawnpos;
	};

	if ( dorepackage == 2 ) then {
		_fob_box = FOB_truck_typename createVehicle _spawnpos;
	};
	sleep 1;

	if ( !isNil "_fob_box" ) then {
		clearWeaponCargoGlobal _fob_box;
		clearMagazineCargoGlobal _fob_box;
		clearItemCargoGlobal _fob_box;
		clearBackpackCargoGlobal _fob_box;
		_fob_box addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
		_fob_box setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];
	};

	[_fob_pos] remoteExec ["destroy_fob_remote_call", 2];
	hintSilent format ["%1 %2 "+ localize "STR_FOB_REPACKAGE_HINT", "FOB", _fob_name];
	sleep 3;
	playsound "Land_Carrier_01_blast_deflector_down_sound";

};
sleep 0.5;
build_confirmed = 0;
