params ["_vehicle", ["_compo", []]];

if (isNil "_vehicle") exitWith {};
if (count _compo == 0) exitWith {};

comp_class_names = _compo;
VAM_targetvehicle = _vehicle;

[] call fnc_VAM_common_comp;
