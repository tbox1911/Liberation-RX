params ["_objet", "_remorqueur"];

private _offset_attach_x = 0;
private _offset_attach_y = 0.2;
private _offset_attach_z = 0.2;

if (_objet isKindOf "AllVehicles") then {    
    //A3
    if (_remorqueur isKindOf "B_Truck_01_mover_F") then {_offset_attach_y = 1 };

    // CUP
    if (_remorqueur isKindOf "CUP_UAZ_Base") then {_offset_attach_z = _offset_attach_z + 2.4};
    if (_objet isKindOf "CUP_UAZ_Base") then {_offset_attach_z = _offset_attach_z - 2.4};

    // RHS
    if (_remorqueur isKindOf "rhs_btr_base") then {_offset_attach_z = 1.6};
    if (_objet isKindOf "rhs_btr_base") then {_offset_attach_z = _offset_attach_z - 1.1};
    if (_remorqueur isKindOf "rhs_bmp_base") then {_offset_attach_z = 1.0};
    if (_objet isKindOf "rhs_bmp_base") then {_offset_attach_z = _offset_attach_z - 1.0};
    if (_remorqueur isKindOf "RHS_Ural_Base") then { _offset_attach_z = _offset_attach_z + 2.0 };
    if (_objet isKindOf "RHS_Ural_Base") then { _offset_attach_z = _offset_attach_z - 2.0 };	
    if (_remorqueur isKindOf "RHS_Ural_Zu23_Base") then { _offset_attach_z = _offset_attach_z + 2.0 };
    if (_objet isKindOf "RHS_Ural_Zu23_Base") then { _offset_attach_z = _offset_attach_z - 2.0 };
    if (_remorqueur isKindOf "rhs_a3t72tank_base") then { _offset_attach_z = _offset_attach_z + 1.2 };
    if (_objet isKindOf "rhs_a3t72tank_base") then { _offset_attach_z = _offset_attach_z - 0.8 };				
};

[_offset_attach_x, _offset_attach_y, _offset_attach_z];
