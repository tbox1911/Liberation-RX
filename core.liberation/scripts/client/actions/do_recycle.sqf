params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

//only one player at time
if ((_vehicle getVariable ["recycle_in_use", false])) exitWith {};
_vehicle setVariable ["recycle_in_use", true, true];

private [ "_objectinfo", "_objectinfo_loot", "_loot", "_cfg", "_msg" ];
// XP AmmoBox
if (typeOf _vehicle == ammobox_i_typename && score player <= GRLIB_perm_log) then {
	_msg = format [localize "STR_DO_RECYCLE"];
	_result = [_msg, localize "STR_SP_BOX", localize "STR_PTS", localize "STR_AMMORWD"] call BIS_fnc_guiMessage;
	if (_result && !(isNull _vehicle) && alive _vehicle) then {
		[_vehicle] remoteExec ["deleteVehicle", 2];
		[player, 5] remoteExec ["addScore", 2];
		playSound "taskSucceeded";
		hint format [localize "STR_AMMO_SELL", name player];
		sleep 0.5;
	};
};
if (isNull _vehicle) exitWith {};


// check, if vehicle is looted
_objectinfo_loot = ( [ (opfor_recyclable + ind_recyclable), { typeof _vehicle == _x select 0 } ] call BIS_fnc_conditionalSelect ) select 0;
if (!isNil "_objectinfo_loot") then {
	_loot = true;
}else{
	_loot = false;
};


_objectinfo = ( [ (light_vehicles + heavy_vehicles + air_vehicles + static_vehicles + support_vehicles + buildings + opfor_recyclable + ind_recyclable), { typeof _vehicle == _x select 0 } ] call BIS_fnc_conditionalSelect ) select 0;
if (isNil "_objectinfo") then {
	_objectinfo = [typeOf _vehicle, 0, 0, 0];
};
dorecycle = 0;


_cfg = configFile >> "cfgVehicles";
createDialog "liberation_recycle";
waitUntil { dialog };

private _ammount_ammo = round ((_objectinfo select 2) * GRLIB_recycling_percentage);
ctrlSetText [ 134, format [ localize "STR_RECYCLING_YIELD", getText (_cfg >> (_objectinfo select 0) >> "displayName" ) ] ];
ctrlSetText [ 131, format [ "%1", round (_objectinfo select 1) ] ];
ctrlSetText [ 132, format [ "%1", _ammount_ammo] ];
ctrlSetText [ 133, format [ "%1", round ( _objectinfo select 3) ] ];

while { dialog && (alive player) && dorecycle == 0 } do {
	sleep 0.5;
};

if ( dialog ) then { closeDialog 0 };

if ( dorecycle == 1 && !(isNull _vehicle) && alive _vehicle) exitWith {

	if (typeOf _vehicle in [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename] ) then {
		[player, 5] remoteExec ["addScore", 2];
		hint format [localize "STR_AMMO_SELL2", name player];
		playSound "taskSucceeded";
	};
	
	if (_loot == false) then {
		
		private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
		player setVariable ["GREUH_ammo_count", (_ammo_collected + _ammount_ammo), true];
		player addRating 5;
		
	}else{
		
		{
			private _ammo_collected = _x getVariable ["GREUH_ammo_count",0];
			_x setVariable ["GREUH_ammo_count", (_ammo_collected + _ammount_ammo), true];
			_x addRating 5;
		} forEach allPlayers;
		
		_msg = format ["+ %1 ammo thanks to %2", _ammount_ammo, name player];
		[gamelogic, _msg] remoteExec ["globalChat", 0];
		
	};
	
	

	if (typeOf _vehicle == mobile_respawn) exitWith {
		[_vehicle, "del"] remoteExec ["addel_beacon_remote_call", 2];
	};
	[_vehicle] remoteExec ["deleteVehicle", 2];
	stats_vehicles_recycled = stats_vehicles_recycled + 1; publicVariable "stats_vehicles_recycled";
};
_vehicle setVariable ["recycle_in_use", false, true];
