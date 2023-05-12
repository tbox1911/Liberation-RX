params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

if (!([player, _vehicle] call is_owner)) exitWith { hintSilent "Wrong Vehicle Owner.\nAccess is Denied !" };
if ((damage _vehicle) != 0) exitWith { hintSilent "Damaged Vehicles cannot be Painted !" };
if ([typeOf _vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass) exitWith { hintSilent "This Vehicle cannot be Painted !" };

VAM_targetvehicle = _vehicle;
createDialog 'VAM_GUI';
