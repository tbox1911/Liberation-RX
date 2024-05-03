params ["_targetpos"];

private _vehicle_heavy = (opfor_vehicles - opfor_troup_transports_truck);
private _vehicle_light = (opfor_vehicles_low_intensity - opfor_troup_transports_truck);
private _vehicle_apc = _vehicle_heavy select { ([_x, ["Wheeled_APC_F", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "APC_Tracked_03_base_F"]] call F_itemIsInClass) };
if (count (_vehicle_light + _vehicle_apc) == 0) exitWith {};

private _pos = _targetpos getPos [floor(random GRLIB_capture_size), floor(random 360)];
_pos set [2, 600];

private _vehicle = [_pos, selectRandom (_vehicle_light + _vehicle_apc), 0] call F_libSpawnVehicle;
private _grp = group (driver _vehicle);

if (surfaceIsWater _pos) then { _pos = ATLtoASL _pos };
while { _vehicle distance _pos > 100 } do {
	_vehicle setPos _pos;
	sleep 1;
};

[_pos, "parasound"] spawn sound_range_remote_call;
[_vehicle] spawn F_addParachute;
[_grp, _pos] spawn battlegroup_ai;
