params [ "_ammobox" ];
private [ "_truck_to_load", "_truck_load", "_next_truck", "_maxload", "_offsets" ];

private _max_transport_distance = 15;
private _neartransporttrucks = [ nearestObjects [ player, transport_vehicles, _max_transport_distance], {
	 alive _x && speed _x < 5 &&
	 ((getpos _x) select 2) < 5 &&
	 ([player, _x] call is_owner || [_x] call is_public) &&
	 !(_x getVariable ['R3F_LOG_disabled', false]) 
}] call BIS_fnc_conditionalSelect;

_truck_to_load = objNull;
_box_offset = { if (typeOf _ammobox == (_x select 0)) exitWith {_x select 1} } foreach box_transport_offset;
if (isNil "_box_offset") then {_box_offset = [0, 0, 0]};

{
	_next_truck = _x;
	_maxload = 0;
	_offsets = [];
	{
		if ( _x select 0 == typeof _next_truck ) then {
			_maxload = (count _x) - 2;
			for "_i" from 2 to (count _x) do { _offsets pushback (_x select _i) };
		};
	} foreach box_transport_config;
diag_log _offsets;

	if ( isNull _truck_to_load ) then {
		_truck_load = _next_truck getVariable ["GRLIB_ammo_truck_load", 0];
		if (  _truck_load < _maxload ) then {
			_truck_to_load = _next_truck;
			_truck_offset = (_offsets select _truck_load) vectorAdd _box_offset;
			_ammobox attachTo [ _truck_to_load, _truck_offset ];
			_ammobox setVariable ["R3F_LOG_disabled", true, true];
			_ammobox allowDamage false;
			[_ammobox, false] remoteExec ["enableSimulationGlobal", 2];
			_truck_to_load setVariable ["GRLIB_ammo_truck_load", _truck_load + 1, true];
			hint localize "STR_BOX_LOADED";
		}
	};
} foreach _neartransporttrucks;

if ( isNull _truck_to_load ) then {
	hint localize "STR_BOX_CANTLOAD";
};
