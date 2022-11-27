GRLIB_secondary_starting = false; publicVariable "GRLIB_secondary_starting";
GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";
GRLIB_secondary_used_positions = [];

private _delay = (60 * 60) * 1.5;

while {true} do {
	sleep _delay;
	if (!GRLIB_secondary_starting) then {
		[(selectRandom [1,2]), true] call start_secondary_remote_call;
	};
};
