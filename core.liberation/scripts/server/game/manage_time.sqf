private _state = (call is_night);
private _old_state = !_state;

while {true} do {
	if (_state != _old_state) then {
		setTimeMultiplier (switch (_state) do {
			case (true):  {GRLIB_night_factor};
			case (false): {GRLIB_day_factor};
		});	
		_old_state = _state;
	};
	sleep 60;
	_state = (call is_night);
};
