params ["_classname", "_veh_pos", "_veh_dir", "_veh_vup"];

private _vehicle = createVehicle [_classname, zeropos, [], 100, "CAN_COLLIDE"];
_vehicle enableSimulationGlobal false;
_vehicle setVectorDirAndUp [_veh_dir, _veh_vup];
disableUserInput true;
player setDir (player getDir _veh_pos);

private _zStart = -1;
private _zEnd = round(_veh_pos select 2);
private _steps = 12;
private _stepHeight = (_zEnd - _zStart) / _steps;
for "_i" from 0 to _steps do {
    if ([player] call PAR_is_wounded) exitWith {};
    if (_i % 4 == 0) then {
        playSound3D [getMissionPath "res\dig02.ogg", player, false, getPosASL player, 5, 1, 250];
        //player playMoveNow "AinvPknlMstpSlayWrflDnon_medicOther";
        player playMoveNow "AinvPknlMstpSnonWnonDnon_medicUp0";
    };
    _newZ = _zStart + (_stepHeight * _i);
    _vehicle setPosATL [_veh_pos select 0, _veh_pos select 1, _newZ];
    sleep 1;
};
sleep 1;
disableUserInput false;
disableUserInput true;
disableUserInput false;

if (lifeState player == 'INCAPACITATED') exitWith { deleteVehicle _vehicle };
_vehicle setPosATL _veh_pos;
_vehicle enableSimulationGlobal true;
_vehicle setVariable ["GRLIB_counter_TTL", round(time + 600), true];
if (_classname == "Land_PierLadder_F") then {
    _vehicle setVariable ["R3F_LOG_disabled", false, true];
} else {
    _vehicle setVariable ["R3F_LOG_disabled", true, true];
};
GRLIB_current_trenches = GRLIB_current_trenches + 1;
_vehicle addEventHandler ["Killed", { GRLIB_current_trenches = GRLIB_current_trenches - 1 }];