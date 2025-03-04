waitUntil { sleep 1; !isNil "blufor_sectors" };

private ["_uav", "_uav_control"];

while {true} do {
    if (isRemoteControlling player) then {
        _uav = objectParent (remoteControlled player);
        if (unitIsUAV _uav) then {
            _uav_control = uavControl _uav;
            if (_uav_control select 1 != "") then {
                systemchat str _uav_control;
                private _bombs = (attachedObjects _uav) select { typeOf _x in sticky_bombs_typename };
                if (count _bombs == 0) exitWith {};
                waitUntil {
                    sleep 0.5;
                    (!alive _uav || (uavControl _uav) select 1 == "")
                };
                if (!alive _uav) then {
                    {
                        detach _x;
                        _x setDamage 1;
                        sleep 0.1;
                    } foreach _bombs;
                };
            };
        };
    };
    sleep 1;
};

