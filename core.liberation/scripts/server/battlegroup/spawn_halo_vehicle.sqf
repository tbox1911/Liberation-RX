params ["_targetpos"];

private _vehicle_heavy = (opfor_vehicles - opfor_troup_transports_truck);
private _vehicle_light = (opfor_vehicles_low_intensity - opfor_troup_transports_truck);
private _vehicle_apc = _vehicle_heavy select { ([_x, ["Wheeled_APC_F", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "APC_Tracked_03_base_F"]] call F_itemIsInClass) };
if (count (_vehicle_light + _vehicle_apc) == 0) exitWith {};

private _pos = _targetpos getPos [floor(random GRLIB_capture_size), floor(random 360)];
_pos set [2, 600];

private _vehicle = createVehicle [selectRandom (_vehicle_light + _vehicle_apc), _pos, [], 0, "NONE"];
_vehicle setPos _pos;
_vehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

[_vehicle] call F_clearCargo;
[_vehicle] call F_fixModVehicle;
[_vehicle] call F_vehicleDefense;
[_vehicle, GRLIB_side_enemy] spawn F_forceCrew;

_vehicle setVariable ["GRLIB_vehicle_reward", true, true];
[_vehicle, 3600] call F_setUnitTTL;

[_pos, "parasound"] spawn sound_range_remote_call;
[_vehicle, objNull, false] spawn F_addParachute;

sleep 30;
private _grp = group (driver _vehicle);
[_grp, _pos] spawn battlegroup_ai;
