params ["_vehicle", "_texture", "_name"];

if (isNil "_vehicle") exitWith {};

camo_class_names = [_texture];
camo_display_names = [_name];
VAM_targetvehicle = _vehicle;

[] call fnc_VAM_common_camo;
//[] call fnc_VAM_common_comp;
