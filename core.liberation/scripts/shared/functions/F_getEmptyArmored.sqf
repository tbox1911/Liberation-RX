params ["_vehicle"];

sleep 120;

while { alive _vehicle && local _vehicle } do {
    waitUntil { sleep 3; [_vehicle] call F_vehicleUnflip; ([_vehicle] call is_abandoned) || !(alive _vehicle)};
    if !(alive _vehicle) exitWith {};
    [_vehicle] call F_searchGunner;
    sleep 120;
};
