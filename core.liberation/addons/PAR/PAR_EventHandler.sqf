params ["_unit"];

// for All units
// Cannot DisAssemble
_unit enableWeaponDisassembly false;

_unit addEventHandler ["InventoryClosed", {
	params ["_unit", "_container"];
	[_unit] call F_filterLoadout;
	if (_unit == player) then {
		hintSilent format ["Inventory value:\n%1 AMMO.", ([_unit] call F_loadoutPrice)];
		if (GRLIB_filter_arsenal == 4 && _container == GRLIB_personal_box) then { [] spawn save_personal_arsenal };
	};
}];

_unit addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	_ret = false;
	playsound "ZoomIn";
	if (!alive _container) exitWith { _ret };
	if (!([_unit, _container] call is_owner) || locked _container > 1) then {
		closeDialog 106;
		_ret = true;
	};
	_ret;
}];

_unit addEventHandler ["WeaponAssembled", {
	params ["_unit", "_weapon"];
	if (typeOf _weapon in uavs_vehicles) then { [_weapon] spawn F_forceCrew };
}];

_unit addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];
	if !([_item] call is_allowed_item) then {
		_unit removeWeapon _item;
		_unit removeItem _item;
		_unit unlinkItem _item;
	};
}];

_unit addEventHandler ["FiredMan",	{
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

// for Player only
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

	// Backup Weapon state
	_unit removeAllEventHandlers "WeaponChanged";
	_unit addEventHandler ["WeaponChanged", {
		params ["_unit", "_oldWeapon", "_newWeapon", "_oldMode", "_newMode", "_oldMuzzle", "_newMuzzle", "_turretIndex"];
		if (isNull objectParent _unit) then {
			if (_newWeapon == primaryWeapon _unit) then {
				PAR_weapons_state = [_newWeapon, _newMuzzle, _newMode];
			};
		};
	}];

	// Get in Vehicle
	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		if (_vehicle isKindOf "ParachuteBase") exitWith {};
		private _eject = [_unit, _role, _vehicle] call vehicle_permissions;
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
			[player, "hide"] remoteExec ["dog_action_remote_call", 2];
			if (GRLIB_thermic == 0 || (GRLIB_thermic == 1 && !(call is_night))) then {
				_vehicle disableTIEquipment true;
			} else {
				_vehicle disableTIEquipment false;
			};
			[_vehicle] spawn {
				params ["_vehicle"];
				private _owner = [_vehicle] call F_getVehicleOwner;
				private _fuel = round (fuel _vehicle * 100);
				private _ammo = round (([_vehicle] call F_getVehicleAmmoDef) * 100);
				private _damage = round (([_vehicle] call F_getVehicleDamage) * 100);
				private _cargo = [_vehicle] call R3F_LOG_FNCT_calculer_chargement_vehicule;
				hintSilent format [localize "STR_PAR_VEHICLE_STATUS_HINT", _owner, _damage, _fuel, _ammo, _cargo select 0, _cargo select 1];
				1 fadeSound (round desired_vehvolume / 100.0);
				3 fadeMusic (getAudioOptionVolumes select 1);
				NRE_EarplugsActive = 1;
				sleep 2;
				hintSilent "";
			};
		};
	}];

	// Get out Vehicle
	_unit removeAllEventHandlers "GetOutMan";
	_unit addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle"];
		if (_vehicle isKindOf "ParachuteBase") exitWith {};
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
		[_unit] spawn {
			params ["_unit"];
			waitUntil { sleep 1; (round (getPos _unit select 2) == 0) };
			[_unit, "show"] remoteExec ["dog_action_remote_call", 2];
			if (currentWeapon _unit != primaryWeapon _unit) then {
				if (PAR_weapons_state select 0 != "") exitWith { _unit selectWeapon PAR_weapons_state };
				if (primaryWeapon _unit != "") exitWith { _unit selectWeapon (primaryWeapon _unit) };
			};
			1 fadeSound 1;
			3 fadeMusic 0;
			NRE_EarplugsActive = 0;			
		};
	}];

	// Switch seat
	_unit removeAllEventHandlers "SeatSwitchedMan";
	_unit addEventHandler ["SeatSwitchedMan", { _this call vehicle_permissions }];

	// Player killed EH
	player addEventHandler ["Killed", { _this spawn PAR_fn_death }];

	// Player respawn EH
	// player addEventHandler ["Respawn", { _this spawn PAR_Player_Init }];

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
			private _isNotWounded = !([_unit] call PAR_is_wounded);
			if (_isNotWounded && isPlayer _killer && _killer != _unit && vehicle _unit != vehicle _killer && _killer distance2D _unit >= 5) then {
				if (_damage >= 0.35 && (time >= (_unit getVariable ["GRLIB_isProtected", 0]))) then {
					_unit setVariable ["GRLIB_isProtected", round(time + 10)];
					private _msg = format ["%1 (%2)", localize "STR_FRIENDLY_FIRE", name _killer];
					[gamelogic, _msg] remoteExec ["globalChat", 0];
					[_killer, -5] remoteExec ["F_addScore", 2];
					// TK Protect
					if (GRLIB_tk_mode > 0) then {
						["PAR_tkMessage", [_unit, _killer]] remoteExec ["PAR_public_EH", 0];
						[_unit, _killer] remoteExec ["LRX_tk_check", 0];
						_damage = 0;
					};
				};
			};
			private _veh_unit = objectParent _unit;
			if (_isNotWounded && _damage >= 0.86) then {
				if !(isNull _veh_unit) then {[_unit, _veh_unit] spawn PAR_fn_eject};
				_unit setVariable ["PAR_isUnconscious", true, true];
				[_unit, _killer] spawn PAR_Player_Unconscious;
			};
			_damage min 0.86;
		}];
	};
} else {
	// AI killed EH
	_unit addEventHandler ["Killed", { _this spawn PAR_fn_death }];

	// Get in Vehicle
	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		if (_vehicle isKindOf "ParachuteBase") exitWith {};
		private _eject = [_unit, _role, _vehicle] call vehicle_permissions;
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
	_unit addEventHandler ["SeatSwitchedMan", { _this call vehicle_permissions }];

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
};
