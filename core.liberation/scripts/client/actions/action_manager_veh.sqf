private  ["_vehicle", "_unit"];
private _distveh = 10;
private _distvehclose = 5;
private _searchradius = 30;
private _nearveh = [];
private _nearruins = [];
private _nearwreck = [];
private _nearboxes = [];
private _neardead = [];

private _recycleable_classnames_exp = [
	"Land_Cargo_HQ_V1_ruins_F",
	"Land_Cargo_Tower_V1_ruins_F",
	"Land_Cargo_House_V1_ruins_F",
	"Land_Cargo_Patrol_V1_ruins_F",
	"Land_Cargo_HQ_V3_ruins_F",
	"Land_Cargo_Tower_V3_ruins_F",
	"Land_Cargo_House_V3_ruins_F",
	"Land_Cargo_Patrol_V3_ruins_F"
];

private _wreck_class = [
	"Air",
	"Ship",
	"LandVehicle",
	"StaticWeapon",
	"Slingload_01_Base_F",
	"Pod_Heli_Transport_04_base_F",
	"Land_RepairDepot_01_base_F",
	"B_AAA_System_01_F",
	"B_SAM_System_02_F",
	"O_SAM_System_04_F"
];

private _classname_box = [
	Arsenal_typename,
	ammobox_b_typename,
	ammobox_o_typename,
	ammobox_i_typename,
	waterbarrel_typename,
	fuelbarrel_typename,
	foodbarrel_typename
];

waitUntil { sleep 1; !isNil "build_confirmed" };
waituntil { sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};
waituntil { sleep 1; !isNil "GRLIB_marker_init" };
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

while { true } do {
	// Vehicles actions
     _nearveh = [player nearEntities [["LandVehicle","Air","Ship"], _searchradius], {
		(_x distance lhd) >= GRLIB_sector_size &&
		!(typeOf _x in list_static_weapons) &&
		isNil {_x getVariable "GRLIB_vehicle_action"}
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		_distvehclose = 5;
		if (typeOf _vehicle in vehicle_big_units) then {
			_distvehclose = _distvehclose * 3;
		};
		_vehicle addAction ["<t color='#00F000'>" + localize "STR_RE_FUEL" + "</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_refuel.sqf","",-900,false,true,"","[_target] call is_menuok && [_target] call F_check_nearFuel", _distvehclose];
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_UN_FLIP" + "</t> <img size='1' image='res\ui_flipveh.paa'/>","scripts\client\actions\do_unflip.sqf","",-900,false,true,"","[_target] call is_menuok && !(typeOf _target in uavs) && (locked _target == 0 || locked _target == 1)", _distveh];

		if (!([typeOf _vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass) && !([_vehicle] call is_public)) then {
			_vehicle addAction ["<t color='#00FF00'>" + localize "STR_LOCK" + "</t> <img size='1' image='R3F_LOG\icons\r3f_lock.paa'/>","scripts\client\actions\do_lock.sqf","",-901,false,true,"","[_target] call is_menuok && (count (crew _target) == 0 || typeOf _target in uavs) && [_this, _target] call is_owner && (locked _target == 0 || locked _target == 1)", _distvehclose];
			_vehicle addAction ["<t color='#FF0000'>" + localize "STR_UNLOCK" + "</t> <img size='1' image='R3F_LOG\icons\r3f_unlock.paa'/>","scripts\client\actions\do_unlock.sqf","",-902,true,true,"","[_target] call is_menuok && [_this, _target] call is_owner && locked _target == 2", _distvehclose];
			_vehicle addAction ["<t color='#555555'>" + localize "STR_ABANDON" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_abandon.sqf","",-903,false,true,"","[_target] call is_menuok && [_this, _target] call is_owner && locked _target == 2", _distvehclose];
			_vehicle addAction ["<t color='#00F0F0'>" + localize "STR_PAINT" + "</t> <img size='1' image='res\ui_veh.paa'/>", "addons\RPT\fn_repaintMenu.sqf","",-905,false,true,"","[_target] call is_menuok && [_this, _target] call is_owner && locked _target == 2", _distvehclose];
			_vehicle addAction ["<t color='#0080F0'>" + localize "STR_EJECT_CREW" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_eject.sqf","",-906,false,true,"","[_target] call is_menuok && !(typeOf _target in uavs) && count (crew _target) > 0 && [_this, _target] call is_owner && vehicle _this == _this", _distvehclose];
		};

		if (typeOf _vehicle in transport_vehicles) then {
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_BOX" + "</t>","scripts\client\ammoboxes\do_unload_truck.sqf","",-500,false,true,"","[_target] call is_menuok && (locked _target == 0 || locked _target == 1) && isNull (_target getVariable ['R3F_LOG_remorque', objNull])", _distveh];
		};

		_vehicle setVariable ["GRLIB_vehicle_action", true];
	} forEach _nearveh;

	// Salvage Wreck & Ruins
	_nearruins = [nearestObjects [player, ["Ruins_F"], _searchradius], {(_x distance lhd) >= GRLIB_sector_size && (typeof _x in _recycleable_classnames_exp) && getObjectType _x == 8 && isNil {_x getVariable "GRLIB_salvage_action"}}] call BIS_fnc_conditionalSelect;
	_nearwreck = [nearestObjects [player, _wreck_class, _searchradius], {(_x distance lhd) >= GRLIB_sector_size && !(alive _x) && isNil {_x getVariable "GRLIB_salvage_action"}}] call BIS_fnc_conditionalSelect;
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_SALVAGE" + "</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_wreck.sqf","",-900,true,true,"","[] call is_menuok && !(_target getVariable ['wreck_in_use', false]) && !(player getVariable ['salvage_wreck', false])", (_distveh + 5)];
		_vehicle setVariable ["GRLIB_salvage_action", true];
	} forEach _nearwreck + _nearruins;

	// Box
	_nearboxes = [(player nearEntities [ _classname_box, _searchradius]), { isNil {_x getVariable "GRLIB_boxes_action"} }] call BIS_fnc_conditionalSelect;
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_LOAD_BOX" + "</t>","scripts\client\ammoboxes\do_load_box.sqf","",-501,true,true,"","[_target] call is_menuok  && [] call is_neartransport && (!(_target getVariable ['R3F_LOG_disabled', false]))", _distvehclose];
		_vehicle setVariable ["GRLIB_boxes_action", true];
	} forEach _nearboxes;

	// Dead Men
	_neardead = [allDeadMen, {(_x distance lhd) >= GRLIB_sector_size && (_x distance2D player < _searchradius) && isNil {_x getVariable "GRLIB_dead_action"}}] call BIS_fnc_conditionalSelect;
	{
		_unit = _x;
		_unit addAction ["<t color='#0080F0'>" + localize "STR_REMOVE_BODY" + "</t>",{ [_this select 0] remoteExec ["hidebody", 0]},"",1.5,false,true,"","_this distance2D _target < 3" ];
		_unit setVariable ["GRLIB_dead_action", true];
	} forEach _neardead;

	// Object WeaponHolderSimulated can't have zero or negative mass!
	{ if (round (getMass _x) <= 0) then { _x setMass 1 } } forEach (entities "WeaponHolderSimulated");

	sleep 5;
};
