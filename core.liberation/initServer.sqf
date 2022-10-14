//Global Arsenal
if (isNil 'equipment') then {
	[] call compileFinal preprocessFileLineNUmbers "MilSimUnited\create_arsenal_Itemlist.sqf";
};
if !(isNil 'equipment') then {
	sleep 2;
	pub_arsenal_box = equipment - item_blacklist + item_whitelist;
	publicVariable 'pub_arsenal_box';
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
				
				_score = opfor_kill_score;
				_ammo = opfor_kill_ammo;
				if  (typeOf _killer == "B_Soldier_F") then {
					_score = opfor_kill_score_infantry;
					_ammo = opfor_kill_ammo_infantry;
				};
				
				[getPlayerUID _killer, _score] remoteExec ["F_addPlayerScore", 2];
				[getPlayerUID _killer, _ammo] remoteExec ["F_addPlayerAmmo", 2];
				diag_log format ["[Ammo] %1 Killed opfor  %2", name _killer, _ammo ];
				
			} else {
				if (((side group _unit == civilian) && (weapons _unit isEqualTo [])) || (side group _unit == blufor)) then {
					_msg = format ["%1 killed a civillian/friendly/prisoner. Penalty: %2 rank, %3 ammo, +%4 aggression ", name _killer, civkill_score, civkill_ammo, civkill_combat_readiness];
					[gamelogic, _msg] remoteExec ["globalChat", 0];
					[getPlayerUID _killer, civkill_score] remoteExec ["F_addPlayerScore", 2];
					[getPlayerUID _killer, civkill_ammo] remoteExec ["F_addPlayerAmmo", 2];
					combat_readiness = combat_readiness + civkill_combat_readiness;
					
					diag_log format ["[Ammo] %1 Killed Civ - %2", name _killer, civkill_ammo ];
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





