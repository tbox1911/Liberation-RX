waitUntil {sleep 1; !isNil "chosen_weather" };

skipTime -24;
86400 setOvercast chosen_weather;
//forceWeatherChange;
skipTime 24;

while { true } do {
	0 setOvercast chosen_weather;
	if ( overcast <= 0.7 ) then { 0 setRain 0; 0 setGusts 0 };
	if ( overcast > 0.7 && overcast <= 0.9 ) then { 0 setRain 0.2; 0 setGusts 0.2 };
	if ( overcast > 0.9 ) then { 0 setRain 0.4; 0 setGusts 0.4 }; // Removed heavy rain due to severe fps issues
	sleep 20;
};