// Dynamic Weather
// load MapSpecific Data etc.
// by  sturmalex
[] call compile preprocessFileLineNumbers "weatherData.sqf";

// init variables
private _seasonIdx = 9;
private _seasonText = "N/A";
private _rain = 0;
private _thunder = 0;
private _firstRun = true;
private _runMorning = false;
private _runEvening = false;
private _fogDissipated = false;
private _Hour = (date select 3);
private _monthSkipped = false;

while { GRLIB_endgame == 0 } do {
	// I recommend a timeMultiplier of 1. Otherwise ArmA's Engine goes all whacky with wheather - especially clouds, very cool BI.
	private _delay = (3300 / timeMultiplier);// 55minutes
	private _date_month = date select 1;

	// Skip a whole month at the end of the day so ideally we get a different month every 3 ingame days
	if ((round(dayTime) == 24 || round(dayTime) == 0) && _monthSkipped == false) then {
		skipTime (24*([date select 0, date select 1] call BIS_fnc_monthDays));
		_monthSkipped = true;
	};

	if ((round(dayTime) != 24 && round(dayTime) != 0) && _monthSkipped == true) then {
		_monthSkipped = false;
	};

	// set seasonIdx - this will indicate the Index for seasonal data....
	switch (true) do {
		case ((_date_month >= 1) && (_date_month <= 3)): {
			_seasonText = "Winter";
			_seasonIdx = 0;
		};
		case ((_date_month >= 4) && (_date_month <= 6)): {
			_seasonText = "Spring";
			_seasonIdx = 1;
		};
		case ((_date_month >= 7) && (_date_month <= 9)): {
			_seasonText = "Summer";
			_seasonIdx = 2;
		};
		case ((_date_month >= 10) && (_date_month <= 12)): {
			_seasonText = "Fall";
			_seasonIdx = 3;
		};
		default {
			// default is Summer, everybody loves Summer!
			_seasonIdx = 2;
		};
	};

	// overcast Value.
	private _overcast = selectRandomWeighted (cloudsList select _seasonIdx);
	// apply some randomness...
	private _overcastRng = random [-0.1, 0, 0.1];
	_overcast = _overcast + _overcastRng;
	// prevent values from being negative
	_overcast = _overcast max 0;

	// rain Value
	if (( random 101) <= ((rainList select _seasonIdx) select 1)) then {
		_rain = ((rainList select _seasonIdx) select 0);
		_rainRng = random [-0.1, 0, 0.1];
		_rain = _rain + _rainRng;
		// prevent values from being negative
		_rain = _rain max 0;
	} else {
		_rain = 0;
	};

	// Thunderstorm Value
	if ((_rain >= 0.1 ) && ( random[1, 0, 1] <= (thunderstormsList select _seasonIdx))) then {
		_thunder = random 1.0;
	};

	// fog Value
	private _fog = (fogList select _seasonIdx);
	
	// setFog Height randomness
	private _fogRndH = random [
		((_fog select 2)*0.8), // -20%
		(_fog select 2), // mid
		((_fog select 2)*1.2)// +20%
	];

	// setFog Decay randomness
	private _fogRndD = random [
		((_fog select 1)*0.8), // -20%
		(_fog select 1), // mid
		((_fog select 1)*1.2)// +20%
	];

	// setFog Power(Thickness) randomness
	private _fogRndT = random [
		((_fog select 0)*0.8), // -20%
		(_fog select 0), // mid
		((_fog select 0)*1.2)// +20%
	];

	private _sunUpDownList 	= date call BIS_fnc_sunriseSunsetTime;
	private _sunUp 			= (_sunUpDownList select 0);
	private _sunDown 		= (_sunUpDownList select 1);

	// Calculate time for forming of fog...
	private _sunUpAdjusted 		= (round((_sunUp - 1.2)*10))/10;
	private _sunDownAdjusted 	= (round((_sunDown - 1.2)*10))/10;

	// Create Morning fog...
	if (dayTime >= _sunUpAdjusted && dayTime <= _sunUp && _runMorning == false) then {
		private _timeToFog = (round((_sunUp - _sunUpAdjusted)*60))*60;
		if (( random 101) <= chanceFog) then {
			diag_log format ["Fog set: delay : %1, Thickness: %2, decay %3, height %4.", _timeToFog, _fogRndT, _fogRndD, _fogRndH];
			// set fog... 
			_timeToFog setFog [_fogRndT, _fogRndD, _fogRndH];
		};
		_runMorning = true;
		_runEvening = false;
		_fogDissipated = false;
	};

	// Create evening fog...
	if (dayTime >= _sunDownAdjusted && dayTime <= _sunDown && _runEvening == false) then {
		private _timeToFog = (round((_sunDown - _sunDownAdjusted)*60))*60;
		if (( random 101) <= chanceFog) then {
			diag_log format ["Fog set: delay : %1, Thickness: %2, decay %3, height %4.", _timeToFog, _fogRndT, _fogRndD, _fogRndH];
			// set fog... 
			_timeToFog setFog [_fogRndT, _fogRndD, _fogRndH];
		};
		_runMorning 	= false;
		_runEvening 	= true;
		_fogDissipated 	= false;
	};

	// dissipate morning/Evening fog (I assumed ArmA would take care of this after _timeToFog runs out - however ArmA only updates the thickness, never decay nor height - great work BI, really!).
	if ( ((dayTime > _sunDown && _runEvening == true) || (dayTime > _sunUp && _runMorning == true)) && _fogDissipated == false) then {
		if (_rain <= 0.1) then {
			1200 setFog[fogForecast, 1, -20]; // 20 min to DeFog (no rain)
		} else {
			1200 setFog[fogForecast, 0.01, 60]; // 20 minutes to deFog (rain)
		};
		_fogDissipated = true;
	};

	// set clouds... (thanks BI for shitty implementation)
	_delay setOvercast _overcast;

	// set rain...
	_delay setRain _rain;

	// set lightnings...
	_delay setLightnings _thunder;

	format ["The current season is %1", _seasonText] remoteExec ["hint"];

	diag_log format [" ---- Dymamic Weather has been updated "];
	// force this for first time...
	if (_firstRun == true) then {
		forceWeatherChange;
		_firstRun = false;
		_runMorning = false;
		_runEvening = false;
		sleep 10;
	} else {
		// Force Weather Change because of higher timeMultiplier clouds/overcast gets all whacky. Thanks BI.
		if (timeMultiplier != 1) then {
			forceWeatherChange;
		};
		sleep _delay;
	};
};