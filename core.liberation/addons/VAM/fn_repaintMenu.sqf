params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

VAM_targetvehicle = _vehicle;
createDialog 'VAM_GUI';
