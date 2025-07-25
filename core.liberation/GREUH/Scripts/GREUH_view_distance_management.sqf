private _olddistance_inf = -1;
private _olddistance_veh = -1;
private _olddistance_obj = -1;
private _olddesiredvolume = -1;
private _was_vehicle = false;
private _min_view_distance = 300;
private _desired_inf = -1;
private _desired_veh = -1;
private _desired_obj = -1;

GREUH_force_adjust_view_distance = false;
GREUH_view_distance_factor = 1.0;
//waitUntil {sleep 1; !isNil "GREUH_view_distance_factor" };
//waitUntil {sleep 1; !isNil "GREUH_force_adjust_view_distance" };

while {true} do {
	waitUntil { sleep 0.5;
		(round _olddistance_inf != round desiredviewdistance_inf)
		|| (round _olddistance_veh != round desiredviewdistance_veh)
		|| (round _olddistance_obj != round desiredviewdistance_obj)
		|| ( (( isNull objectParent player ) && _was_vehicle)
		|| (( !isNull objectParent player ) && !_was_vehicle) )
		|| !(alive player)
		|| ( round _olddesiredvolume != round desired_vehvolume)
		|| GREUH_force_adjust_view_distance };
	waitUntil {sleep 1; alive player };
	GREUH_force_adjust_view_distance = false;
	_olddistance_inf = round desiredviewdistance_inf;
	_olddistance_veh = round desiredviewdistance_veh;
	_olddistance_obj = round desiredviewdistance_obj;
	_olddesiredvolume = desired_vehvolume;
	_was_vehicle = ( !isNull objectParent player );

	if ( _was_vehicle ) then {
		_desired_veh = (round desiredviewdistance_veh) * GREUH_view_distance_factor;
		if ( _desired_veh < _min_view_distance ) then {
			_desired_veh = _min_view_distance;
		};
		setViewDistance _desired_veh;
	} else {
		_desired_inf = (round desiredviewdistance_inf) * GREUH_view_distance_factor;
		if ( _desired_inf < _min_view_distance ) then {
			_desired_inf = _min_view_distance;
		};
		setViewDistance _desired_inf;
	};

	_desired_obj = (((desiredviewdistance_obj / 100.0) * desiredviewdistance_inf) * GREUH_view_distance_factor);
	if ( _desired_obj < _min_view_distance) then {
		_desired_obj = _min_view_distance;
	};
	setObjectViewDistance _desired_obj;
};