params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

//only one player at time
if ((_vehicle getVariable ["recycle_in_use", false])) exitWith {};
_vehicle setVariable ["recycle_in_use", true, true];

/*
 // loads classname list with all factions
 _handle = player execVM "mod_template\CP_USMC_W\classnames_west.sqf";
	waitUntil {
    	scriptDone _handle
 }; 
*/

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
_objectinfo_loot = ( [ (opfor_recyclable + ind_recyclable + loot_crates), { typeof _vehicle == _x select 0 } ] call BIS_fnc_conditionalSelect ) select 0;
if (!isNil "_objectinfo_loot") then {
	_loot = true;
}else{
	_loot = false;
};

_objectinfo = ( [ (light_vehicles + strong_light_vehicles  + heavy_vehicles + strong_heavy_vehicles + air_vehicles + fast_air_vehicle + static_vehicles + support_vehicles + support_crates + buildings + opfor_recyclable + ind_recyclable + loot_crates), { typeof _vehicle == _x select 0 } ] call BIS_fnc_conditionalSelect ) select 0;
if (isNil "_objectinfo") then {
	if (!(_vehicle isKindOf "StaticWeapon") && !(typeOf _vehicle == "ACE_bodyBagObject")) then {
		_objectinfo = [typeOf _vehicle, 0, 50, 0];
	}else {
		_objectinfo = [typeOf _vehicle, 0, 0, 0];
	};
};
dorecycle = 0;

_cfg = configFile >> "cfgVehicles";
createDialog "liberation_recycle";
waitUntil { dialog };

private _ammount_ammo= 5;
if (typeOf _vehicle in GRLIB_Ammobox_keep) then {
	_ammount_ammo= 5;
}else {
	_ammount_ammo = round ((_objectinfo select 2) * GRLIB_recycling_percentage);
};

ctrlSetText [ 134, format [ localize "STR_RECYCLING_YIELD", getText (_cfg >> (_objectinfo select 0) >> "displayName" ) ] ];
ctrlSetText [ 131, format [ "%1", round (_objectinfo select 1) ] ];
ctrlSetText [ 132, format [ "%1", _ammount_ammo] ];
ctrlSetText [ 133, format [ "%1", round ( _objectinfo select 3) ] ];

while { dialog && (alive player) && dorecycle == 0 } do {
	sleep 0.5;
};

if ( dialog ) then { closeDialog 0 };



_loot_crate = ( [ (loot_crates), { typeof _vehicle == _x select 0 } ] call BIS_fnc_conditionalSelect ) select 0;

if (dorecycle == 1 && !(isNull _vehicle) && alive _vehicle) exitwith {
	if (isNil "show_who_recycle_on") then {
		show_who_recycle_on = false
	};

	if (show_who_recycle_on) then {
		private _uid = getPlayerUID player;
		private _uid_veh = _vehicle getVariable ["GRLIB_vehicle_owner", ""];
		private _name_player = name player;
		private _name_player_vehicle = "";
		private _vehicle_name = getText (_cfg >> (_objectinfo select 0) >> "displayName");
		if (_uid == _uid_veh) then {
			hint "That was your vehicle."
		} else {
			{
				if (_x select 0 == _uid_veh) then {
					_name_player_vehicle = _x select 3;
				};
			} count GRLIB_player_scores;

			private _msg_r = format ["%1 recycled the %2 from %3!", _name_player, _vehicle_name, _name_player_vehicle];
			
			if (hasInterface) then {
				[gamelogic, _msg_r] remoteExec ["globalChat", 0];
			}
		};
	};

    if (typeOf _vehicle in [ammobox_b_typeName, ammobox_o_typeName, ammobox_i_typeName]) then {
        [player, 5] remoteExec ["addscore", 2];
        hint format [localize "str_ammo_SELL2", name player];
        playSound "taskSucceeded";
    };
    
    if (_loot == false) then {
        private _ammo_collected = player getVariable ["GREUH_ammo_count", 0];
        player setVariable ["GREUH_ammo_count", (_ammo_collected + _ammount_ammo), true];
        player addrating 5;
    } else {

        if (!isNil "_loot_crate" && logistics_ammo_increase) then {
            {
                private _ammo_collected = _x getVariable ["GREUH_ammo_count", 0];
                _x setVariable ["GREUH_ammo_count", (_ammo_collected + (_ammount_ammo / 2)), true];
                _x addrating 5;
            } forEach allplayers;

			private _ammo_collected = player getVariable ["GREUH_ammo_count", 0];
            player setVariable ["GREUH_ammo_count", (_ammo_collected + _ammount_ammo), true];


            _msg = format ["+ %1 ammo thanks to %2", _ammount_ammo / 2, name player];
            
            if (hasinterface) then {
                [gamelogic, _msg] remoteExec ["globalChat", 0];
            }
        } else {
            {
                private _ammo_collected = _x getVariable ["GREUH_ammo_count", 0];
                _x setVariable ["GREUH_ammo_count", (_ammo_collected + _ammount_ammo), true];
                _x addrating 5;
            } forEach allplayers;
            
            _msg = format ["+ %1 ammo thanks to %2", _ammount_ammo, name player];
            
            if (hasinterface) then {
                [gamelogic, _msg] remoteExec ["globalChat", 0];
            }
        }
    };
    
    if (typeOf _vehicle == mobile_respawn) exitwith {
        [_vehicle, "del"] remoteExec ["addel_beacon_remote_call", 2];
    };
    [_vehicle] remoteExec ["deletevehicle", 2];
    stats_vehicles_recycled = stats_vehicles_recycled + 1;
    publicVariable "stats_vehicles_recycled";
	
	_msg = format ["%1 recycled %2", name player, typeOf _vehicle];
	[_msg] remoteExec ["log_on_server", 2];
};
_vehicle setVariable ["recycle_in_use", false, true];
