if (!isServer) exitWith {};

waituntil {sleep 1; !isNil "GRLIB_sectors_init"};

{
  // Add repair pickup
  private _pos = [];
  private _max_try = 8;
  private _find_pos = false;
  private _cur_pos = markerPos _x;
  while {!_find_pos && _max_try > 0} do {
    _pos = _cur_pos findEmptyPosition [5,50, "C_Offroad_01_repair_F"];
    if (count _pos == 3) then {
      if (!isOnRoad _pos) then {_find_pos = true};
      _cur_pos = _pos vectorAdd [([[-50,0,50], 5] call F_getRND), ([[-50,0,50], 5] call F_getRND), 0];
    };
    _max_try = _max_try - 1;
  };

  if (_find_pos) then {
    _vehicle = "C_Offroad_01_repair_F" createVehicle _pos;
    _vehicle allowDamage false;
    _vehicle setVehicleLock "LOCKED";
    _vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
    _vehicle setVariable ["R3F_LOG_disabled", true, true];
    clearWeaponCargoGlobal _vehicle;
    clearMagazineCargoGlobal _vehicle;
    clearItemCargoGlobal _vehicle;
    clearBackpackCargoGlobal _vehicle;
  };
} forEach sectors_factory;