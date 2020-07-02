params ["_unit"];
// Cleanup
{_unit removeAllEventHandlers _x} count ["GetInMan","GetOutMan","SeatSwitchedMan","InventoryOpened","InventoryClosed","FiredMan"];

// For all
// Check Veh perms
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
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
		hintSilent format ["Your Loadout Price: %1.", ([_unit] call F_loadoutPrice)];
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

// No mines in the base zone + pay artillery fire
_unit addEventHandler ["FiredMan",	{
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

	if (count GRLIB_all_fobs >= 0) then {
		if (((_unit distance2D ([] call F_getNearestFob) < GRLIB_fob_range) || (_unit distance2D lhd < 500)) && _weapon == "Put") then {deleteVehicle _projectile};
	};

	if (typeOf _vehicle in vehicle_artillery) then {
		private _cost = 5;
		private _ammo_collected = player getVariable ["GREUH_ammo_count",0];
		if (_ammo_collected >= 5) then {
    		player setVariable ["GREUH_ammo_count", (_ammo_collected - _cost), true];
			gamelogic globalChat (format ["Artillery fire cost %1 Ammo.", _cost]);
		} else {
			gamelogic globalChat "Not enough Ammo, Artillery fire canceled.";
			deleteVehicle _projectile;
		};
	};
}];

if (_unit == player && alive player && player isKindOf "Man") then {
	// ACE specific
	if (GRLIB_ACE_enabled) then {
		["ace_arsenal_displayClosed", {[player] call F_payLoadout}] call CBA_fnc_addEventHandler;
	} else {
		// Clean player body
		_unit removeAllEventHandlers "Killed";
		_unit addEventHandler ["Killed", {
			params ["_unit"];
			[_unit] spawn {
				waitUntil {sleep 1; alive player};
				hidebody (_this select 0);
				1 fadeSound 1;
				1 fadeRadio 1;
				NRE_EarplugsActive = 0;
			};
		}];
		// Filter and Pay Loadout
		[missionNamespace, "arsenalClosed", {[player] call F_filterLoadout;[player] call F_payLoadout}] call BIS_fnc_addScriptedEventHandler;
	};

	missionNamespace setVariable [
	"BIS_fnc_addCommMenuItem_menu", [
		["Do it !", true],
		["Unblock unit.", [2], "", -5, [["expression", "[groupSelectedUnits player] spawn FAR_unblock_AI"]], "1", "1"]
	]];

	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		1 fadeSound ( NRE_vehvolume / 100.0 );
		NRE_EarplugsActive = 1;
		_this spawn vehicle_permissions;
		[player, "hide"] remoteExec ["dog_action_remote_call", 2];
	}];

	_unit removeAllEventHandlers "GetOutMan";
	_unit addEventHandler ["GetOutMan", {
		1 fadeSound 1;
		NRE_EarplugsActive = 0;
		_pos = getPos player;
		if ( _pos select 2 > 80 ) then {
			[player, _pos] spawn paraDrop;
		} else {
			player selectWeapon primaryWeapon player;
			[player, "show"] remoteExec ["dog_action_remote_call", 2];
		};
	}];
};