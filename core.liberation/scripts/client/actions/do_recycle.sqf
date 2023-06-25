params ["_vehicle"];
if (isNil "_vehicle") exitWith {};
private _veh_class = typeOf _vehicle;

//only one player at time
if ((_vehicle getVariable ["recycle_in_use", false])) exitWith {};
_vehicle setVariable ["recycle_in_use", true, true];

// XP AmmoBox
private _result = false;
if (_veh_class == ammobox_i_typename && [player] call F_getScore <= GRLIB_perm_log) then {
	private _msg = format [localize "STR_DO_RECYCLE"];
	_result = [_msg, localize "STR_SP_BOX", localize "STR_PTS", localize "STR_AMMORWD"] call BIS_fnc_guiMessage;
	if (_result && !(isNull _vehicle) && alive _vehicle) then {
		[_vehicle] remoteExec ["deleteVehicle", 2];
		[player, 50] remoteExec ["F_addScore", 2];
		playSound "taskSucceeded";
		hint format [localize "STR_AMMO_SELL", name player, 50];
		sleep 0.5;
	};
};
if (_result) exitWith {};

// Classic Recycle
private _objectinfo = ( [ (light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + buildings + opfor_recyclable + ind_recyclable), { _veh_class == _x select 0 } ] call BIS_fnc_conditionalSelect ) select 0;
if (isNil "_objectinfo") then { _objectinfo = [_veh_class, 0, 0, 0] };
private _buildings = [];
{ _buildings pushBack (_x select 0) } foreach buildings;
dorecycle = 0;

createDialog "liberation_recycle";
waitUntil { dialog };

private _ammount_ammo = round (((_objectinfo select 2) * GRLIB_recycling_percentage) * (1 - damage _vehicle));
private _ammount_fuel = _objectinfo select 3;
if (_veh_class == fuelbarrel_typename) then { _ammount_ammo = 0 };
ctrlSetText [ 134, format [ localize "STR_RECYCLING_YIELD",  [(_objectinfo select 0)] call F_getLRXName ] ];
ctrlSetText [ 131, format [ "%1", _objectinfo select 1 ] ];
ctrlSetText [ 132, format [ "%1", _ammount_ammo ] ];
ctrlSetText [ 133, format [ "%1", _ammount_fuel ] ];

while { dialog && (alive player) && dorecycle == 0 } do { sleep 0.5 };
if ( dialog ) then { closeDialog 0 };

if ( dorecycle == 1 && !(isNull _vehicle) && (alive _vehicle || _veh_class in _buildings) ) exitWith {
	if (_veh_class in [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename] && [player] call F_getScore <= GRLIB_perm_log) then {
		[player, 10] remoteExec ["F_addScore", 2];
		hint format [localize "STR_AMMO_SELL", name player, 10];
		playSound "taskSucceeded";
	};
	[player, _ammount_ammo, _ammount_fuel] remoteExec ["ammo_add_remote_call", 2];
	player addRating 50;

	if (_veh_class == mobile_respawn) exitWith {
		[_vehicle, "del"] remoteExec ["addel_beacon_remote_call", 2];
	};
	[_vehicle] remoteExec ["deleteVehicle", 2];
	stats_vehicles_recycled = stats_vehicles_recycled + 1;
	publicVariable "stats_vehicles_recycled";
};
_vehicle setVariable ["recycle_in_use", false, true];
