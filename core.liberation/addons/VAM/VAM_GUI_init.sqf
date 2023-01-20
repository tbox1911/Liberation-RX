//Vehicle Appearance Manager GUI init
if (!hasInterface) exitWith {};

//1 : Activate when player is near LRX Liberation FOB
//2 : Activate when player is near vehicles those are in list.
VAM_repair_vehicle_list = [
	"Land_RepairDepot_01_civ_F"
];

//Function preload
fnc_VAM_GUI_check = compileFinal preprocessFileLineNumbers "addons\VAM\functions\fnc_VAM_GUI_check.sqf";
fnc_VAM_reset = compileFinal preprocessFileLineNumbers "addons\VAM\functions\fnc_VAM_reset.sqf";
fnc_VAM_variable_cleaner = compileFinal preprocessFileLineNumbers "addons\VAM\functions\fnc_VAM_variable_cleaner.sqf";

//Vehicle Function
fnc_VAM_common_setup = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_setup.sqf";
fnc_VAM_common_camo_check = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_camo_check.sqf";
fnc_VAM_common_comp_check = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_comp_check.sqf";
// declared in init_shared.sqf
//fnc_VAM_common_camo = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_camo.sqf";
//fnc_VAM_common_comp = compileFinal preprocessFileLineNumbers "addons\VAM\vehicles\fnc_VAM_common_comp.sqf";

systemchat localize "STR_VAM_INITIALIZED";
