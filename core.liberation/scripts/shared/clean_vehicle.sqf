params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

// unTow
_towed = _vehicle getVariable ["R3F_LOG_remorque", objNull];
if (!isNull _towed) then {
	[_towed] remoteExec ["R3F_LOG_FNCT_remorqueur_detacher", 0];
};

// Delete R3F Cargo
{[_x] remoteExec ["deleteVehicle", 0]} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
_vehicle setVariable ["R3F_LOG_objets_charges", [], true];

// Delete GRLIB Cargo
if ( _vehicle getVariable ["GRLIB_ammo_truck_load", 0] >= 1 ) then {
	{
		if (typeOf _x in [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename, fuelbarrel_typename]) then {
			[_x] remoteExec ["detach", 0];
			[_x, 1] remoteExec ["setDamage", 0];
		} else {
			[_x] remoteExec ["deleteVehicle", 0];
		};
	} foreach (attachedObjects _vehicle);
};

//Delete A3 Cargo
clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

// Delete Crew
{if (! alive _x) then {[_x] remoteExec ["deleteVehicle", 0]}} forEach crew _vehicle;
_vehicle removeAllEventHandlers "HandleDamage";