
waitUntil {
	sleep 1;
	time > 20;
};

if ( isNil "GRLIB_secondary_starting" ) then { GRLIB_secondary_starting = false; };
private _delay = (60 * 60) * 1.5;

while {true} do {
	sleep _delay;
	if (!GRLIB_secondary_starting) then {
		[(selectRandom [1,2]), true] call start_secondary_remote_call;
	};
};
