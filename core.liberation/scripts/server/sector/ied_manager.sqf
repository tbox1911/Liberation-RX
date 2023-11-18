params [ "_sector", "_radius", "_number" ];

if (_number == 0) exitWith {};
if (_number >= 1) then {
	sleep 2;
	[ _sector, _radius, _number - 1 ] spawn ied_manager;
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

private _sector_pos = markerPos _sector;
private _roadobj = selectRandom (_sector_pos nearRoads _radius);

if !(isNil "_roadobj") then {
	private _ied_obj = createMine [ _ied_type, [getposATL _roadobj, 1, random(360)] call BIS_fnc_relPos, [], 0];
	_ied_obj setPos (getPos _ied_obj);

	private _timeout = time + (60 * 60);
	while { alive _ied_obj && time < _timeout && mineActive _ied_obj } do {
		_nearinfantry = [(getposATL _ied_obj) nearEntities ["Man", _activation_radius_infantry], { side _x == GRLIB_side_friendly }] call BIS_fnc_conditionalSelect;
		_nearvehicles = [(getposATL _ied_obj) nearEntities [["Car", "Tank", "Air"], _activation_radius_vehicles], { side _x == GRLIB_side_friendly }] call BIS_fnc_conditionalSelect;
		if ( count _nearinfantry >= _infantry_trigger || count _nearvehicles >= _vehicle_trigger ) then {
			sleep 0.5;
			_ied_obj setDamage 1;
			stats_ieds_detonated = stats_ieds_detonated + 1;
			publicVariable "stats_ieds_detonated";
		};
		sleep 1;
	};
};
