if (!isServer) exitWith {};

waituntil {sleep 1; !isNil "GRLIB_sectors_init"};

private ["_spawnpos", "_vehicle"];
{
  // Add repair pickup
  _spawnpos = [4, markerPos _x, 50, 30, false] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol;

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