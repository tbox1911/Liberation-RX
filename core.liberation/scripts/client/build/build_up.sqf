private _zero = 0;
if (surfaceIsWater getPos player) then { _zero = (getPosASL player select 2) };

if (build_altitude < _zero + 4) then {
	build_altitude = build_altitude + 0.2;
};