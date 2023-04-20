params ["_unit"];
// Cleanup
{_unit removeAllEventHandlers _x} count [
	"GetInMan",
	"GetOutMan",
	"SeatSwitchedMan",
	"InventoryOpened",
	"InventoryClosed",
	"FiredMan",
	"WeaponAssembled"
];

// For all

// Check Veh perms
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["GetInMan", {_this spawn vehicle_defense}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_veh"];
	if (_veh == getConnectedUAV player) then {
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
	if (!([_unit, _container] call is_owner)) then {
		closeDialog 106;
		_ret = true;
	} else {
		playsound "ZoomIn";
	};
	_ret;
}];

_unit addEventHandler ["WeaponAssembled", {
	params ["_unit", "_staticWeapon"];
	if ((typeOf _staticWeapon) in uavs) then { [_staticWeapon] spawn F_forceBluforCrew };
}];

// No mines in the base zone + pay artillery fire
_unit addEventHandler ["FiredMan",	{
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

	if (count GRLIB_all_fobs >= 0) then {
		if (((_unit distance2D ([] call F_getNearestFob) < GRLIB_fob_range) || (_unit distance2D lhd < 500)) && _weapon == "Put") then {deleteVehicle _projectile};
	};

	// Pay for atry shoot
	// if (typeOf _vehicle in vehicle_artillery) then {
	// 	private _cost = 5;
	// 	private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
	// 	if (_ammo_collected >= 5) then {
    // 		player setVariable ["GREUH_ammo_count", (_ammo_collected - _cost), true];
	// 		gamelogic globalChat (format ["Artillery fire cost %1 Ammo.", _cost]);
	// 	} else {
	// 		gamelogic globalChat "Not enough Ammo, Artillery fire canceled.";
	// 		deleteVehicle _projectile;
	// 	};
	// };
}];

// Player
if (_unit == player && alive player && player isKindOf "Man") then {
	// ACE specific
	if (GRLIB_ACE_enabled) then {
		["ace_arsenal_displayClosed", {[player] call F_payLoadout}] call CBA_fnc_addEventHandler;
	} else {
		// Clean player body
		_unit removeAllEventHandlers "Killed";
		_unit addEventHandler ["Killed", {_this spawn PAR_fn_Killed}];

		// Filter and Pay Loadout
		[missionNamespace, "arsenalClosed", {[player] call F_filterLoadout;[player] call F_payLoadout}] call BIS_fnc_addScriptedEventHandler;

		// Unblock unit(s) 0-8-1
		PAR_unblock_AI = {
			params ["_unit_array"];
			if ( count _unit_array == 0 ) then {
				player setPos (getPos player vectorAdd [([] call F_getRND), ([] call F_getRND), 1]);
			} else {
				{
					_unit = _x;
					if (round (player distance2D _unit) < 50 && (lifeState _unit != 'INCAPACITATED') && vehicle _unit == _unit) then {
						doStop _unit;
						sleep 1;
						_unit doWatch objNull;
						_unit switchmove "";
						_unit disableAI "ALL";
						_grp = createGroup [GRLIB_side_friendly, true];
						[_unit] joinSilent _grp;
						doStop _unit;
						sleep 1;
						_unit setPos (getPos player vectorAdd [([] call F_getRND), ([] call F_getRND), 1]);
						[_unit] joinSilent (group player);
						_unit enableAI "ALL";
						_unit doFollow leader player;
						_unit switchMove "amovpknlmstpsraswrfldnon";
					} else {
						hintSilent "Unit is too far or is unconscious. (max 50m)";
					};
				} forEach _unit_array;
			};
		};
		// Unblock units
		missionNamespace setVariable [
		"BIS_fnc_addCommMenuItem_menu", [
			["Do it !", true],
			["Unblock unit.", [2], "", -5, [["expression", "[groupSelectedUnits player] spawn PAR_unblock_AI"]], "1", "1"]
		]];

		// Cannot DisAssemble
		inGameUISetEventHandler ["Action", "if (_this select 3 == 'DisAssemble') then { hintSilent 'You are not allowed to do this';true}"];
	};

	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		1 fadeSound ( NRE_vehvolume / 100.0 );
		NRE_EarplugsActive = 1;
		_this spawn vehicle_permissions;
		_this spawn vehicle_defense;
		[player, "hide"] remoteExec ["dog_action_remote_call", 2];
	}];

	_unit removeAllEventHandlers "GetOutMan";
	_unit addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle"];
		1 fadeSound 1;
		NRE_EarplugsActive = 0;
		if ( (getPos _unit) select 2 > 20 ) then {
			[_vehicle, _unit] spawn PAR_fn_eject;
		} else {
			_unit selectWeapon primaryWeapon _unit;
			[_unit, "show"] remoteExec ["dog_action_remote_call", 2];
		};
	}];

};

