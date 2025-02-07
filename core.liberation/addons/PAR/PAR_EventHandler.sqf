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

	// No mines in the base zone (Chimera + FOB)
	if (([_unit, "LHD", GRLIB_fob_range] call F_check_near) && _weapon == "Put") then { deleteVehicle _projectile };

	// Sticky bomb
	if (_ammo in sticky_bombs_typename && _weapon == "Put") then { [_projectile] spawn set_sticky_bomb };

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
	if (isNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "artilleryScanner")) then {
		private _res = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "artilleryScanner");
		private _free_rounds = (_magazine in _free_rounds_typename);
		if (_res == 1 && !_free_rounds) then { [_unit, _vehicle] spawn artillery_cooldown };
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
	[player,"LRX_Taxi",nil,nil,""] call BIS_fnc_addCommMenuItem;

	// UI actions
	inGameUISetEventHandler ["Action", "
		private _ret = false;
		if (_this select 3 == 'DisAssemble') then { _ret = true };
		if (_this select 3 == 'Rearm' && !([_this select 1, _this select 0] call is_owner || [_this select 0] call is_public)) then { _ret = true };
		if ((['GetIn', _this select 3, true] call F_startsWith) && !isNull R3F_LOG_joueur_deplace_objet) then { _ret = true };
		if (_ret) then { hintSilent 'You are not allowed to do this' };
		_ret;
	"];

	// Get in Vehicle
	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		if (_vehicle isKindOf "ParachuteBase") exitWith {};
		private _ret = [_unit, _role, _vehicle] call vehicle_permissions;
		if !(_ret) then {
			1 fadeSound (round desired_vehvolume / 100.0);
			3 fadeMusic (getAudioOptionVolumes select 1);
			NRE_EarplugsActive = 1;
			[player, "hide"] remoteExec ["dog_action_remote_call", 2];
			if (GRLIB_thermic == 0 || (GRLIB_thermic == 1 && !(call is_night))) then {
				_vehicle disableTIEquipment true;
			} else {
				_vehicle disableTIEquipment false;
			};
			private _fuel = round (fuel _vehicle * 100);
			private _ammo = round (([_vehicle] call F_getVehicleAmmoDef) * 100);
			private _damage = round (([_vehicle] call F_getVehicleDamage) * 100);
			hintSilent format ["Damage: %1%2\nFuel: %3%4\nAmmo: %5%6", _damage,"%",_fuel,"%",_ammo,"%"];
		};
	}];

	// Get out Vehicle
	_unit removeAllEventHandlers "GetOutMan";
	_unit addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle"];
		if (_vehicle == getConnectedUAV player) then {
			objNull remoteControl _unit;
			player switchCamera cameraView;
		};
		1 fadeSound 1;
		3 fadeMusic 0;
		NRE_EarplugsActive = 0;
		if (!GRLIB_ACE_enabled) then {
			if ( (getPos _unit) select 2 >= 50 && !(_unit getVariable ["AR_Is_Rappelling",false]) && (backpack _unit != "B_Parachute")) then {
				private _para = createVehicle ["Steerable_Parachute_F",(getPos _unit),[],0,'none'];
				_unit moveInDriver _para;
			};
		};
		[_unit] spawn {
			params ["_unit"];
			waitUntil { sleep 1; (round (getPos _unit select 2) <= 0) };
			if (primaryWeapon _unit != "") then { _unit selectWeapon primaryWeapon _unit };
			[_unit, "show"] remoteExec ["dog_action_remote_call", 2];
		};
	}];

	// Switch seat
	_unit removeAllEventHandlers "SeatSwitchedMan";
	_unit addEventHandler ["SeatSwitchedMan", { _this call vehicle_permissions }];

	// Player killed EH
	player addEventHandler ["Killed", { _this spawn PAR_fn_death }];

	// Player respawn EH
	player addEventHandler ["Respawn", { [] spawn PAR_Player_Init }];

	// Player Handle Damage EH
	if (PAR_revive != 0) then {
		player addEventHandler ["HandleDamage", { _this call PAR_HandleDamage_EH }];
	};
} else {
	// AI killed EH
	_unit addEventHandler ["Killed", { _this spawn PAR_fn_death }];

	// Get in Vehicle
	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		private _ret = [_unit, _role, _vehicle] call vehicle_permissions;
		if !(_ret) then {
			[_vehicle] spawn F_vehicleDefense;
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
	_unit addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
	if (PAR_revive != 0) then {
		_unit addEventHandler ["HandleDamage", {
			params ["_unit","","_dam"];
			_veh = objectParent _unit;

			if (!([_unit] call PAR_is_wounded) && _dam >= 0.86) then {
				_unit setVariable ["PAR_isUnconscious", true, true];
				if !(isNull _veh) then {[_unit, _veh] spawn PAR_fn_eject};
				[_unit] spawn PAR_fn_unconscious;
			};
			_dam min 0.86;
		}];
	};
};
