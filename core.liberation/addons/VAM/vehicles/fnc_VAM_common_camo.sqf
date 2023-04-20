//VAM Common Vehicle Camo Apply
disableSerialization;
private _VAM_display = findDisplay 4900;

private _list_selection = 0;
if (!isNull _VAM_display) then {
    _list_camo = _VAM_display displayCtrl 4910;
    _list_selection = lbCurSel _list_camo;
};

private _selected_camo_class_name = camo_class_names select _list_selection;
private _selected_camo_display_names = camo_display_names select _list_selection;
private _vehicle = VAM_targetvehicle;

if ( ["#(rgb", _selected_camo_class_name] call F_startsWith || ["addons\VAM\textures\", _selected_camo_class_name] call F_startsWith ) then {
    // Apply texture to all appropriate parts
    private _selections = switch (true) do {
        case (_vehicle isKindOf "Van_01_base_F"):                 { [0,1] };
        case (_vehicle isKindOf "Van_02_base_F"):                 { [0] };

        case (_vehicle isKindOf "MRAP_01_base_F"):                { [0,2] };
        case (_vehicle isKindOf "MRAP_02_base_F"):                { [0,1,2] };
        case (_vehicle isKindOf "MRAP_03_base_F"):                { [0,1] };

        case (_vehicle isKindOf "Truck_01_base_F"):               { [0,1,2] };
        case (_vehicle isKindOf "Truck_02_base_F"):               { [0,1] };
        case (_vehicle isKindOf "Truck_03_base_F"):               { [0,1,2,3] };

        case (_vehicle isKindOf "APC_Wheeled_01_base_F"):         { [0,2] };
        case (_vehicle isKindOf "APC_Wheeled_02_base_F"):         { [0,2] };
        case (_vehicle isKindOf "APC_Wheeled_03_base_F"):         { [0,2,3] };

        case (_vehicle isKindOf "APC_Tracked_01_base_F"):         { [0,1,2,3] };
        case (_vehicle isKindOf "APC_Tracked_02_base_F"):         { [0,1,2] };
        case (_vehicle isKindOf "APC_Tracked_03_base_F"):         { [0,1] };

        case (_vehicle isKindOf "MBT_01_base_F"):                 { [0,1,2] };
        case (_vehicle isKindOf "MBT_02_base_F"):                 { [0,1,2,3] };
        case (_vehicle isKindOf "MBT_03_base_F"):                 { [0,1,2] };
        case (_vehicle isKindOf "MBT_04_base_F"):                 { [0,1,2,3] };

        case (_vehicle isKindOf "Heli_Transport_01_base_F"):      { [0,1] };
        case (_vehicle isKindOf "Heli_Transport_02_base_F"):      { [0,1,2] };
        case (_vehicle isKindOf "Heli_Transport_03_base_F"):      { [0,1] };
        case (_vehicle isKindOf "Heli_Transport_04_base_F"):      { [0,1,2,3] };
        case (_vehicle isKindOf "Heli_Attack_02_base_F"):         { [0,1] };

        case (_vehicle isKindOf "VTOL_Base_F"):                   { [0,1,2,3] };
        case (_vehicle isKindOf "Plane_Fighter_04_Base_F"):       { [0,1,2] };
        case (_vehicle isKindOf "Plane"):                         { [0,1] };

        case (_vehicle isKindOf "UGV_01_rcws_base_F"):            { [0,2] };
        case (_vehicle isKindOf "UAV_03_base_F"):                 { [0,1] };

        case (_vehicle isKindOf "LSV_01_base_F"):                 { [0,2] };
        case (_vehicle isKindOf "LSV_02_base_F"):                 { [0,2] };

        default                                               { [0] };
    };

    { _vehicle setObjectTextureGlobal [_x, _selected_camo_class_name] } forEach _selections;
} else {
    [_vehicle,[_selected_camo_class_name,1],nil,nil] call BIS_fnc_initVehicle;
};

_vehicle setVariable ["GRLIB_vehicle_color", _selected_camo_class_name, true];
_vehicle setVariable ["GRLIB_vehicle_color_name", _selected_camo_display_names, true];
