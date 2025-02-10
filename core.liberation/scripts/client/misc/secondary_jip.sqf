waitUntil {	sleep 1; !isNil "GRLIB_secondary_in_progress"};
waitUntil {	sleep 1; !isNil "sector_attack_in_progress"};
waitUntil {	sleep 1; !isNil "fob_attack_in_progress"};

if (GRLIB_secondary_in_progress == 0) then {
	[2] spawn remote_call_intel;
};

if (GRLIB_secondary_in_progress == 1) then {
	[4] spawn remote_call_intel;
};

if (GRLIB_secondary_in_progress == 2) then {
	[6] spawn remote_call_intel;
};

if (count sector_attack_in_progress > 0) then {
	[(sector_attack_in_progress select 0), 1] spawn remote_call_sector;
};

if (count fob_attack_in_progress > 0) then {
	[(fob_attack_in_progress select 0), 1] spawn remote_call_fob;
};
