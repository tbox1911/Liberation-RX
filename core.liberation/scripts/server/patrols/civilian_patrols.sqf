if (GRLIB_civilian_activity == 0) exitWith {};
waitUntil {sleep 0.5; !isNil "GRLIB_A3W_Init"};

for "_i" from 1 to (GRLIB_civilians_amount + (floor (random GRLIB_civilians_amount/2))) do {
	[] spawn manage_one_civilian_patrol;
	sleep 1;
};
