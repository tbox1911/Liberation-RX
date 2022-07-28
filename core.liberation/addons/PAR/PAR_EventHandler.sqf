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

// Cannot DisAssemble
_unit enableWeaponDisassembly false;

// Check Veh perms
_unit addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle"];
	if (_this call vehicle_permissions) then {
		_vehicle spawn vehicle_defense;
	};
}];

_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];

_unit addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle"];
	if (_vehicle == getConnectedUAV player) then {
		objNull remoteControl _unit;
		player switchCamera cameraView;
	};
}];

_unit addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	_ret = false;
	if (!([_unit, _container] call is_owner) || locked _container > 1) then {
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
		if (([_unit, "FOB", GRLIB_fob_range] call F_check_near || [player, "LHD", 500] call F_check_near) && _weapon == "Put") then {deleteVehicle _projectile};
	};
}];

// Player
if (_unit == player) then {
	// Unblock units
	missionNamespace setVariable [
	"BIS_fnc_addCommMenuItem_menu", [
		["Do it !", true],
		["Unblock unit.", [2], "", -5, [["expression", "[groupSelectedUnits player] spawn PAR_unblock_AI"]], "1", "1"]
	]];

	// Cannot DisAssemble
	inGameUISetEventHandler ["Action", "if (_this select 3 == 'DisAssemble') then { hintSilent 'You are not allowed to do this';true}"];

	// Get in Vehicle
	_unit removeAllEventHandlers "GetInMan";
	_unit addEventHandler ["GetInMan", {
		params ["_unit", "_role", "_vehicle"];
		1 fadeSound ( NRE_vehvolume / 100.0 );
		NRE_EarplugsActive = 1;
		[player, "hide"] remoteExec ["dog_action_remote_call", 2];
		if (!GRLIB_thermic && !(daytime > GRLIB_nights_start || daytime < GRLIB_nights_stop)) then { _vehicle disableTIEquipment true };
		if (_this call vehicle_permissions) then {
			_vehicle spawn vehicle_defense;
		};
	}];

	// Get out Vehicle
	_unit removeAllEventHandlers "GetOutMan";
	_unit addEventHandler ["GetOutMan", {
		params ["_unit", "_role", "_vehicle"];
		1 fadeSound 1;
		NRE_EarplugsActive = 0;
		if ( (getPos _unit) select 2 > 20 && !(_unit getVariable ["AR_Is_Rappelling",false]) ) then {
			[_vehicle, _unit] spawn PAR_fn_eject;
		};
		[_unit] spawn {
			params ["_unit"];
			waitUntil {sleep 1; isTouchingGround _unit};
			if (primaryWeapon _unit != "") then { _unit selectWeapon primaryWeapon _unit };
			[_unit, "show"] remoteExec ["dog_action_remote_call", 2];
		};
	}];

};
