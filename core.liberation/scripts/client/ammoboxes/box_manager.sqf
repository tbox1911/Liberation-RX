waitUntil {sleep 1; !isNil "build_confirmed" };

//( _nextclass in [storage_medium_typename,storage_large_typename] )

GRLIB_checkAction_LoadBox = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && !GRLIB_player_near_lhd && alive _target && !(_target getVariable ['R3F_LOG_disabled', false]) && [_unit, _target] call is_owner && [_target, 'TRANSPORT', 20, false] call F_check_near)
};

GRLIB_checkAction_UnloadBox = {
	params ["_target", "_unit"];
	(GRLIB_player_is_menuok && alive _target && ([_unit, _target] call is_owner || [_target] call is_public) && locked _target < 2 && isNull (_target getVariable ['R3F_LOG_remorque', objNull]) && count (_target getVariable ['GRLIB_ammo_truck_load', []]) > 0)
};

private _searchradius = 20;
private ["_neartransport", "_nearboxes", "_vehicle"];

while { true } do {
    // Transport
    _neartransport = (nearestObjects [player, transport_vehicles, _searchradius]) select {
        alive _x && speed vehicle _x < 5 &&
        ((getpos _x) select 2) < 5 &&
        ([player, _x] call is_owner || [_x] call is_public) &&
        !(_x getVariable ['R3F_LOG_disabled', false]) &&
        isNil {_x getVariable "GRLIB_vehicle_transport"}
    };

    {
        _vehicle = _x;
        _vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_BOX" + "</t>","scripts\client\ammoboxes\do_unload_truck.sqf","",-500,false,true,"","[_target, _this] call GRLIB_checkAction_UnloadBox", GRLIB_ActionDist_10];
        _vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_UNLOAD_ONE_BOX" + "</t>","scripts\client\ammoboxes\do_unload_truck.sqf","1",-501,false,true,"","[_target, _this] call GRLIB_checkAction_UnloadBox", GRLIB_ActionDist_10];
        _vehicle setVariable ["GRLIB_vehicle_transport", true];
    } forEach _neartransport;

    // Box
    _nearboxes = (player nearEntities [box_transport_loadable, _searchradius]) select { isNil {_x getVariable "GRLIB_boxes_action"} };
    {
        _vehicle = _x;
        _vehicle addAction ["<t color='#FFFF00'>" + localize "STR_ACTION_LOAD_BOX" + "</t>","scripts\client\ammoboxes\do_load_box.sqf","",-501,true,true,"","[_target, _this] call GRLIB_checkAction_LoadBox", GRLIB_ActionDist_5];
        _vehicle setVariable ["GRLIB_boxes_action", true];
    } forEach _nearboxes;

    sleep 4;
};
