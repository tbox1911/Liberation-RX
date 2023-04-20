//VAM Common Vehicle Camo Apply
disableSerialization;
private _VAM_display = findDisplay 4900;
private _list_camo = _VAM_display displayCtrl 4910;

private _list_selection = lbCurSel _list_camo;
private _selected_camo_class_name = camo_class_names select _list_selection;

private _veh = VAM_targetvehicle;
[_veh,[_selected_camo_class_name,1],nil,nil] call BIS_fnc_initVehicle;

diag_log _list_selection;
diag_log _selected_camo_class_name;

if ( ["#(rgb", _selected_camo_class_name] call F_startsWith || ["addons\RPT\textures\", _selected_camo_class_name] call F_startsWith ) then {
    // Apply texture to all appropriate parts

    private _selections = switch (true) do {
        case (_veh isKindOf "Van_01_base_F"):                 { [0,1] };
        case (_veh isKindOf "Van_02_base_F"):                 { [0] };

        case (_veh isKindOf "MRAP_01_base_F"):                { [0,2] };
        case (_veh isKindOf "MRAP_02_base_F"):                { [0,1,2] };
        case (_veh isKindOf "MRAP_03_base_F"):                { [0,1] };

        case (_veh isKindOf "Truck_01_base_F"):               { [0,1,2] };
        case (_veh isKindOf "Truck_02_base_F"):               { [0,1] };
        case (_veh isKindOf "Truck_03_base_F"):               { [0,1,2,3] };

        case (_veh isKindOf "APC_Wheeled_01_base_F"):         { [0,2] };
        case (_veh isKindOf "APC_Wheeled_02_base_F"):         { [0,2] };
        case (_veh isKindOf "APC_Wheeled_03_base_F"):         { [0,2,3] };

        case (_veh isKindOf "APC_Tracked_01_base_F"):         { [0,1,2,3] };
        case (_veh isKindOf "APC_Tracked_02_base_F"):         { [0,1,2] };
        case (_veh isKindOf "APC_Tracked_03_base_F"):         { [0,1] };

        case (_veh isKindOf "MBT_01_base_F"):                 { [0,1,2] };
        case (_veh isKindOf "MBT_02_base_F"):                 { [0,1,2,3] };
        case (_veh isKindOf "MBT_03_base_F"):                 { [0,1,2] };
        case (_veh isKindOf "MBT_04_base_F"):                 { [0,1,2,3] };

        case (_veh isKindOf "Heli_Transport_01_base_F"):      { [0,1] };
        case (_veh isKindOf "Heli_Transport_02_base_F"):      { [0,1,2] };
        case (_veh isKindOf "Heli_Transport_03_base_F"):      { [0,1] };
        case (_veh isKindOf "Heli_Transport_04_base_F"):      { [0,1,2,3] };
        case (_veh isKindOf "Heli_Attack_02_base_F"):         { [0,1] };

        case (_veh isKindOf "VTOL_Base_F"):                   { [0,1,2,3] };
        case (_veh isKindOf "Plane_Fighter_04_Base_F"):       { [0,1,2] };
        case (_veh isKindOf "Plane"):                         { [0,1] };

        case (_veh isKindOf "UGV_01_rcws_base_F"):            { [0,2] };
        case (_veh isKindOf "UAV_03_base_F"):                 { [0,1] };

        case (_veh isKindOf "LSV_01_base_F"):                 { [0,2] };
        case (_veh isKindOf "LSV_02_base_F"):                 { [0,2] };

        default                                               { [0] };
    };

    { _veh setObjectTextureGlobal [_x, _selected_camo_class_name] } forEach _selections;
};
