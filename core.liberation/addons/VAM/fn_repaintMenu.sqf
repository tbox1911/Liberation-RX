params ["_vehicle"];

if (isNil "_vehicle") exitWith {};

if (!([player, _vehicle] call is_owner)) exitWith { hintSilent "Wrong Vehicle Owner.\nAccess is Denied !" };
if ([_vehicle] call F_VehicleNeedRepair) exitWith { hintSilent "Damaged Vehicles cannot be Painted !" };
if ([_vehicle, GRLIB_vehicle_blacklist] call F_itemIsInClass) exitWith { hintSilent "This Vehicle cannot be Painted !" };

if (!local _vehicle) then {
	if (count crew _vehicle == 0) then {
		[_vehicle, clientOwner] remoteExec ["setOwner", 2];
	} else {
		private _grp = group (crew _vehicle select 0);
		[_grp, clientOwner] remoteExec ["setGroupOwner", 2];
	};
	waitUntil { sleep 0.2; local _vehicle };
};

VAM_targetvehicle = _vehicle;
createDialog "VAM_GUI";
waitUntil { dialog };
[] spawn fnc_VAM_GUI_check;
