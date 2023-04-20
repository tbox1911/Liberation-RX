waitUntil {	sleep 1; !isNil "GRLIB_secondary_in_progress"};
if ( GRLIB_secondary_in_progress < 0 ) exitWith {};

if ( GRLIB_secondary_in_progress == 0 ) then {
	[ 2 ] spawn remote_call_intel;
};

if ( GRLIB_secondary_in_progress == 2 ) then {
	[ 6 ] spawn remote_call_intel;
};
