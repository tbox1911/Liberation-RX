waitUntil {sleep 1; !isNil "GRLIB_player_near_fob" };

GRLIB_checkAction_AbandonBox = {
	params ["_target", "_unit"];
	if (!isNil "GRLIB_load_box") exitWith { false };
	if (_target getVariable ["R3F_LOG_disabled", false]) exitWith { false };
	private _owned = [_unit, _target] call is_owner;
	private _ready = (alive _target && round (speed vehicle _target) == 0);
	private _loaded = (count (_target getVariable ["GRLIB_ammo_vehicle_load", []]) > 0);
	(GRLIB_player_is_menuok && _ready && _owned && _loaded)
};

GRLIB_checkAction_LoadBox = {
	params ["_target", "_unit"];
	if (!isNil "GRLIB_load_box") exitWith { false };
	if (_target getVariable ["R3F_LOG_disabled", false]) exitWith { false };
	private _transport = [_unit, typeOf _target, 10] call F_getNearestTransport;
	if (isNull _transport) exitWith { false };
	private _owned = [_unit, _target] call is_owner;
	private _ready = (alive _target && speed vehicle _transport < 5 && ((getPosATL _transport) select 2) < 10);
	(GRLIB_player_is_menuok && _ready && _owned)
};

GRLIB_checkAction_UnloadBox = {
	params ["_target", "_unit"];
	if (!isNil "GRLIB_load_box") exitWith { false };
	if (!isNull (_target getVariable ['R3F_LOG_remorque', objNull])) exitWith { false };
	if (_target getVariable ["R3F_LOG_disabled", false] && typeOf _target != cargo_sling_typename) exitWith { false };
	private _owned = (([_unit, _target] call is_owner || [_target] call is_public) && locked _target < 2);
	private _loaded = (count (_target getVariable ["GRLIB_ammo_vehicle_load", []]) > 0);
	private _ready = (alive _target && speed vehicle _target < 5 && ((getPosATL _target) select 2) < 5);
	if (typeOf _target == storage_medium_typename) then { _owned = true };
	(GRLIB_player_is_menuok && _ready && _owned && _loaded)
};

GRLIB_checkAction_UnloadLastBox = {
	params ["_target", "_unit"];
	if (!isNil "GRLIB_load_box") exitWith { false };
	if (!isNull (_target getVariable ['R3F_LOG_remorque', objNull])) exitWith { false };
	if (_target getVariable ["R3F_LOG_disabled", false] && typeOf _target != cargo_sling_typename) exitWith { false };
	private _owned = (([_unit, _target] call is_owner || [_target] call is_public) && locked _target < 2);
	private _loaded = (count (_target getVariable ["GRLIB_ammo_vehicle_load", []]) > 1);
	if (typeOf _target == storage_medium_typename) then { _owned = true };
	private _ready = (alive _target && speed vehicle _target < 5 && ((getPosATL _target) select 2) < 5);
	(GRLIB_player_is_menuok && _ready && _owned && _loaded)
};

private _searchradius = 50;
private ["_nearboxes", "_transport_vehicles", "_vehicle"];

while {true} do {
	waitUntil {sleep 1; GRLIB_player_spawned};

	// Transport
	_transport_vehicles = (player nearEntities [transport_vehicles, _searchradius]) select {
		(!(_x getVariable ["R3F_LOG_disabled", false]) || typeOf _x == cargo_sling_typename) &&
		([player, _x] call is_owner || [_x] call is_public)
	};

	// Storage
	if (GRLIB_player_near_fob) then {
		_transport_vehicles append (nearestObjects [player, [storage_medium_typename], _searchradius]);
	};

	{
		_vehicle = _x;
		if (isNil {_vehicle getVariable "GRLIB_vehicle_transport"}) then {
			if (typeOf _vehicle == cargo_sling_typename) then {
				_vehicle addAction ["<t color='#555555'>" + localize "STR_ABANDON" + "</t> <img size='1' image='res\ui_veh.paa'/>","scripts\client\actions\do_abandon.sqf","",-499,false,true,"","[_target, _this] call GRLIB_checkAction_AbandonBox", GRLIB_ActionDist_5];
			};
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_BOX" + "</t> <img size='1' image='res\ui_unload.paa'/>","scripts\client\actions\do_unload_truck.sqf","all",-500,false,true,"","[_target, _this] call GRLIB_checkAction_UnloadBox", GRLIB_ActionDist_10];
			_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_ONE_BOX" + "</t> <img size='1' image='res\ui_unload.paa'/>","scripts\client\actions\do_unload_truck.sqf","one",-501,false,true,"","[_target, _this] call GRLIB_checkAction_UnloadLastBox", GRLIB_ActionDist_10];
			_vehicle setVariable ["GRLIB_vehicle_transport", true];
		};
	} forEach _transport_vehicles;

	// Box
	_nearboxes = (player nearEntities [box_transport_loadable, _searchradius]) select { isNil {_x getVariable "GRLIB_boxes_action"} };
	{
		_vehicle = _x;
		_vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_LOAD_BOX" + "</t> <img size='1' image='res\ui_load.paa'/>","scripts\client\actions\do_load_box.sqf","",-400,true,true,"","[_target, _this] call GRLIB_checkAction_LoadBox", GRLIB_ActionDist_5];
		_vehicle setVariable ["GRLIB_boxes_action", true];
	} forEach _nearboxes;

	sleep 4;
};
