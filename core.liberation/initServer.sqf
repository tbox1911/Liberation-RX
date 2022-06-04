//Global Arsenal
if (isNil 'item_blacklist') then {
	[] call compileFinal preprocessFileLineNUmbers "scripts\shared\fetch_params.sqf";
};
if !(isNil 'item_blacklist') then {
	publicVariable "pub_arsenal_box";
	pub_arsenal_box = missionnamespace getVariable ["myLARsBox", objNull];
	[pub_arsenal_box, true, false] call ace_arsenal_fnc_removeVirtualitems;
	[pub_arsenal_box, true] call ace_arsenal_fnc_initBox;
	[pub_arsenal_box, item_blacklist] call ace_arsenal_fnc_removeVirtualitems;
};

["ace_unconscious", {
	// global event (runs on all machines)
	params ["_unit", "_isUnconscious"];

	_allHCs = entities "HeadlessClient_F";
	_allHPs = allPlayers - _allHCs;
	_aliveCount = 0;
	_allCount = count _allHPs;

	if ((_isUnconscious) && (_unit in _allHPs)) then {
		// (format ["%1 is down", name _unit]) remoteExec ["systemChat", 0];
		[getPlayerUID _unit, - respawn_ammo] remoteExec ["F_addPlayerAmmo", 2];
	} else {
		[getPlayerUID _unit, + respawn_ammo] remoteExec ["F_addPlayerAmmo", 2];
	};
}] call CBA_fnc_addEventHandler;

addMissionEventHandler ['EntityKilled', {
	params ["_unit", "_killer"];

	if (isPlayer _unit) then {
		/*
			_hs_unconscious = _unit getVariable ['ACE_isUnconscious', false];
			if (_hs_unconscious == true) then {
				_unit setVariable ["GREUH_ammo_count", ((_unit getVariable ["GREUH_ammo_count", 25]) - 25), true];
			};
		*/
	} else {
		if (isPlayer _killer) then {
			if (side group _unit == opfor) then {
				[getPlayerUID _killer, opfor_kill_score] remoteExec ["F_addPlayerScore", 2];
				[getPlayerUID _killer, opfor_kill_ammo] remoteExec ["F_addPlayerAmmo", 2];
			} else {
				if (((side group _unit == civilian) && (weapons _unit isEqualTo [])) || (side group _unit == blufor)) then {
					_msg = format ["%1 killed a civillian/friendly. Penalty: %2 rank and %3 ammo", name _killer, civkill_score, civkill_ammo];
					[gamelogic, _msg] remoteExec ["globalChat", 0];
					[getPlayerUID _killer, civkill_score] remoteExec ["F_addPlayerScore", 2];
					[getPlayerUID _killer, civkill_ammo] remoteExec ["F_addPlayerAmmo", 2];
				} else {
					if (building_penalty_isActive) then {
						_class = typeOf _unit;
						_tre = [ configFile >> "CfgVehicles" >> _class, true ] call BIS_fnc_returnParents;

						if (("House" in _tre) && !("Strategic" in _tre)) then {
							_cost = [configFile >> "CfgVehicles" >> _class >> "cost"] call BIS_fnc_getCfgData;
							_name = [configFile >> "CfgVehicles" >> _class >> "displayName"] call BIS_fnc_getCfgData;

							_msg = format ["%1 destroyed a civilian building: %2, cost %3", name _killer, _name, _cost];
							[gamelogic, _msg] remoteExec ["globalChat", 0];
						};
					};
				};
			};
		};
	};
}];

/*
	addMissionEventHandler ['HandleDisconnect', {
		_unit = _this select 0;
		_hs_unconscious = _unit getVariable ['ACE_isUnconscious', false];
		if (_hs_unconscious == true) then {
			_unit setVariable ["GREUH_ammo_count", ((_unit getVariable ["GREUH_ammo_count", 25]) - 25), true];
		};
	}];
*/

["Initialize", [true]] call BIS_fnc_dynamicGroups;
