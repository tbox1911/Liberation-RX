params [ "_sector_pos", "_radius", "_number" ];

if (_number == 0) exitWith {};
if (_number >= 1) then {
	sleep 3;
	[ _sector_pos, _radius, _number - 1 ] spawn ied_manager;
};

private _activation_radius_infantry = 6.66;
private _activation_radius_vehicles = 12;
private _infantry_trigger = 2 + (floor (random 3));
private _vehicle_trigger = 1;

private _ied_type = selectRandom [
	"IEDLandBig_F",
	"IEDLandSmall_F",
	"IEDUrbanBig_F",
	"IEDUrbanSmall_F"
];

private _roadobj = selectRandom (_sector_pos nearRoads _radius);
if !(isNil "_roadobj" && random 100 < GRLIB_MineProbability) then {
	private _ied_obj = createMine [_ied_type, (_roadobj getPos [1, random(360)]), [], 0];
	private _ied_pos = (getPos _ied_obj);
	_ied_obj setPos _ied_pos;

	private ["_nearinfantry", "_nearvehicles"];
	private _timeout = time + (60 * 60);
	while { alive _ied_obj && time < _timeout && mineActive _ied_obj } do {
		_nearinfantry = [_ied_pos, _activation_radius_infantry, GRLIB_side_friendly] call F_getUnitsCount;
		_nearvehicles = { _x distance2D _ied_pos < _activation_radius_vehicles && side _x == GRLIB_side_friendly } count vehicles;
		if ( _nearinfantry >= _infantry_trigger || _nearvehicles >= _vehicle_trigger ) then {
			sleep 0.5;
			_ied_obj setDamage 1;
			stats_ieds_detonated = stats_ieds_detonated + 1;
			publicVariable "stats_ieds_detonated";
		};
		sleep 1;
	};

	sleep 1;

	// Disarmed
	if (time <= _timeout) then {
		if (isServer) then {
			[_ied_pos] spawn ied_remote_call;
		} else {
			[_ied_pos] remoteExec ["ied_remote_call", 2];
		};
	};
};
