params ["_pos", ["_debug", false]];

private _intel_range = 150;
private _nbintel = 3 + (floor random 4);
private _compatible_classnames = [
	"Cargo_House_base_F",
	"Cargo_HQ_base_F",
	"Cargo_Patrol_base_F",
	"Cargo_Tower_base_F",
	"Land_i_Barracks_V1_F",
	"Land_i_Barracks_V2_F",
	"Land_u_Barracks_V2_F",
	"Land_GH_House_1_F",
	"Land_GH_House_2_F",
	"Land_u_Addon_02_V1_F",
	"Land_u_House_Small_01_V1_F",
	"Land_u_House_Small_02_V1_F",
	"Land_i_Stone_HouseSmall_V3_F",
    "Land_Medevac_house_V1_F",
    "Land_Medevac_HQ_V1_F",
	"Land_MilOffices_V1_F",
	"Land_Research_HQ_F",
	"Land_Research_house_V1_F"
];
private _intel_created = [];
private _nearbuildings = (nearestObjects [_pos, _compatible_classnames, _intel_range]) select { alive _x };

if ( count _nearbuildings > 0 ) then {
	private _building_positions = [];
	{ _building_positions append ([_x] call BIS_fnc_buildingPositions) } foreach _nearbuildings;
	if ( count _building_positions >= 1 ) then {
		private ["_pos", "_intelclassname", "_intelobject", "_marker"];
		private _used_positions = [];

		for "_i" from 1 to (_nbintel min (count _building_positions)) do {
			_pos = selectRandom _building_positions;			
			while { _pos in _used_positions } do {
				_pos = selectRandom _building_positions;
				sleep 0.5;
			};
			_used_positions pushback _pos;

			_intelclassname = selectRandom GRLIB_intel_items;
			_intelobject = _intelclassname createVehicle _pos;
			_intelobject setVariable ["GRLIB_intel_search", true, true];
			_intelobject setPosATL [_pos select 0, _pos select 1, (_pos select 2) - 0.15];
			_intelobject allowDamage false;
			_intelobject setdir (random 360);
			_intel_created pushBack _intelobject;
			if (_debug) then {
				_marker = createMarkerLocal [ format ["markedintel_%1", (getpos _intelobject) select 0], getpos _intelobject ];
				_marker setMarkerColorLocal GRLIB_color_enemy_bright;
				_marker setMarkerTypeLocal "mil_dot";
			};
		};
	};
};

_intel_created;
