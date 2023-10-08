params [ "_sector_pos", "_radius", "_number" ];

if (_number == 0) exitWith {};
if (_number >= 1) then {
	sleep 2;
	[ _sector_pos, _radius, _number - 1 ] spawn ied_manager;
};

private _activation_radius = 6.66;
private _spread = 7;
private _trigger = 2 + (floor (random 3));
private _hostilecount = 0;
private _goes_boom = false;

private _ied_type = selectRandom [
	"IEDLandBig_F",
	"IEDLandSmall_F",
	"IEDUrbanBig_F",
	"IEDUrbanSmall_F"
];
private _ied_power = selectRandom [
	"R_80mm_HE",
	"M_AT",
	"R_PG7_F",
	"R_PG32V_F",
	"R_MRAAWS_HE_F",
	"Rocket_04_HE_F",
	"Bomb_03_F",
	"Bomb_04_F"
];
private _roadobj = [_sector_pos, _radius] call BIS_fnc_nearestRoad;
if !(isNull _roadobj) then {
	private _ied_obj = createMine [ _ied_type, [getposATL _roadobj, _spread, random(360)] call BIS_fnc_relPos, [], 0];
	_ied_obj setPos (getPos _ied_obj);

	private _timeout = time + (60 * 60);
	while {alive _ied_obj && time < _timeout && mineActive _ied_obj && !_goes_boom } do {
		sleep 1;
		_hostilecount = { alive _x && _x distance2D _ied_obj < _activation_radius } count (units GRLIB_side_friendly);
		if (_hostilecount >= _trigger) then {
			_round = _ied_power createVehicle (getposATL _ied_obj);
			[_round, -90, 0] call BIS_fnc_setPitchBank;
			_round setVelocity [0,0,-100];
			stats_ieds_detonated = stats_ieds_detonated + 1;
			publicVariable "stats_ieds_detonated";
			_goes_boom = true;
		};
	};
	deleteVehicle _ied_obj;
};
