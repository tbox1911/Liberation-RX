params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

// Delete Cargo
{[_x] remoteExec ["deleteVehicle", 0]} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);

//unTow
_towed = _vehicle getVariable ["R3F_LOG_remorque", objNull];
if (!isNull _towed) then {
	[_towed] call R3F_LOG_FNCT_remorqueur_detacher;
};

// Delete GR Cargo
if ( _vehicle getVariable ["GRLIB_ammo_truck_load", 0] >= 1 ) then {
	{
		if (typeOf _x in [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename]) then {
			[_x] remoteExec ["detach", 0];
			[_x, 1] remoteExec ["setDamage", 0];
		};
	} foreach (attachedObjects _vehicle);
};

// Delete Crew
{if (! alive _x) then {[_x] remoteExec ["deleteVehicle", 0]}} forEach crew _vehicle;
_vehicle removeAllEventHandlers "HandleDamage";