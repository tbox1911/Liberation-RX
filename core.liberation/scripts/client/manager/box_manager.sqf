waitUntil {sleep 1; !isNil "build_confirmed" };

GRLIB_checkAction_LoadBox = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && !GRLIB_player_near_lhd && alive _target && isNil "GRLIB_load_box" && !(_target getVariable ['R3F_LOG_disabled', false]) && [_unit, _target] call is_owner && [_target, 'TRANSPORT', 20, false] call F_check_near)
};

GRLIB_checkAction_UnloadBox = {
	params ["_target", "_unit"];
    private _owned = (([_unit, _target] call is_owner || [_target] call is_public) && locked _target < 2);
    private _loaded = (count (_target getVariable ['GRLIB_ammo_truck_load', []]) > 0);
    if (typeOf _target == storage_medium_typename) then { _owned = true };
	(GRLIB_player_is_menuok && alive _target && isNil "GRLIB_load_box" && _owned && _loaded && isNull (_target getVariable ['R3F_LOG_remorque', objNull]))
};

GRLIB_checkAction_UnloadLastBox = {
	params ["_target", "_unit"];
    private _owned = (([_unit, _target] call is_owner || [_target] call is_public) && locked _target < 2);
    private _loaded = (count (_target getVariable ['GRLIB_ammo_truck_load', []]) > 1);
    if (typeOf _target == storage_medium_typename) then { _owned = true };
	(GRLIB_player_is_menuok && alive _target && isNil "GRLIB_load_box" && _owned && _loaded && isNull (_target getVariable ['R3F_LOG_remorque', objNull]))
};

private _searchradius = 20;
private ["_neartransport", "_nearboxes", "_vehicle"];

while {true} do {
    // Transport
    _neartransport = (nearestObjects [player, transport_vehicles, _searchradius]) select {
        alive _x && speed vehicle _x < 5 &&
        ((getpos _x) select 2) < 5 &&
        ([player, _x] call is_owner || [_x] call is_public || typeOf _x == storage_medium_typename) &&
        !(_x getVariable ['R3F_LOG_disabled', false]) &&
        isNil {_x getVariable "GRLIB_vehicle_transport"}
    };

    {
        _vehicle = _x;
        _vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_BOX" + "</t> <img size='1' image='res\ui_unload.paa'/>","scripts\client\actions\do_unload_truck.sqf","all",-400,false,true,"","[_target, _this] call GRLIB_checkAction_UnloadBox", GRLIB_ActionDist_10];
        _vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_ONE_BOX" + "</t> <img size='1' image='res\ui_unload.paa'/>","scripts\client\actions\do_unload_truck.sqf","one",-401,false,true,"","[_target, _this] call GRLIB_checkAction_UnloadLastBox", GRLIB_ActionDist_10];
        _vehicle setVariable ["GRLIB_vehicle_transport", true];
    } forEach _neartransport;

    // Box
    _nearboxes = (player nearEntities [box_transport_loadable, _searchradius]) select { isNil {_x getVariable "GRLIB_boxes_action"} };
    {
        _vehicle = _x;
        _vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_LOAD_BOX" + "</t> <img size='1' image='res\ui_load.paa'/>","scripts\client\actions\do_load_box.sqf","",-400,true,true,"","[_target, _this] call GRLIB_checkAction_LoadBox", GRLIB_ActionDist_5];
        _vehicle setVariable ["GRLIB_boxes_action", true];
    } forEach _nearboxes;

    sleep 4;
};
