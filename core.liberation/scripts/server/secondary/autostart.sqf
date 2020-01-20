
if ( isNil "GRLIB_secondary_in_progress" ) then { GRLIB_secondary_in_progress = -1; };
private _delay = (60 * 60) * 1.5;

while {true} do {
	sleep _delay;
	if (GRLIB_secondary_in_progress == -1) then {
		[ round(random [1,1.5,2]), "start_secondary_remote_call" ] call BIS_fnc_MP;
	};
};
