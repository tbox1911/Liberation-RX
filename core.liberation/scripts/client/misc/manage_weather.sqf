waitUntil {sleep 1; !isNil "chosen_weather" };

skipTime -24;
86400 setOvercast chosen_weather;
skipTime 24;

_weathertime = 5*60;  //Delay between weather change
while { true } do {
	sleep _weathertime;
	_weathertime setOvercast chosen_weather;
	if ( overcast <= 0.5 ) then { 0 setRain 0; 0 setGusts 0 };
	if ( overcast > 0.5 && overcast <= 0.8 ) then { 0 setRain 0.2; 0 setGusts 0.2 };
	if ( overcast > 0.8 ) then { 0 setRain 0.4; 0 setGusts 0.4 }; // Removed heavy rain due to severe fps issues
};