private [ "_accelerated_time" ];

while { true } do {
	_accelerated_time = GRLIB_day_factor;

	if (daytime > GRLIB_nights_start || daytime < GRLIB_nights_stop) then {
		_accelerated_time = GRLIB_night_factor;
	};

	setTimeMultiplier _accelerated_time;

	sleep 10;
};
