private _reset_time = 1200;

reinforcements_set = false;

while { true } do {

	waitUntil { sleep 1; reinforcements_set };
	reinforcements_set = false;

	private _localtime = time;

	waitUntil { sleep 1; ( time > ( _localtime + _reset_time ) ) || reinforcements_set };

	if ( !reinforcements_set && !([] call F_isBigtownActive) ) then { reinforcements_sector_under_attack = ""; }

};