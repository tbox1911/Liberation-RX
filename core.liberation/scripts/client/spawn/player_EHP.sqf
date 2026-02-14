params ["_unit"];

// LRX unit Persistent Event Handlers

// General Event Handlers
_unit addEventHandler ["InventoryClosed", {
	params ["_unit", "_container"];
	[_unit] call F_filterLoadout;
	if (_unit == player) then {
		private _vehicle = objectParent _unit;
		if (isNull _vehicle) then {
			hintSilent format ["Inventory value:\n%1 AMMO.", ([_unit] call F_loadoutPrice)];
		} else {
			[_vehicle] spawn vehicle_info;
		};
		if (GRLIB_filter_arsenal == 4 && _container == GRLIB_personal_box) then { [] spawn save_personal_arsenal };
	};
}];

_unit addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	_ret = false;
	playsound "ZoomIn";
	if (!alive _container) exitWith { _ret };

	private _locked = (locked _container > 1);
	if (typeOf _container == Arsenal_typename && GRLIB_filter_arsenal == 4 && !(isObjectHidden _container)) then {
		_locked = true;
	};

	if (!([_unit, _container] call is_owner) || _locked) then {
		closeDialog 106;
		_ret = true;
	};
	_ret;
}];

_unit addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

	// Civilian limit (["Put","Throw"])
	if (side _unit == GRLIB_side_civilian && !(isNil {_unit getVariable "GRLIB_unit_detected"}) && _weapon in ["Put","Throw"]) exitWith {
		gamelogic globalChat "No grenades/mines allowed when Civilian.";
		deleteVehicle _projectile;
	};

	// No mines in the base zone (Chimera + FOB)
	if (([_unit, "LHD", GRLIB_fob_range] call F_check_near) && _weapon == "Put") exitWith {
		gamelogic globalChat "No mines allowed around the FOB.";
		deleteVehicle _projectile;
	};

	// Pay artillery fire
	// if (_vehicle isKindOf "StaticMortar") then {
	// 	[_projectile] spawn {
	// 		params ["_projectile"];
	// 		private _price = 5;
	// 		if (!([_price] call F_pay)) then {
	// 			gamelogic globalChat "Not enough Ammo, Artillery fire canceled.";
	// 			deleteVehicle _projectile;
	// 		} else {
	// 			gamelogic globalChat (format ["Artillery fire cost %1 Ammo.", _price]);
	// 		};
	// 	};
	// };

	// Limit artillery fire
	if (GRLIB_global_stop == 1) exitWith {};
	private _free_rounds_typename = [
		"8Rnd_82mm_Mo_Smoke_white",
		"8Rnd_82mm_Mo_Flare_white",
		"vn_mortar_m29_mag_chem_x8",
		"vn_mortar_m2_mag_lume_x8",
		"vn_mortar_m29_mag_lume_x8"
	];
	private _is_arty = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "artilleryScanner");
	if (_is_arty == 1 && !(_magazine in _free_rounds_typename)) exitWith {
		[_unit, _vehicle] spawn artillery_cooldown;
	};
}];

// Player Event Handlers
if (_unit == player) then {
	// ACE specific
	if (GRLIB_ACE_enabled) then {
		["ace_arsenal_displayClosed", {
			[player] call F_filterLoadout;
			[player] spawn F_payLoadout;
		}] call CBA_fnc_addEventHandler;
	};

	// Unblock units
	[player,"LRX_Unstuck",nil,nil,""] call BIS_fnc_addCommMenuItem;
	//[player,"LRX_Taxi",nil,nil,""] call BIS_fnc_addCommMenuItem;

	// UI actions
	// inGameUISetEventHandler ["PrevAction", "systemchat str _this; false"];
	// inGameUISetEventHandler ["NextAction", "systemchat str _this; false"];
	inGameUISetEventHandler ["Action", "
		private _ret = false;
		if (_this select 3 == 'DisAssemble') then { _ret = true };
		if (_this select 3 == 'Rearm' && !([_this select 1, _this select 0] call is_owner || [_this select 0] call is_public)) then { _ret = true };
		if ((['GetIn', _this select 3, true] call F_startsWith) && !isNull R3F_LOG_joueur_deplace_objet) then { _ret = true };
		if (_ret) then { hintSilent 'You are not allowed to do this' };
		_ret;
	"];

	// Player killed EH
	_unit removeAllEventHandlers "Killed";
	_unit addEventHandler ["Killed", { _this spawn PAR_fn_death }];

	// Player respawn EH
	_unit removeAllEventHandlers "Respawn";
	_unit addEventHandler ["Respawn", { _this spawn player_respawn }];

	// Player Handle Damage EH
	if (PAR_revive != 0) then {
		player addEventHandler ["HandleDamage", {
			params ["_unit", "", "_damage", "_killer", "", "", "_instigator"];
			if (!isNull _instigator) then {
				if (isNull (getAssignedCuratorLogic _instigator)) then {
					_killer = _instigator;
				};
			} else {
				if (!(_killer isKindOf "CAManBase")) then {
					_killer = effectiveCommander _killer;
				};
			};
			if (!([_unit] call PAR_is_wounded) && !(captive _unit)) then {
				if (isPlayer _killer && _killer != _unit && vehicle _unit != vehicle _killer && _killer distance2D _unit >= 3) exitWith {
					if (time >= (_unit getVariable ["GRLIB_isProtected", 0])) then {
						_unit setVariable ["GRLIB_isProtected", round(time + 10)];
						private _msg = format ["%1 (%2)", localize "STR_FRIENDLY_FIRE", name _killer];
						[gamelogic, _msg] remoteExec ["globalChat", 0];
						[_killer, -15] remoteExec ["F_addScore", 2];
						// TK Protect
						if (GRLIB_tk_mode > 0) then {
							["PAR_tkMessage", [_unit, _killer]] remoteExec ["PAR_public_EH", 0];
							[_unit, _killer] remoteExec ["LRX_tk_check", 0];
						};
					};
					_damage = 0;
				};

				private _veh_unit = objectParent _unit;
				if (_damage >= 0.86) then {
					if !(isNull _veh_unit) then {[_unit, _veh_unit] spawn PAR_fn_eject};
					_unit setVariable ["PAR_isUnconscious", true, true];
					[_unit, _killer] spawn PAR_fn_playerWounded;
				};
			};
			(_damage min 0.86);
		}];
	};

	// ACE specific
	if (GRLIB_ACE_medical_enabled) then {
		private _enabled = ((["PAR_Revive"] call lrx_getParamValue) != 0);
		if (_enabled) then {
			["ace_unconscious", {
				params ["_unit", "_isUnconsious"];
				if (_isUnconsious && _unit == player) then {
					_unit setVariable ["PAR_ACE_isUnconscious", true, true];
					_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_bleedout), true];
					private _killer = _unit getVariable ["ace_medical_lastDamageSource", objNull];
					[_unit, _killer] spawn PAR_fn_playerWounded;
				};
			}] call CBA_fnc_addEventHandler;
		};
	};

	// Get in Vehicle
	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		private _my_dog = _unit getVariable ["my_dog", nil];
		if (_vehicle isKindOf "ParachuteBase") then {
			if (!isNil "_my_dog") then {
				_my_dog stop true;
				_my_dog switchMove "Dog_Sit";
				_my_dog attachTo [_unit, [0.6, 0.2, -0.5], "Pelvis"];
				_my_dog setVectorDirAndUp [[1, 0, 0], [0, 0, 1]];
				[_my_dog, false] remoteExec ["hideObjectGlobal", 2]
			};
		} else {
			private _eject = [_unit, _role, _vehicle] call vehicle_perm;
			if (!_eject) then {
				if (local _vehicle && !(typeOf _vehicle in list_static_weapons)) then {
					if (GRLIB_vehicle_defense) then {
						[_vehicle] spawn F_vehicleDefense;
					} else {
						_vehicle removeAllEventHandlers "IncomingMissile";
					};
					if (isNil {_vehicle getVariable "GREUH_vehicle_damage_he"}) then {
						_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
						_vehicle setVariable ["GREUH_vehicle_damage_he", true];
					};
				};
				if (GRLIB_thermic == 0 || (GRLIB_thermic == 1 && !(call is_night))) then {
					_vehicle disableTIEquipment true;
				} else {
					_vehicle disableTIEquipment false;
				};
				if (!isNil "_my_dog") then { [_my_dog, true] remoteExec ["hideObjectGlobal", 2] };
				[_vehicle] spawn vehicle_info;
				1 fadeSound (round desired_vehvolume / 100.0);
				3 fadeMusic (getAudioOptionVolumes select 1);
				NRE_EarplugsActive = 1;
				[true] call player_vehicle_actions;
			};
		};
	}];

	// Get out Vehicle
	_unit removeAllEventHandlers "GetOutMan";
	_unit addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle"];
		private _my_dog = _unit getVariable ["my_dog", nil];
		if (_vehicle isKindOf "ParachuteBase") then {
			if (!isNil "_my_dog") then {
				detach _my_dog;
				_my_dog stop false;
			};
		} else {
			if (_vehicle == getConnectedUAV player) then {
				objNull remoteControl _unit;
				player switchCamera cameraView;
			};
			if (!GRLIB_ACE_enabled) then {
				if ( (getPos _unit) select 2 >= 50 && !(_unit getVariable ["AR_Is_Rappelling",false]) && (backpack _unit != "B_Parachute")) then {
					private _para = createVehicle ["Steerable_Parachute_F",(getPos _unit),[],0,'none'];
					_unit moveInDriver _para;
				};
			};
			if (!isNil "_my_dog") then { [_my_dog, false] remoteExec ["hideObjectGlobal", 2] };
			[_unit] spawn {
				params ["_unit"];
				waitUntil { sleep 1; (round (getPos _unit select 2) == 0) };
				if (currentWeapon _unit != primaryWeapon _unit) then {
					if (PAR_weapons_state select 0 != "") exitWith { _unit selectWeapon PAR_weapons_state };
					if (primaryWeapon _unit != "") exitWith { _unit selectWeapon (primaryWeapon _unit) };
				};
				1 fadeSound 1;
				3 fadeMusic 0;
				NRE_EarplugsActive = 0;
			};
			[false] call player_vehicle_actions;
			if ([_unit, _vehicle, true] call is_owner && [_vehicle] call F_vehicleSafeZone) then {
				private _msg = localize "STR_FOB_SAFE_ZONE";
				[_msg, 0, 0, 5, 0, 0, 90] spawn BIS_fnc_dynamicText;
			};
		};
	}];

	// Switch seat
	_unit removeAllEventHandlers "SeatSwitchedMan";
	_unit addEventHandler ["SeatSwitchedMan", { _this call vehicle_perm }];
} else {
	// AI killed EH
	_unit removeAllEventHandlers "Killed";
	_unit addEventHandler ["Killed", { _this spawn PAR_fn_death }];

	// AI Handle Damage EH
	if (PAR_revive != 0) then {
		_unit addEventHandler ["HandleDamage", {
			params ["_unit","","_damage"];
			if (!([_unit] call PAR_is_wounded) && _damage >= 0.86) then {
				_unit setVariable ["PAR_isUnconscious", true, true];
				private _veh_unit = objectParent _unit;
				if !(isNull _veh_unit) then {[_unit, _veh_unit] spawn PAR_fn_eject};
				[_unit] spawn PAR_fn_unconscious;
			};
			_damage min 0.86;
		}];
	};

	// Get in Vehicle
	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		if (_vehicle isKindOf "ParachuteBase") exitWith {};
		private _eject = [_unit, _role, _vehicle] call vehicle_perm;
		if (!_eject) then {
			if (local _vehicle && !(typeOf _vehicle in list_static_weapons)) then {
				if (GRLIB_vehicle_defense) then {
					[_vehicle] spawn F_vehicleDefense;
				} else {
					_vehicle removeAllEventHandlers "IncomingMissile";
				};
				if (isNil {_vehicle getVariable "GREUH_vehicle_damage_he"}) then {
					_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
					_vehicle setVariable ["GREUH_vehicle_damage_he", true];
				};
			};
		};
	}];

	// Get out Vehicle
	_unit addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle"];
		if (_vehicle == getConnectedUAV player) then {
			objNull remoteControl _unit;
			player switchCamera cameraView;
		};
	}];

	// Switch seat
	_unit removeAllEventHandlers "SeatSwitchedMan";
	_unit addEventHandler ["SeatSwitchedMan", { _this call vehicle_perm }];

	// Add heal capabilities to player's group's medic when ACE is present
	if (GRLIB_ACE_medical_enabled && ([_unit] call PAR_is_medic)) then {
		// need upgrade
		// [_unit] spawn F_aceMedicHeal;
	};
};
