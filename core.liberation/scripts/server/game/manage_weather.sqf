//Classic Weather
if (GRLIB_weather_param == 0) exitWith {};
private _weathers = [0];
private _chosen_weather = 0;
private _weathertime = (25 * 60); // Delay between weather change
private _rain = 0;
private _fog = 0;
private _windx = (floor random 4);
private _windy = (floor random 4);

if (GRLIB_weather_param == 2) then {
	_weathers = [0, 0.05, 0.1, 0.12, 0.14, 0.16, 0.18, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45];
};

if (GRLIB_weather_param == 3) then {
	_weathers = [0.46, 0.48, 0.5, 0.53, 0.56, 0.6, 0.63, 0.66, 0.7, 0.73, 0.76, 0.8];
};

if (GRLIB_weather_param == 4) then {
	// _weathers = [0, 0.01, 0.02, 0.03, 0.05, 0.07, 0.1, 0.15, 0.2, 0.25, 0.3, 0.4, 0.45, 0.5, 0.55, 0.6, 0.7, 0.8, 0.9, 1.0];
	_weathers = [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.9, 1];
};

while { GRLIB_endgame == 0 } do {
	if (GRLIB_global_stop == 0) then {
		_chosen_weather = selectRandom _weathers;
		_rain = 0;
		_fog = 0;
		if (_chosen_weather >= 0.5) then { _rain = 0.2; _fog = 0.2 };
		if (_chosen_weather >= 0.7) then { _rain = 0.4; _fog = 0.4 }; // Removed heavy rain due to severe fps issues
		_windx = (floor random 4);
		_windy = (floor random 4);
		60 setOvercast _chosen_weather;
		60 setRain _rain;
		60 setFog _fog;
		setWind [_windx, _windy, true];
		//forceWeatherChange;
		diag_log format ["--- LRX Weather changed to %1 - rain %2 - fog %3 - wind %4/%5", _chosen_weather, _rain, _fog, _windx, _windy];
	};
	sleep _weathertime;
};
