waitUntil { sleep 1; !isNil "blufor_sectors" };

private ["_uav", "_uav_control"];

while {true} do {
    if (isRemoteControlling player) then {
        _uav = objectParent (remoteControlled player);
        if (unitIsUAV _uav) then {
            _uav_control = uavControl _uav;
            if (_uav_control select 1 != "") then {
                systemChat format ["%1 is connected to %2 (slot %3)", name (_uav_controller select 0), typeOf _uav, _uav_controller select 1];
            };
        };
    };
    sleep 1;
};

