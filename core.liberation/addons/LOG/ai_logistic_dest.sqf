params ["_vehicle", "_dest"];

_vehicle setFuel 1;
_vehicle engineOn true;

private _driver = driver _vehicle;
_driver doMove _dest;
sleep 30;

private _landing_range = 150;
private _stop = time + (15 * 60); // wait 15min max

waitUntil {
    sleep 1;
    _speed = round (abs speed vehicle _vehicle);
    if (_speed == 0 && (_vehicle distance2D _dest > _landing_range)) then {
        [_vehicle] call F_vehicleUnflip;
        _vehicle setPos ((getPosATL _vehicle) vectorAdd [0, 0, 3]);
        _driver doMove _dest;
        sleep 5;
    };
    (isNull driver _vehicle || (_vehicle distance2D _dest <= _landing_range && unitReady driver _vehicle) || time >= _stop)
};

(time >= _stop || isNull driver _vehicle);
