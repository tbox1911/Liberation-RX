private [ "_accelerated_time" ];

while { true } do {
	_accelerated_time = GRLIB_time_factor;

	if ( GRLIB_shorter_nights && (daytime > GRLIB_nights_start || daytime < GRLIB_nights_stop)) then {
		_accelerated_time = 20;
	};

	if ( GRLIB_shorter_nights && (daytime > GRLIB_nights_start + 2 || daytime < GRLIB_nights_stop - 2)) then {
		_accelerated_time = 60;
	};

	setTimeMultiplier _accelerated_time;
	{ if (round (getMass _x) <= 0) then { _x setMass 1 } } forEach (entities "WeaponHolderSimulated");
	sleep 10;
};
