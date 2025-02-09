private _less_loaded_HC = objNull;
private _previous_min_load = 99999;
private _current_load = 0;

if ( isMultiplayer ) then {
	if ( !isNil "group_owners" && !(isNil "HC1" && isNil "HC2" && isNil "HC3") ) then {
		{
			if ( _x select 0 == gamelogic ) then {
				_current_load = 20 + ( _x select 4) + ( _x select 5 );
				if (diag_fps <= 25) then { _current_load = 999 };
				if ( _current_load < _previous_min_load ) then {
					_previous_min_load = _current_load;
					_less_loaded_HC = objNull;
				};
			};

			if (!isNil "HC1") then {
				if (!isNull HC1) then {
					if ( _x select 0 == HC1 ) then {
						_current_load = ( _x select 4) + ( _x select 5 );
						if ( _current_load < _previous_min_load ) then {
							_previous_min_load = _current_load;
							_less_loaded_HC = HC1;
						};
					};
				};
			};

			if (!isNil "HC2") then {
				if (!isNull HC2) then {
					if ( _x select 0 == HC2 ) then {
						_current_load = ( _x select 4) + ( _x select 5 );
						if ( _current_load < _previous_min_load ) then {
							_previous_min_load = _current_load;
							_less_loaded_HC = HC2;
						};
					};
				};
			};

			if (!isNil "HC3") then {
				if (!isNull HC3) then {
					if ( _x select 0 == HC3 ) then {
						_current_load = ( _x select 4) + ( _x select 5 );
						if ( _current_load < _previous_min_load ) then {
							_previous_min_load = _current_load;
							_less_loaded_HC = HC3;
						};
					};
				};
			};
		} foreach group_owners;
	};
};

_less_loaded_HC