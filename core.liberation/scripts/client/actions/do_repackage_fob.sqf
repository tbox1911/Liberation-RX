_fob_pos = _this select 3;
if (isNil "_fob_pos") exitWith {};
private ["_fobbox"];

//only one at time
private _fob_hq = player nearobjects [FOB_typename, GRLIB_fob_range] select 0;
if (isNil "_fob_hq") exitWith {};

private _fob_name = [_fob_pos] call F_getFobName;
private _fob_owner = [_fob_pos] call F_getFobOwner;
if (getPlayerUID player != _fob_owner) exitWith { hintSilent "Error!\nYour are NOT the owner of the FOB!" };

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

	if ( dorepackage == 1 ) then {
		_fobbox = FOB_box_typename createVehicle _spawnpos;
	};

	if ( dorepackage == 2 ) then {
		_fobbox = FOB_truck_typename createVehicle _spawnpos;
	};
	sleep 0.5;

	if ( !isNil "_fobbox" ) then {
		clearWeaponCargoGlobal _fobbox;
		clearMagazineCargoGlobal _fobbox;
		clearItemCargoGlobal _fobbox;
		clearBackpackCargoGlobal _fobbox;
		_fobbox addMPEventHandler ["MPKilled", { _this spawn kill_manager }];
		_fobbox setVariable ["GRLIB_vehicle_owner", getPlayerUID player, true];
	};

	[_fob_pos] remoteExec ["destroy_fob_remote_call", 2];
	hintSilent format ["%1 %2 "+ localize "STR_FOB_REPACKAGE_HINT", "FOB", _fob_name];
	sleep 10;
};
sleep 0.5;
build_confirmed = 0;
