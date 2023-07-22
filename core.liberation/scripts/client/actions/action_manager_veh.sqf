private	["_vehicle", "_unit"];

private _searchradius = 20;
private _nearveh = [];
private _nearruins = [];
private _nearwreck = [];
private _nearboxes = [];
private _nearcargo = [];
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

[] call compile preprocessFile "scripts\client\actions\action_manager_veh_check.sqf";

waituntil { sleep 1; GRLIB_player_spawned && (player getVariable ["GRLIB_score_set", 0] == 1)};
if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};

while { true } do {
	// Vehicles actions
	_nearveh = [player nearEntities [["LandVehicle","Air","Ship"], _searchradius], {
		(_x distance2D lhd > GRLIB_fob_range) &&
		!(typeOf _x in list_static_weapons) &&
		isNil {_x getVariable "GRLIB_vehicle_action"}
	}] call BIS_fnc_conditionalSelect;

	{
		_vehicle = _x;
		GRLIB_ActionDist_5 = 5;
		if (typeOf _vehicle in vehicle_big_units) then {
			GRLIB_ActionDist_5 = GRLIB_ActionDist_5 * 3;
		};
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_UN_FLIP" + "</t> <img size='1' image='res\ui_flipveh.paa'/>","scripts\client\actions\do_unflip.sqf","",-940,false,true,"","[_target, _this] call GRLIB_checkAction_Flip", GRLIB_ActionDist_10];
		_vehicle addAction ["<t color='#900000'>" + localize "STR_DE_FUEL" + "</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_defuel.sqf","",-941,false,true,"","[_target, _this] call GRLIB_checkAction_DeFuel", GRLIB_ActionDist_5];
		_vehicle addAction ["<t color='#009000'>" + localize "STR_RE_FUEL" + "</t> <img size='1' image='R3F_LOG\icons\r3f_fuel.paa'/>", "scripts\client\actions\do_refuel.sqf","",-942,false,true,"","[_target, _this] call GRLIB_checkAction_ReFuel", GRLIB_ActionDist_5];
		_vehicle addAction ["<t color='#009000'>" + localize "STR_HALO_VEH" + "</t> <img size='1' image='res\ui_redeploy.paa'/>", "scripts\client\spawn\do_halo.sqf","",-943,false,true,"","[_target, _this] call GRLIB_checkAction_Halo", GRLIB_ActionDist_10];

		if (!([typeOf _vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass) && !([_vehicle] call is_public)) then {
			_vehicle addAction ["<t color='#00FF00'>" + localize "STR_LOCK" + "</t> <img size='1' image='R3F_LOG\icons\r3f_lock.paa'/>","scripts\client\actions\do_lock.sqf","",-901,false,true,"","[_target, _this] call GRLIB_checkAction_Lock", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#FF0000'>" + localize "STR_UNLOCK" + "</t> <img size='1' image='R3F_LOG\icons\r3f_unlock.paa'/>","scripts\client\actions\do_unlock.sqf","",-902,true,true,"","[_target, _this] call GRLIB_checkAction_Unlock", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#555555'>" + localize "STR_ABANDON" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_abandon.sqf","",-903,false,true,"","[_target, _this] call GRLIB_checkAction_Abandon", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#00F0F0'>" + localize "STR_PAINT" + " (VAM)</t> <img size='1' image='res\ui_veh.paa'/>", "addons\VAM\fn_repaintMenu.sqf","",-905,false,true,"","[_target, _this] call GRLIB_checkAction_Paint", GRLIB_ActionDist_5];
			_vehicle addAction ["<t color='#0080F0'>" + localize "STR_EJECT_CREW" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_eject.sqf","",-906,false,true,"","[_target, _this] call GRLIB_checkAction_Eject", GRLIB_ActionDist_5];
		};

		if (typeOf _vehicle in transport_vehicles) then {
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_BOX" + "</t>","scripts\client\ammoboxes\do_unload_truck.sqf","",-500,false,true,"","[_target, _this] call GRLIB_checkAction_Unload", GRLIB_ActionDist_10];
		};

		_vehicle setVariable ["GRLIB_vehicle_action", true];
	} forEach _nearveh;

	// Salvage Wreck & Ruins
	_nearruins = [nearestObjects [player, ["Ruins_F"], _searchradius], {(getObjectType _x >= 8) && ([_x, "FOB", GRLIB_sector_size] call F_check_near) && isNil {_x getVariable "GRLIB_salvage_action"}}] call BIS_fnc_conditionalSelect;
	_nearwreck = [nearestObjects [player, _wreck_class, _searchradius], {(getObjectType _x >= 8) && !([_x, "LHD", GRLIB_sector_size, false] call F_check_near) && !(alive _x) && isNil {_x getVariable "GRLIB_salvage_action"}}] call BIS_fnc_conditionalSelect;
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_SALVAGE" + "</t> <img size='1' image='res\ui_recycle.paa'/>","scripts\client\actions\do_wreck.sqf","",-900,true,true,"","[_target, _this] call GRLIB_checkAction_Wreck", (GRLIB_ActionDist_10 + 5)];
		_vehicle setVariable ["GRLIB_salvage_action", true];
	} forEach _nearwreck + _nearruins;

	// Box
	_nearboxes = [(player nearEntities [box_transport_loadable, _searchradius]), { isNil {_x getVariable "GRLIB_boxes_action"} }] call BIS_fnc_conditionalSelect;
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_LOAD_BOX" + "</t>","scripts\client\ammoboxes\do_load_box.sqf","",-501,true,true,"","[_target, _this] call GRLIB_checkAction_Box", GRLIB_ActionDist_5];
		_vehicle setVariable ["GRLIB_boxes_action", true];
	} forEach _nearboxes;

	// Dead Men
	_neardead = [allDeadMen, {!([_x, "LHD", GRLIB_sector_size, false] call F_check_near) && (_x distance2D player < _searchradius) && isNil {_x getVariable "GRLIB_dead_action"}}] call BIS_fnc_conditionalSelect;
	{
		_unit = _x;
		_unit addAction ["<t color='#0080F0'>" + localize "STR_REMOVE_BODY" + "</t>",{ [_this select 0] remoteExec ["hidebody", 0]},"",100,false,true,"","", GRLIB_ActionDist_3];
		_unit addAction ["<t color='#00F0F0'>" + localize "STR_LOOT_BODY" + "</t>","scripts\client\actions\do_loot.sqf","",101,false,true,"","(loadAbs _target > 120)",GRLIB_ActionDist_3];
		_unit setVariable ["GRLIB_dead_action", true];
	} forEach _neardead;

	sleep 3;
};
