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
	"Land_i_House_Small_01_V2_F",
	"Land_i_House_Small_01_V3_F",
	"Land_u_House_Small_02_V1_F",
	"Land_i_House_Small_02_V1_F",
	"Land_i_House_Small_02_V2_F",
	"Land_i_House_Small_02_V3_F",
	"Land_i_Stone_HouseSmall_V3_F",
    "Land_Medevac_house_V1_F",
    "Land_Medevac_HQ_V1_F",
	"Land_MilOffices_V1_F",
	"Land_Research_HQ_F",
	"Land_Research_house_V1_F"
];
private _intel_created = [];
private _nearbuildings = (nearestObjects [_pos, _compatible_classnames, _intel_range]) select { alive _x };

if (count _nearbuildings > 0) then {
	private _building_pos = [];
	{ _building_pos append (_x buildingPos -1) } foreach _nearbuildings;
	_building_pos = _building_pos - [[0,0,0]];

	if (count _building_pos >= 1) then {
		private _used_positions = [];

		for "_i" from 1 to (_nbintel min (count _building_pos)) do {
			_pos = selectRandom _building_pos;
			while { _pos in _used_positions } do {
				_pos = selectRandom _building_pos;
				sleep 0.1;
			};
			_used_positions pushback _pos;

			private _intelobject = createVehicle [selectRandom GRLIB_intel_items, zeropos, [], 100, "CAN_COLLIDE"];
			_intelobject setVariable ["GRLIB_intel_search", true, true];
			[_intelobject, _pos] call F_fixPosObject;
			_intelobject allowDamage false;
			_intelobject enableSimulationGlobal false;
			_intel_created pushBack _intelobject;
			if (_debug) then {
				private _marker = createMarkerLocal [ format ["markedintel_%1", (getpos _intelobject) select 0], getpos _intelobject ];
				_marker setMarkerColorLocal GRLIB_color_enemy_bright;
				_marker setMarkerTypeLocal "mil_dot";
			};
		};
	};
};

_intel_created;
