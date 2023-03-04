params [ "_sector_pos", "_radius", "_number" ];

if (_number == 0) exitWith {};
if (_number >= 1) then {
	[ _sector_pos, _radius, _number - 1 ] spawn ied_manager;
};

private _activation_radius_infantry = 6.66;
private _activation_radius_vehicles = 12;
private _spread = 7;
private _infantry_trigger = 2 + (floor (random 3));

private ["_nearinfantry", "_nearvehicles"];
private _vehicle_trigger = 1;
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
private _roadobj = [[_sector_pos, floor(random _radius), random(360)] call BIS_fnc_relPos, _radius, []] call BIS_fnc_nearestRoad;

private _goes_boom = false;
if ( !(isnull _roadobj) ) then {

	private _ied_obj = createMine [ _ied_type, [getposATL _roadobj, _spread, random(360)] call BIS_fnc_relPos, [], 0];
	_ied_obj setPos (getPos _ied_obj);

	private _timeout = time + (30 * 60);
	while {alive _ied_obj && time < _timeout && mineActive _ied_obj && !_goes_boom } do {
		sleep 1;
		_nearinfantry = [ (getposATL _ied_obj) nearEntities [ "Man", _activation_radius_infantry ] , { side _x == GRLIB_side_friendly } ] call BIS_fnc_conditionalSelect;
		_nearvehicles = [ (getposATL _ied_obj) nearEntities [ [ "Car", "Tank", "Air" ], _activation_radius_vehicles ] , { side _x == GRLIB_side_friendly } ] call BIS_fnc_conditionalSelect;
		if ( count _nearinfantry >= _infantry_trigger || count _nearvehicles >= _vehicle_trigger ) then {
			_ied_power createVehicle (getposATL _ied_obj);
			stats_ieds_detonated = stats_ieds_detonated + 1; publicVariable "stats_ieds_detonated";
			_goes_boom = true;
		};
	};
	deleteVehicle _ied_obj;
};
