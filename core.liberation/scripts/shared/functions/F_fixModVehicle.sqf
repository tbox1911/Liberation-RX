params ["_vehicle"];

// CUP remove tank panel
if (GRLIB_CUPV_enabled) then {
	[_vehicle, false, ["hide_front_ti_panels",1,"hide_cip_panel_rear",1,"hide_cip_panel_bustle",1,"Filters_Hide",1]] spawn BIS_fnc_initVehicle;
};

// RHS remove tank panel
if (GRLIB_RHS_enabled) then {
	[_vehicle, false, ["IFF_Panels_Hide",1,"Miles_Hide",1]] spawn BIS_fnc_initVehicle;
};
