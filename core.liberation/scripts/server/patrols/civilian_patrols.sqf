waitUntil {sleep 0.5; !isNil "GRLIB_A3W_Init"};

if ( GRLIB_civilian_activity > 0 ) then {
	for [ {_i=0}, {_i < GRLIB_civilians_amount}, {_i=_i+1} ] do {
		[] spawn manage_one_civilian_patrol;
		sleep 1;
	};
};