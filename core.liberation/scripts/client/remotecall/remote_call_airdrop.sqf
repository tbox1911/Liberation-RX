if ( isDedicated ) exitWith {};
params [ "_unit"];

_timer = 15;
while {_timer >= 0 && alive _unit} do {
	_unit setVariable ["AirCoolDown", _timer, true];
	sleep 60;
	_timer = _timer - 1;
};
