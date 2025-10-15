params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

// Only one player at time
if ((_vehicle getVariable ["recycle_in_use", false])) exitWith {};
_vehicle setVariable ["recycle_in_use", true, true];

private _veh_class = typeOf _vehicle;

// Land Money
if (_veh_class == money_typename) exitWith {
	private _ammount_ammo = round (10 + floor random 70);
	[player, _ammount_ammo, 0] remoteExec ["ammo_add_remote_call", 2];
	deleteVehicle _vehicle;
	hint format [localize "STR_ADD_AMMO", name player, _ammount_ammo];
	playSound "taskSucceeded";
};

// XP AmmoBox
private _result = false;
if (_veh_class == ammobox_i_typename && [player] call F_getScore <= GRLIB_perm_log) then {
	private _msg = format [localize "STR_DO_RECYCLE"];
	_result = [_msg, localize "STR_SP_BOX", localize "STR_PTS", localize "STR_AMMORWD"] call BIS_fnc_guiMessage;
	if (_result && !(isNull _vehicle) && alive _vehicle) then {
		deleteVehicle _vehicle;
		[player, 50] remoteExec ["F_addScore", 2];
		playSound "taskSucceeded";
		hint format [localize "STR_ADD_SCORE", name player, 50];
		sleep 0.5;
	};
};
if (_result) exitWith {};

// Classic Recycle
private _objectinfo = (GRLIB_recycleable_info select { _x select 0 == _veh_class }) select 0;
if (isNil "_objectinfo") then { _objectinfo = [_veh_class, 0, 0, 0] };

dorecycle = 0;

createDialog "liberation_recycle";
waitUntil { dialog };

private _ammount_ammo = round (((_objectinfo select 2) * GRLIB_recycling_percentage) * (1 - damage _vehicle));
private _ammount_fuel = _objectinfo select 3;
if (_veh_class == fuelbarrel_typename) then { _ammount_ammo = 0 };
if (_veh_class in GRLIB_Ammobox_keep + GRLIB_disabled_arsenal) then {
	_ammount_ammo = round (([_vehicle] call F_loadoutPrice) * GRLIB_recycling_percentage);
};

if (_veh_class == box_uavs_typename) then {
	private _drone_count = count (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
	private _drone_price = [uavs_light, air_vehicles] call F_getObjectPrice;
	_ammount_ammo = (_drone_price * _drone_count);
};
ctrlSetText [131, format ["%1", _objectinfo select 1]];
ctrlSetText [132, format ["%1", _ammount_ammo]];
ctrlSetText [133, format ["%1", _ammount_fuel]];
ctrlSetText [134, format [localize "STR_RECYCLING_YIELD", [(_objectinfo select 0)] call F_getLRXName]];

while { dialog && (alive player) && dorecycle == 0 } do { sleep 0.5 };
if ( dialog ) then { closeDialog 0 };

if ( dorecycle == 1 && !(isNull _vehicle) && (alive _vehicle || _veh_class in all_buildings_classnames) ) exitWith {
	if (_veh_class in [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename] && [player] call F_getScore <= GRLIB_perm_tank) then {
		[player, 10] remoteExec ["F_addScore", 2];
		hint format [localize "STR_ADD_SCORE", name player, 10];
		playSound "taskSucceeded";
	};
	[player, _ammount_ammo, _ammount_fuel] remoteExec ["ammo_add_remote_call", 2];

	if (_veh_class == mobile_respawn) exitWith {
		[_vehicle, "del"] remoteExec ["mobile_respawn_remote_call", 2];
	};

	{ deleteVehicle _x } forEach (crew _vehicle);
	deleteVehicle _vehicle;

	if (_veh_class in uavs_vehicles) then {
		[player] call F_correctUAVT;
	};

	if (_veh_class == storage_medium_typename) then {
		{
			deleteVehicle _x;
		} forEach ((nearestObjects [getPos _vehicle, ["VR_Area_01_square_2x2_yellow_F"], 20]));
	};

	stats_vehicles_recycled = stats_vehicles_recycled + 1;
	publicVariable "stats_vehicles_recycled";
};
_vehicle setVariable ["recycle_in_use", false, true];
