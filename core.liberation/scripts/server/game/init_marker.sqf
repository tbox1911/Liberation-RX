if (!isServer) exitWith {};

waituntil {sleep 1; !isNil "GRLIB_sectors_init"};

private ["_vehicle", "_spawnpos", "_startpos", "_radius", "_max_try"];
private _marker_REPAIR = [];

{
  _spawnpos = [];
  _max_try = 10;
  _radius = 50;
  _startpos = markerPos _x;

  // Add repair pickup
  while { count _spawnpos == 0 && _max_try > 0 } do {
    _spawnpos = _startpos findEmptyPosition [1, _radius, "B_Heli_Transport_03_unarmed_F"];

    if (count _spawnpos > 0) then {
      if (isOnRoad _spawnpos) then { _spawnpos = [] };
    } else {
      _startpos = [markerPos _x , random 50 , random 360] call BIS_fnc_relPos;
    };
    _radius = _radius + 10;
    _max_try = _max_try -1;
    sleep 0.2;
  };

  if ( count _spawnpos > 0 ) then {
    _vehicle = repair_offroad createVehicle _spawnpos;
    waitUntil {sleep 0.1; !isNull _vehicle};
    _vehicle allowDamage false;
    _vehicle setVehicleLock "LOCKED";
    _vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
    _vehicle setVariable ["R3F_LOG_disabled", true, true];
    clearWeaponCargoGlobal _vehicle;
    clearMagazineCargoGlobal _vehicle;
    clearItemCargoGlobal _vehicle;
    clearBackpackCargoGlobal _vehicle;
    _marker_REPAIR pushback _spawnpos;
  } else {
    diag_log format ["--- LRX Error: No place to build %1 at sector %2", repair_offroad, _x];
  };
  sleep 0.2;
} forEach sectors_factory;

GRLIB_Marker_REPAIR = _marker_REPAIR;
publicVariable "GRLIB_Marker_REPAIR";
