if (!isServer) exitWith {};

waituntil {sleep 1; !isNil "GRLIB_sectors_init"};

private ["_vehicle"];
private _spawnpos = [];
private _radius = 50;
private _max_try = 10;

{
  _spawnpos = [];

  // Add repair pickup
  while { count _spawnpos == 0 && _max_try > 0 } do {
    _spawnpos = [4, markerPos _x, _radius, 30, false] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;
    if (count _spawnpos > 0) then {
      if (isOnRoad _spawnpos) then { _spawnpos = [] };
    };
		_radius = _radius + 10;
		_max_try = _max_try -1;
		sleep 0.5;
	};

  if ( count _spawnpos > 0 ) then {
    _vehicle = repair_offroad createVehicle _spawnpos;
    _vehicle allowDamage false;
    _vehicle setVehicleLock "LOCKED";
    _vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
    _vehicle setVariable ["R3F_LOG_disabled", true, true];
    clearWeaponCargoGlobal _vehicle;
    clearMagazineCargoGlobal _vehicle;
    clearItemCargoGlobal _vehicle;
    clearBackpackCargoGlobal _vehicle;
  };
  sleep 0.2;
} forEach sectors_factory;