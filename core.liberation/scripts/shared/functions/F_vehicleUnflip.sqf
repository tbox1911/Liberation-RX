params ["_vehicle"];

if (surfaceIsWater (getPos _vehicle)) exitWith {};

if (vectorUp _vehicle select 2 < 0.60) then {
    _vehicle setpos [(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, 0.5];
    _vehicle setVectorUp surfaceNormal position _vehicle;
    sleep 1;
};

if (getPosATL _vehicle select 2 < -0.50) then {
    _vehicle setpos (getpos _vehicle);
    sleep 1;
};
