// Dynamic Animal - by vandeanson
// https://forums.bohemia.net/forums/topic/218268-dynamic-animalgame-spawn-script-by-vandeanson/
// updated by: pSiKO

if (GRLIB_wildlife_manager == 0) exitWith {};

while {true} do {

	{
		if (isNil {_x getVariable "GRLIB_Wildlife"}) then {
			_x setVariable ["GRLIB_Wildlife", 0, true];
			[_x] spawn manage_one_wildlife;
			sleep 1;
		};
	} forEach AllPlayers;

 	sleep 5;
};