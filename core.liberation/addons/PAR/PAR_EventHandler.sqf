params ["_unit"];

// For all
// Cannot DisAssemble
_unit enableWeaponDisassembly false;

// Check Veh perms
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];

_unit addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle"];
	if (_vehicle == getConnectedUAV player) then {
		objNull remoteControl _unit;
		player switchCamera cameraView;
	};
}];

_unit addEventHandler ["InventoryClosed", {
	params ["_unit"];
	[_unit] call F_filterLoadout;
	if (_unit == player) then {
		hintSilent format ["Inventory value:\n%1 AMMO.", ([_unit] call F_loadoutPrice)];
	};
}];

_unit addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	_ret = false;
	playsound "ZoomIn";
	if (!alive _container) exitWith { _ret };
	if (GRLIB_permission_vehicles) then {
		if (!([_unit, _container] call is_owner) || locked _container > 1) then {
			closeDialog 106;
			_ret = true;
		};
	};
	_ret;
}];

_unit addEventHandler ["WeaponAssembled", {
	params ["_unit", "_staticWeapon"];
	if ((typeOf _staticWeapon) in uavs) then { [_staticWeapon] spawn F_forceBluforCrew };
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
	if (_ammo in sticky_bombs_typename && _weapon == "Put") then {
		[_projectile] spawn set_sticky_bomb;
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
}];

// Player
if (_unit == player) then {

	// ACE specific
	if (GRLIB_ACE_enabled) then {
		["ace_arsenal_displayClosed", {
			[player] call F_filterLoadout;
			[player] spawn F_payLoadout;
		}] call CBA_fnc_addEventHandler;
	};

	// Unblock units
	missionNamespace setVariable [
	"BIS_fnc_addCommMenuItem_menu", [
		["Do it !", true],
		["Unblock unit.", [2], "", -5, [["expression", "[groupSelectedUnits player] spawn PAR_unblock_AI"]], "1", "1"]
	]];

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
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		1 fadeSound (round desired_vehvolume / 100.0);
		3 fadeMusic (getAudioOptionVolumes select 1);
		NRE_EarplugsActive = 1;
		[player, "hide"] remoteExec ["dog_action_remote_call", 2];
		if (GRLIB_thermic == 0 || (GRLIB_thermic == 1 && !(call is_night))) then {
			_vehicle disableTIEquipment true;
		} else {
			_vehicle disableTIEquipment false;
		};
		_this spawn vehicle_permissions;
		if (_vehicle iskindof "Steerable_Parachute_F") exitWith {};
		_fuel = round (fuel _vehicle * 100);
		_ammo = round (([_vehicle] call F_getVehicleAmmoDef) * 100);
		_damage = round (damage _vehicle * 100);
		hintSilent format ["Damage: %1%2\nFuel: %3%4\nAmmo: %5%6", _damage,"%",_fuel,"%",_ammo,"%"];
	}];

	// Get out Vehicle
	_unit addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle"];
		1 fadeSound 1;
		3 fadeMusic 0;
		NRE_EarplugsActive = 0;
		if (!GRLIB_ACE_enabled) then {
			if ( (getPos _unit) select 2 >= 20 && !(_unit getVariable ["AR_Is_Rappelling",false]) ) then {
				[_vehicle, _unit] spawn F_ejectUnit;
			};
		};
		[_unit] spawn {
			params ["_unit"];
			waitUntil {sleep 1; isTouchingGround (vehicle _unit)};
			if (primaryWeapon _unit != "") then { _unit selectWeapon primaryWeapon _unit };
			[_unit, "show"] remoteExec ["dog_action_remote_call", 2];
		};
	}];

	// Player killed EH
	player addEventHandler ["Killed", { _this spawn PAR_fn_death }];

	// Player respawn EH
	player addEventHandler ["Respawn", { [] spawn PAR_Player_Init }];

	// Player Handle Damage EH
	if (GRLIB_revive != 0) then {
		player addEventHandler ["HandleDamage", { _this call PAR_HandleDamage_EH }];
		[] spawn PAR_AI_Manager;
	};
} else {
	// AI killed EH
	_unit addEventHandler ["Killed", { _this spawn PAR_fn_death }];	

	// AI Handle Damage EH
	_unit addEventHandler ["HandleDamage", { _this call damage_manager_friendly }];
	if (GRLIB_revive != 0) then {
		_unit addEventHandler ["HandleDamage", {
			params ["_unit","","_dam"];
			_veh = objectParent _unit;
			if (!(isNull _veh) && damage _veh > 0.8) then {[_veh, _unit, true] spawn PAR_fn_eject};

			private _isNotWounded = !(_unit getVariable ["PAR_wounded", false]);
			if (_isNotWounded && _dam >= 0.86) then {
				if (!isNull _veh) then {[_veh, _unit] spawn PAR_fn_eject};
				_unit allowDamage false;
				_unit setVariable ["PAR_wounded", true];
				_unit setUnconscious true;
				_unit setVariable ["PAR_BleedOutTimer", round(time + PAR_BleedOut), true];
				[_unit] spawn PAR_fn_unconscious;
			};
			_dam min 0.86;
		}];
	};
};
