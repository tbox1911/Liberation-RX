params ["_vehicle", "_driver", "_dest"];

gamelogic globalChat localize "STR_LOGISTIC_TRANSIT";

_vehicle setFuel 1;
_vehicle engineOn true;
_driver doMove _dest;
if (_vehicle isKindOf "Helicopter_Base_F") then { _vehicle flyInHeight [100, true] };
sleep 15;

private _landing_range = 150;
private _stop = time + (15 * 60); // wait 15min max

waitUntil {
    sleep 1;
    _speed = round (abs speed vehicle _vehicle);
    if (_speed == 0 && (_vehicle distance2D _dest > _landing_range)) then {
        [_vehicle] call F_vehicleUnflip;
        _vehicle setPos ((getPosATL _vehicle) vectorAdd [0, 0, 3]);
        _driver doMove _dest;
        sleep 10;
    };
    (!alive _vehicle || isNull _driver || (_vehicle distance2D _dest <= _landing_range && unitReady _driver) || time >= _stop)
};

if (!alive _vehicle) exitWith { true };

if (_vehicle isKindOf "Helicopter_Base_F") then {
    _vehicle flyInHeight [15, true];
    sleep 15;
};

(time >= _stop || isNull _driver || !alive _vehicle);
