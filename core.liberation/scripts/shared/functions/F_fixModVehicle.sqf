params ["_vehicle"];

private _init = [];

// CUP remove tank panel
if (GRLIB_CUPV_enabled) then {
	_init = _init + ["hide_front_ti_panels",1,"hide_cip_panel_rear",1,"hide_cip_panel_bustle",1,"Filters_Hide",1];
};

// RHS remove tank panel
if (GRLIB_RHS_enabled) then {
	_init = _init + ["IFF_Panels_Hide",1,"Miles_Hide",1];
};

// Add seat
if (_vehicle isKindOf "Heli_Light_01_civil_base_F") then {
	_init = _init + ["AddDoors",1,"AddBackseats",1,"AddTread",1,"AddTread_Short",0];
};

// Apply changes
if (count _init > 0) then {
	[_vehicle, false, _init] spawn BIS_fnc_initVehicle;
	sleep 0.5;
};
