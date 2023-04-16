private ["_accelerated_time"];
private _state = (call is_night);
private _old_state = !_state;

while { true } do {
	if (_state != _old_state) then {
		_accelerated_time = switch (_state) do {
			case (true):  {GRLIB_night_factor};
			case (false): {GRLIB_day_factor};
		};	
		setTimeMultiplier _accelerated_time;
		_old_state = _state;
	};
	sleep 60;
	_state = (call is_night);
};
