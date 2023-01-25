private	["_vehicle", "_unit"];
private _distveh = 10;
private _distvehclose = 5;
private _searchradius = 20;
private _nearveh = [];
private _nearruins = [];
private _nearwreck = [];
private _nearboxes = [];
private _neardead = [];

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

call compile preprocessFile "scripts\client\actions\action_manager_veh_check.sqf";

waitUntil { sleep 1; !isNil "build_confirmed" };
waituntil { sleep 1; GRLIB_player_spawned; (player getVariable ["GRLIB_score_set", 0] == 1)};
waituntil { sleep 1; !isNil "GRLIB_marker_init" };
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

while { true } do {
	// Vehicles actions
	_nearveh = [player nearEntities [["LandVehicle","Air","Ship"], _searchradius], {
		!([_x, "LHD", GRLIB_sector_size] call F_check_near) &&
		!(typeOf _x in list_static_weapons) &&
		isNil {_x getVariable "GRLIB_vehicle_action"}
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		_distvehclose = 5;
		if (typeOf _vehicle in vehicle_big_units) then {
			_distvehclose = _distvehclose * 3;
		};
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_UN_FLIP" + "</t> <img size='1' image='res\ui_flipveh.paa'/>","scripts\client\actions\do_unflip.sqf","",-940,false,true,"","[_target, _this] call GRLIB_checkAction_Flip", _distveh];
		_vehicle addAction ["<t color='#900000'>" + localize "STR_DE_FUEL" + "</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_defuel.sqf","",-941,false,true,"","[_target, _this] call GRLIB_checkAction_DeFuel", _distvehclose];
		_vehicle addAction ["<t color='#009000'>" + localize "STR_RE_FUEL" + "</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_refuel.sqf","",-942,false,true,"","[_target, _this] call GRLIB_checkAction_ReFuel", _distvehclose];
		_vehicle addAction ["<t color='#009000'>" + localize "STR_HALO_VEH" + "</t> <img size='1' image='res\ui_redeploy.paa'/>", "scripts\client\spawn\do_halo.sqf","",-943,false,true,"","[_target, _this] call GRLIB_checkAction_Halo", _distveh];

		if (!([typeOf _vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass) && !([_vehicle] call is_public)) then {
			_vehicle addAction ["<t color='#00FF00'>" + localize "STR_LOCK" + "</t> <img size='1' image='R3F_LOG\icons\r3f_lock.paa'/>","scripts\client\actions\do_lock.sqf","",-901,false,true,"","[_target, _this] call GRLIB_checkAction_Lock", _distvehclose];
			_vehicle addAction ["<t color='#FF0000'>" + localize "STR_UNLOCK" + "</t> <img size='1' image='R3F_LOG\icons\r3f_unlock.paa'/>","scripts\client\actions\do_unlock.sqf","",-902,true,true,"","[_target, _this] call GRLIB_checkAction_Unlock", _distvehclose];
			_vehicle addAction ["<t color='#555555'>" + localize "STR_ABANDON" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_abandon.sqf","",-903,false,true,"","[_target, _this] call GRLIB_checkAction_Abandon", _distvehclose];
			_vehicle addAction ["<t color='#00F0F0'>" + localize "STR_PAINT" + " (VAM)</t> <img size='1' image='res\ui_veh.paa'/>", "addons\VAM\fn_repaintMenu.sqf","",-905,false,true,"","[_target, _this] call GRLIB_checkAction_Paint", _distvehclose];
			_vehicle addAction ["<t color='#0080F0'>" + localize "STR_EJECT_CREW" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_eject.sqf","",-906,false,true,"","[_target, _this] call GRLIB_checkAction_Eject", _distvehclose];
		};

		if (typeOf _vehicle in transport_vehicles) then {
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_BOX" + "</t>","scripts\client\ammoboxes\do_unload_truck.sqf","",-500,false,true,"","[_target, _this] call GRLIB_checkAction_Unload", _distveh];
		};

		_vehicle setVariable ["GRLIB_vehicle_action", true];
	} forEach _nearveh;

	// Salvage Wreck & Ruins
	_nearruins = [nearestObjects [player, ["Ruins_F"], _searchradius], {([_x, "FOB", GRLIB_sector_size] call F_check_near) && isNil {_x getVariable "GRLIB_salvage_action"}}] call BIS_fnc_conditionalSelect;
	_nearwreck = [nearestObjects [player, _wreck_class, _searchradius], {!([_x, "LHD", GRLIB_sector_size] call F_check_near) && !(alive _x) && isNil {_x getVariable "GRLIB_salvage_action"}}] call BIS_fnc_conditionalSelect;
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_SALVAGE" + "</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_wreck.sqf","",-900,true,true,"","[_target, _this] call GRLIB_checkAction_Wreck", (_distveh + 5)];
		_vehicle setVariable ["GRLIB_salvage_action", true];
	} forEach _nearwreck + _nearruins;

	// Box
	_nearboxes = [(player nearEntities [box_transport_loadable, _searchradius]), { isNil {_x getVariable "GRLIB_boxes_action"} }] call BIS_fnc_conditionalSelect;
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_LOAD_BOX" + "</t>","scripts\client\ammoboxes\do_load_box.sqf","",-501,true,true,"","[_target, _this] call GRLIB_checkAction_Box", _distvehclose];
		_vehicle setVariable ["GRLIB_boxes_action", true];
	} forEach _nearboxes;

	// Dead Men
	_neardead = [allDeadMen, {!([_x, "LHD", GRLIB_sector_size] call F_check_near) && (_x distance2D player < _searchradius) && isNil {_x getVariable "GRLIB_dead_action"}}] call BIS_fnc_conditionalSelect;
	{
		_unit = _x;
		_unit addAction ["<t color='#0080F0'>" + localize "STR_REMOVE_BODY" + "</t>",{ [_this select 0] remoteExec ["hidebody", 0]},"",1.5,false,true,"","_this distance2D _target < 3" ];
		_unit setVariable ["GRLIB_dead_action", true];
	} forEach _neardead;

	sleep 3;
};
