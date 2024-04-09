params ["_vehicle"];

if ( _vehicle isKindOf "Ship" ) exitWith {};
if ( _vehicle isKindOf "LandVehicle" ) then {
    if ((vectorUp _vehicle) select 2 < 0.60) then {
        _vehicle setpos [(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, 0.5];
        _vehicle setVectorUp surfaceNormal position _vehicle;
        sleep 1;
    };

    if (getPosATL _vehicle select 2 < -0.02) then {
        _vehicle setpos (getpos _vehicle);
        sleep 1;
    };
};
